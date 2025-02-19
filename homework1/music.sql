-- Создание таблицы Жанр
CREATE TABLE Genre (
    id_genre SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Создание таблицы Исполнитель
CREATE TABLE Artist (
    id_artist SERIAL PRIMARY KEY,
    artist_name VARCHAR(255) NOT NULL
);

-- Создание таблицы Альбом
CREATE TABLE Album (
    id_album SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year SMALLINT NOT NULL  -- Или INTEGER, или DATE
);

-- Создание таблицы Трек
CREATE TABLE Track (
    id_track SERIAL PRIMARY KEY,
    track_name VARCHAR(255) NOT NULL,
    duration TIME NOT NULL,
    id_album INT REFERENCES Album(id_album)  -- Упрощенный синтаксис FOREIGN KEY
);

-- Создание таблицы Сборник
CREATE TABLE Collection (
    id_collection SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year SMALLINT NOT NULL  -- Или INTEGER, или DATE
);

-- Создание таблицы для связи "Исполнитель - Жанр"
CREATE TABLE Artist_Genre (
    id_artist INT REFERENCES Artist(id_artist),  -- Упрощенный синтаксис FOREIGN KEY
    id_genre INT REFERENCES Genre(id_genre),  -- Упрощенный синтаксис FOREIGN KEY
    PRIMARY KEY (id_artist, id_genre)
);

-- Создание таблицы для связи "Исполнитель - Альбом"
CREATE TABLE Artist_Album (
    id_artist INT REFERENCES Artist(id_artist),  -- Упрощенный синтаксис FOREIGN KEY
    id_album INT REFERENCES Album(id_album),  -- Упрощенный синтаксис FOREIGN KEY
    PRIMARY KEY (id_artist, id_album)
);

-- Создание таблицы для связи "Сборник - Трек"
CREATE TABLE Collection_Track (
    id_collection INT REFERENCES Collection(id_collection),  -- Упрощенный синтаксис FOREIGN KEY
    id_track INT REFERENCES Track(id_track),  -- Упрощенный синтаксис FOREIGN KEY
    PRIMARY KEY (id_collection, id_track)
);