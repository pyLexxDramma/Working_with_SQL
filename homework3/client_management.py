import psycopg2

def create_db(conn):
    with conn.cursor() as cursor:
        cursor.execute("""
        CREATE TABLE IF NOT EXISTS clients (
            id SERIAL PRIMARY KEY,
            first_name VARCHAR(100),
            last_name VARCHAR(100),
            email VARCHAR(100) UNIQUE
        );
        CREATE TABLE IF NOT EXISTS phones (
            id SERIAL PRIMARY KEY,
            client_id INTEGER REFERENCES clients(id),
            phone VARCHAR(15)
        );
        """)
        conn.commit()

def add_client(conn, first_name, last_name, email, phones=None):
    with conn.cursor() as cursor:
        cursor.execute("""
        INSERT INTO clients (first_name, last_name, email) VALUES (%s, %s, %s) RETURNING id;
        """, (first_name, last_name, email))
        client_id = cursor.fetchone()[0]
        if phones:
            for phone in phones:
                add_phone(conn, client_id, phone)
        conn.commit()
        return client_id

def add_phone(conn, client_id, phone):
    with conn.cursor() as cursor:
        cursor.execute("""
        INSERT INTO phones (client_id, phone) VALUES (%s, %s);
        """, (client_id, phone))
        conn.commit()

def change_client(conn, client_id, first_name=None, last_name=None, email=None, phones=None):
    with conn.cursor() as cursor:
        if first_name:
            cursor.execute("UPDATE clients SET first_name = %s WHERE id = %s;", (first_name, client_id))
        if last_name:
            cursor.execute("UPDATE clients SET last_name = %s WHERE id = %s;", (last_name, client_id))
        if email:
            cursor.execute("UPDATE clients SET email = %s WHERE id = %s;", (email, client_id))
        if phones is not None:
            cursor.execute("DELETE FROM phones WHERE client_id = %s;", (client_id,))
            for phone in phones:
                add_phone(conn, client_id, phone)
        conn.commit()

def delete_phone(conn, client_id, phone):
    with conn.cursor() as cursor:
        cursor.execute("DELETE FROM phones WHERE client_id = %s AND phone = %s;", (client_id, phone))
        conn.commit()

def delete_client(conn, client_id):
    with conn.cursor() as cursor:
        cursor.execute("DELETE FROM phones WHERE client_id = %s;", (client_id,))
        cursor.execute("DELETE FROM clients WHERE id = %s;", (client_id,))
        conn.commit()

def find_client(conn, first_name=None, last_name=None, email=None, phone=None):
    with conn.cursor() as cursor:
        query = "SELECT c.id, c.first_name, c.last_name, c.email, array_agg(p.phone) FROM clients c LEFT JOIN phones p ON c.id = p.client_id WHERE TRUE"
        params = []
        if first_name:
            query += " AND c.first_name ILIKE %s"
            params.append(f"%{first_name}%")
        if last_name:
            query += " AND c.last_name ILIKE %s"
            params.append(f"%{last_name}%")
        if email:
            query += " AND c.email ILIKE %s"
            params.append(f"%{email}%")
        if phone:
            query += " AND p.phone ILIKE %s"
            params.append(f"%{phone}%")
        query += " GROUP BY c.id;"
        cursor.execute(query, params)
        return cursor.fetchall()

# Пример использования
with psycopg2.connect(database="clients_db", user="postgres", password="postgres") as conn:
    create_db(conn)
    client_id = add_client(conn, "Алексей", "Темников", "lexxdramma@vk.com", ["123456789", "987654321"])
    print("Добавлен клиент с ID:", client_id)
    
    add_phone(conn, client_id, "89953377717")
    print("Добавлен телефон для клиента:", client_id)
    
    change_client(conn, client_id, email="lexxdramma@vk.com")
    print("Изменены данные клиента:", client_id)
    
    clients = find_client(conn, first_name="Алексей")
    print("Найденные клиенты:", clients)
    
    delete_phone(conn, client_id, "123456789")
    print("Удален телефон для клиента:", client_id)
    
    delete_client(conn, client_id)
    print("Удален клиент с ID:", client_id)

conn.close()
