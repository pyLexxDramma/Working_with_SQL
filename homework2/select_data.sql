-- 1. Название и продолжительность самого длительного трека
SELECT track_name, duration
FROM public.track
ORDER BY duration DESC
LIMIT 1;

-- 2. Название треков, продолжительность которых не менее 3,5 минут
SELECT track_name
FROM public.track
WHERE duration >= '00:03:30';

-- 3. Названия сборников, вышедших в период с 2018 по 2020 год включительно
SELECT title
FROM public.collection
WHERE release_year BETWEEN 2018 AND 2020;

-- 4. Исполнители, чьё имя состоит из одного слова
SELECT artist_name
FROM public.artist
WHERE artist_name NOT LIKE '% %';

-- 5. Название треков, которые содержат слово «мой» или «my»
SELECT track_name
FROM public.track
WHERE LOWER(track_name) LIKE '%мой%' OR LOWER(track_name) LIKE '%my%';




-- 1. Количество исполнителей в каждом жанре
SELECT g.name, COUNT(ag.id_artist)
FROM public.genre g
JOIN public.artist_genres ag ON g.id_genre = ag.id_genre
GROUP BY g.name
ORDER BY COUNT(ag.id_artist) DESC;

-- 2. Количество треков, вошедших в альбомы 2019–2020 годов
SELECT COUNT(t.id_track)
FROM public.track t
JOIN public.album a ON t.id_album = a.id_album
WHERE a.release_year BETWEEN 2019 AND 2020;

-- 3. Средняя продолжительность треков по каждому альбому
SELECT a.title, AVG(EXTRACT(EPOCH FROM t.duration)) AS average_duration_seconds
FROM public.album a
JOIN public.track t ON a.id_album = t.id_album
GROUP BY a.title
ORDER BY average_duration_seconds DESC;

-- 4. Все исполнители, которые не выпустили альбомы в 2020 году
SELECT artist_name
FROM public.artist
WHERE id_artist NOT IN (
    SELECT aa.id_artist
    FROM public.artist_albums aa
    JOIN public.album a ON aa.id_album = a.id_album
    WHERE a.release_year = 2020
);

-- 5. Названия сборников, в которых присутствует конкретный исполнитель (например, Taylor Swift)
SELECT DISTINCT c.title
FROM public.collection c
JOIN public.collection_tracks ct ON c.id_collection = ct.id_collection
JOIN public.track t ON ct.id_track = t.id_track
JOIN public.album a ON t.id_album = a.id_album
JOIN public.artist_albums aa ON a.id_album = aa.id_album
JOIN public.artist ar ON aa.id_artist = ar.id_artist
WHERE ar.artist_name = 'Taylor Swift';



-- 1. Названия альбомов, в которых присутствуют исполнители более чем одного жанра
SELECT DISTINCT al.title
FROM public.album al
JOIN public.artist_albums aa ON al.id_album = aa.id_album
JOIN public.artist ar ON aa.id_artist = ar.id_artist
WHERE ar.id_artist IN (SELECT id_artist FROM public.artist_genres GROUP BY id_artist HAVING COUNT(id_genre) > 1);

-- 2. Наименования треков, которые не входят в сборники
SELECT track_name
FROM public.track
WHERE id_track NOT IN (SELECT id_track FROM public.collection_tracks);

-- 3. Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько
SELECT ar.artist_name
FROM public.artist ar
JOIN public.artist_albums aa ON ar.id_artist = aa.id_artist
JOIN public.album al ON aa.id_album = al.id_album
JOIN public.track t ON al.id_album = t.id_album
WHERE t.duration = (SELECT MIN(duration) FROM public.track);

-- 4. Названия альбомов, содержащих наименьшее количество треков
SELECT al.title
FROM public.album al
WHERE al.id_album IN (
    SELECT id_album
    FROM (
        SELECT id_album, COUNT(*) as track_count
        FROM public.track
        GROUP BY id_album
    ) AS album_track_counts
    WHERE track_count = (SELECT MIN(track_count) FROM (SELECT id_album, COUNT(*) as track_count FROM public.track GROUP BY id_album) AS min_track_counts)
);