-- Заполнение таблицы Жанр
INSERT INTO Genre (name) VALUES
('Pop'),
('Rock'),
('Hip-Hop');

-- Заполнение таблицы Исполнитель
INSERT INTO Artist (artist_name) VALUES
('Taylor Swift'),
('Queen'),
('Eminem'),
('Beyoncé');

-- Заполнение таблицы Альбом
INSERT INTO Album (title, release_year) VALUES
('1989', 2014),
('A Night at the Opera', 1975),
('The Marshall Mathers LP', 2000),
('Fearless', 2008);

-- Заполнение таблицы Трек
INSERT INTO Track (track_name, duration, id_album) VALUES
('Shake It Off', '00:03:39', 1),
('Bohemian Rhapsody', '00:05:55', 2),
('The Real Slim Shady', '00:04:44', 3),
('Love Story', '00:03:55', 4),
('We Are the Champions', '00:02:59', 2),
('Lose Yourself', '00:05:20', 3);
('My First Track', '00:03:15', 1),
('My Second Track', '00:04:00', 1),
('My Favorite Song', '00:02:45', 2);

-- Заполнение таблицы Сборник
INSERT INTO Collection (title, release_year) VALUES
('Greatest Hits Pop', 2020),
('Rock Anthems', 2015),
('Hip-Hop Classics', 2010),
('Best of 2000s', 2009);

-- Заполнение таблицы artist_genre (Связь Исполнитель - Жанр)
INSERT INTO Artist_Genre (id_artist, id_genre) VALUES
(1, 1),  -- Taylor Swift - Pop
(2, 2),  -- Queen - Rock
(3, 3),  -- Eminem - Hip-Hop
(4, 1);  -- Beyoncé - Pop

-- Заполнение таблицы artist_album (Связь Исполнитель - Альбом)
INSERT INTO Artist_Album (id_artist, id_album) VALUES
(1, 1),  -- Taylor Swift - 1989
(2, 2),  -- Queen - A Night at the Opera
(3, 3),  -- Eminem - The Marshall Mathers LP
(1, 4),  -- Taylor Swift - Fearless
(4, 4);  -- Beyoncé - Fearless 

-- Заполнение таблицы collection_track (Связь Сборник - Трек)
INSERT INTO Collection_Track (id_collection, id_track) VALUES
(1, 1),  -- Greatest Hits Pop - Shake It Off
(2, 2),  -- Rock Anthems - Bohemian Rhapsody
(3, 3),  -- Hip-Hop Classics - The Real Slim Shady
(1, 4),  -- Greatest Hits Pop - Love Story
(2, 5),  -- Rock Anthems - We Are the Champions
(3, 6);  -- Hip-Hop Classics - Lose Yourself
