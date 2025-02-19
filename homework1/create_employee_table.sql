CREATE TABLE Employee (
    employee_id SERIAL PRIMARY KEY,          -- Уникальный идентификатор сотрудника
    name VARCHAR(255) NOT NULL,              -- Имя сотрудника
    department VARCHAR(255),                 -- Отдел сотрудника (строка)
    manager_id INT,                          -- Идентификатор начальника
    FOREIGN KEY (manager_id) REFERENCES Employee(employee_id)  -- Ссылка на начальника
);
