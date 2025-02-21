-- Задание 2

-- 1. Название и продолжительность самого длительного трека
SELECT track_name, duration
FROM Track
ORDER BY duration DESC
LIMIT 1;

-- 2. Название треков, продолжительность которых не менее 3,5 минут
SELECT track_name
FROM Track
WHERE duration >= '00:03:30';

-- 3. Названия сборников, вышедших в период с 2018 по 2020 год включительно
SELECT title
FROM Collection
WHERE release_year BETWEEN 2018 AND 2020;

-- 4. Исполнители, чьё имя состоит из одного слова
SELECT artist_name
FROM Artist
WHERE artist_name NOT LIKE '% %';

-- 5. Название треков, которые содержат слово «мой» или «my»
SELECT track_name
FROM Track
WHERE string_to_array(lower(track_name), ' ') && ARRAY['мой', 'my'];

-- Задание 3

-- 1. Количество исполнителей в каждом жанре
SELECT g.name, COUNT(ag.id_artist) AS artist_count
FROM Genre g
LEFT JOIN Artist_Genre ag ON g.id_genre = ag.id_genre
GROUP BY g.name
ORDER BY artist_count DESC;

-- 2. Количество треков, вошедших в альбомы 2019–2020 годов
SELECT COUNT(t.id_track) AS track_count
FROM Track t
JOIN Album a ON t.id_album = a.id_album
WHERE a.release_year BETWEEN 2019 AND 2020;

-- 3. Средняя продолжительность треков по каждому альбому
SELECT a.title, AVG(EXTRACT(EPOCH FROM t.duration)) AS average_duration_seconds
FROM Album a
JOIN Track t ON a.id_album = t.id_album
GROUP BY a.title
ORDER BY average_duration_seconds DESC;

-- 4. Все исполнители, которые не выпустили альбомы в 2020 году
SELECT artist_name
FROM Artist
WHERE id_artist NOT IN (
    SELECT aa.id_artist
    FROM Artist_Album aa
    JOIN Album a ON aa.id_album = a.id_album
    WHERE a.release_year = 2020
);

-- 5. Названия сборников, в которых присутствует конкретный исполнитель (например, Taylor Swift)
SELECT DISTINCT c.title
FROM Collection c
JOIN Collection_Track ct ON c.id_collection = ct.id_collection
JOIN Track t ON ct.id_track = t.id_track
JOIN Album a ON t.id_album = a.id_album
JOIN Artist_Album aa ON a.id_album = aa.id_album
JOIN Artist ar ON aa.id_artist = ar.id_artist
WHERE ar.artist_name = 'Taylor Swift';

-- Задание 4 (необязательное)

-- 1. Названия альбомов, в которых присутствуют исполнители более чем одного жанра
SELECT DISTINCT a.title
FROM Album a
JOIN Artist_Album aa ON a.id_album = aa.id_album
JOIN Artist ar ON aa.id_artist = ar.id_artist
WHERE ar.id_artist IN (
    SELECT id_artist
    FROM Artist_Genre
    GROUP BY id_artist
    HAVING COUNT(DISTINCT id_genre) > 1
);

-- 2. Наименования треков, которые не входят в сборники
SELECT track_name
FROM Track
WHERE id_track NOT IN (SELECT id_track FROM Collection_Track);

-- 3. Исполнитель или исполнители, написавшие самый короткий по продолжительности трек
SELECT ar.artist_name
FROM Artist ar
JOIN Artist_Album aa ON ar.id_artist = aa.id_artist
JOIN Album al ON aa.id_album = al.id_album
JOIN Track t ON al.id_album = t.id_album
WHERE t.duration = (SELECT MIN(duration) FROM Track);

-- 4. Названия альбомов, содержащих наименьшее количество треков
SELECT a.title
FROM Album a
JOIN Track t ON a.id_album = t.id_album
GROUP BY a.id_album
HAVING COUNT(t.id_track) = (
    SELECT MIN(track_count)
    FROM (
        SELECT COUNT(id_track) AS track_count
        FROM Track
        GROUP BY id_album
    ) AS album_track_counts
);
