-- Заполнение таблицы Жанр
INSERT INTO public.genre (name) VALUES
('Pop'),
('Rock'),
('Hip-Hop');

-- Заполнение таблицы Исполнитель
INSERT INTO public.artist (artist_name) VALUES
('Taylor Swift'),
('Queen'),
('Eminem'),
('Beyoncé');

-- Заполнение таблицы Альбом
INSERT INTO public.album (title, release_year) VALUES
('1989', 2014),
('A Night at the Opera', 1975),
('The Marshall Mathers LP', 2000),
('Fearless', 2008),
('Dangerously in Love', 2003);

-- Заполнение таблицы Трек
INSERT INTO public.track (track_name, duration, id_album) VALUES
('Shake It Off', '00:03:39', 1),
('Bohemian Rhapsody', '00:05:55', 2),
('The Real Slim Shady', '00:04:44', 3),
('Love Story', '00:03:55', 4),
('We Are the Champions', '00:02:59', 2),
('Lose Yourself', '00:05:20', 3),
('Crazy in Love', '00:03:56', 5);

-- Заполнение таблицы Сборник
INSERT INTO public.collection (title, release_year) VALUES
('Greatest Hits Pop', 2020),
('Rock Anthems', 2015),
('Hip-Hop Classics', 2010),
('Best of 2000s', 2009);

-- Заполнение таблицы artist_genres (Связь Исполнитель - Жанр)
INSERT INTO public.artist_genres (id_artist, id_genre) VALUES
(1, 1),  -- Taylor Swift - Pop
(2, 2),  -- Queen - Rock
(3, 3),  -- Eminem - Hip-Hop
(4, 1);  -- Beyoncé - Pop

-- Заполнение таблицы artist_albums (Связь Исполнитель - Альбом)
INSERT INTO public.artist_albums (id_artist, id_album) VALUES
(1, 1),  -- Taylor Swift - 1989
(2, 2),  -- Queen - A Night at the Opera
(3, 3),  -- Eminem - The Marshall Mathers LP
(1, 4),  -- Taylor Swift - Fearless
(4, 5);  -- Beyoncé - Dangerously in Love

-- Заполнение таблицы collection_tracks (Связь Сборник - Трек)
INSERT INTO public.collection_tracks (id_collection, id_track) VALUES
(1, 1),  -- Greatest Hits Pop - Shake It Off
(2, 2),  -- Rock Anthems - Bohemian Rhapsody
(3, 3),  -- Hip-Hop Classics - The Real Slim Shady
(1, 4),  -- Greatest Hits Pop - Love Story
(2, 5),  -- Rock Anthems - We Are the Champions
(3, 6),  -- Hip-Hop Classics - Lose Yourself
(4, 7);  -- Best of 2000s - Crazy in Love