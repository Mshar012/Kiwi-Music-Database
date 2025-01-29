

CREATE TABLE USER
(
  UID CHAR(8) NOT NULL,
  Username CHAR(10) NOT NULL,
  UPassword VARCHAR(12) NOT NULL,
  UBirthDate DATE NOT NULL,
  ULocation VARCHAR(50) NOT NULL,
  UEmail VARCHAR(50) NOT NULL,
  FName VARCHAR(25) NOT NULL,
  LName VARCHAR(25) NOT NULL,
  PRIMARY KEY (UID),
  UNIQUE (Username),
  UNIQUE (UEmail)
);
INSERT INTO USER (UID, Username, UPassword, UBirthDate, ULocation, UEmail, FName, LName) VALUES
('U001', 'john_doe', 'password123', '1995-02-10', 'New York, USA', 'john.doe@example.com', 'John', 'Doe'),
('U002', 'jane_smith', 'mypassword1', '1997-08-22', 'Los Angeles, USA', 'jane.smith@example.com', 'Jane', 'Smith'),
('U003', 'alex_lee', 'alex12345', '1994-03-30', 'Chicago, USA', 'alex.lee@example.com', 'Alex', 'Lee'),
('U004', 'emma_jones', 'emma12345', '1996-11-17', 'San Francisco, USA', 'emma.jones@example.com', 'Emma', 'Jones'),
('U005', 'mike_brown', 'password987', '1993-06-05', 'Miami, USA', 'mike.brown@example.com', 'Mike', 'Brown');

CREATE TABLE PRODUCER
(
  StudioName VARCHAR(50) NOT NULL,
  LabelAffiliation VARCHAR(50),
  ProducerUID CHAR(8) NOT NULL,
  PRIMARY KEY (ProducerUID),
  FOREIGN KEY (ProducerUID) REFERENCES USER(UID)
);

INSERT INTO PRODUCER (StudioName, LabelAffiliation, ProducerUID) VALUES
('Sunset Studios', 'Universal Music', 'U001'),
('Blue Moon Productions', 'Sony Music', 'U002'),
('Echo Sound', 'Warner Music', 'U003'),
('Starwave Productions', 'Atlantic Records', 'U004'),
('Quantum Beats', 'EMI Records', 'U005');


CREATE TABLE ARTIST
(
  ArtistUID CHAR(8) NOT NULL,
  PRIMARY KEY (ArtistUID),
  FOREIGN KEY (ArtistUID) REFERENCES USER(UID)
);
INSERT INTO ARTIST (ArtistUID) VALUES
('U001'),
('U002'),
('U003'),
('U004'),
('U005');

CREATE TABLE PLAYLIST
(
  PLID CHAR(8) NOT NULL,
  PLName VARCHAR(25) NOT NULL,
  PLCreationDate DATETIME NOT NULL,
  PLDescription VARCHAR(100) NOT NULL,
  UID CHAR(8) NOT NULL,
  PRIMARY KEY (PLID),
  FOREIGN KEY (UID) REFERENCES USER(UID)
  ON DELETE CASCADE
);
INSERT INTO PLAYLIST (PLID, PLName, PLCreationDate, PLDescription, UID) VALUES
('PL001', 'Chill Vibes', '2024-11-10 14:30:00', 'A relaxing playlist to unwind after a long day.', 'U001'),
('PL002', 'Top Hits', '2024-11-12 09:00:00', 'A collection of the best chart-topping songs.', 'U002'),
('PL003', 'Workout Beats', '2024-11-05 06:30:00', 'High energy songs to boost your workout routine.', 'U003'),
('PL004', 'Indie Hits', '2024-11-03 18:45:00', 'A playlist of trending indie music for the hipster crowd.', 'U004'),
('PL005', 'Party Playlist', '2024-11-15 22:00:00', 'Non-stop hits to keep the party going all night.', 'U005');


CREATE TABLE EVENT
(
  EID CHAR(8) NOT NULL,
  EName VARCHAR(25) NOT NULL,
  EDescription VARCHAR(200) NOT NULL,
  EDate DATETIME NOT NULL,
  ELocation VARCHAR(25) NOT NULL,
  TicketPrice DECIMAL(7,2),
  PRIMARY KEY (EID)
);
INSERT INTO EVENT (EID, EName, EDescription, EDate, ELocation, TicketPrice) VALUES
('E001', 'Summer Fest', 'A grand music festival featuring live performances from top artists.', '2024-06-15 18:00:00', 'New York', 75.00),
('E002', 'Tech Summit', 'A conference where innovators showcase the latest in tech advancements and products.', '2024-07-10 09:00:00', 'San Francisco', 199.99),
('E003', 'Night Dance', 'An exciting dance event with live DJ performances and immersive experiences.', '2024-08-20 22:00:00', 'Los Angeles', 50.00),
('E004', 'Art Gala', 'An exclusive gala showcasing contemporary art, culture, and performances by renowned artists.', '2024-09-05 19:30:00', 'Chicago', 120.00),
('E005', 'Science Expo', 'An exhibition showcasing the newest scientific innovations, featuring live demos and expert talks.', '2024-10-12 10:00:00', 'Boston', 25.00);

CREATE TABLE ALBUM
(
  AID CHAR(8) NOT NULL,
  ACoverURL VARCHAR(255),
  PRIMARY KEY (AID)
);
INSERT INTO ALBUM (AID, ACoverURL) VALUES
('A001', 'https://example.com/covers/album1.jpg'),
('A002', 'https://example.com/covers/album2.jpg'),
('A003', 'https://example.com/covers/album3.jpg'),
('A004', 'https://example.com/covers/album4.jpg'),
('A005', 'https://example.com/covers/album5.jpg');

CREATE TABLE Performs
(
  EID CHAR(8) NOT NULL,
  ArtistUID CHAR(8) NOT NULL,
  PRIMARY KEY (EID, ArtistUID),
  FOREIGN KEY (EID) REFERENCES EVENT(EID),
  FOREIGN KEY (ArtistUID) REFERENCES ARTIST(ArtistUID)
);
INSERT INTO Performs (EID, ArtistUID) VALUES
('E001', 'U001'),
('E002', 'U002'),
('E003', 'U003'),
('E004', 'U004'),
('E005', 'U005');

CREATE TABLE InterestedIn
(
  UID CHAR(8) NOT NULL,
  EID CHAR(8) NOT NULL,
  PRIMARY KEY (UID, EID),
  FOREIGN KEY (UID) REFERENCES USER(UID),
  FOREIGN KEY (EID) REFERENCES EVENT(EID)
);
-- Insert into InterestedIn
INSERT INTO InterestedIn (UID, EID) VALUES
('U001', 'E001'),
('U002', 'E002'),
('U003', 'E003'),
('U004', 'E004'),
('U005', 'E005');



CREATE TABLE Uploads
(
  ArtistUID CHAR(8) NOT NULL,
  AID CHAR(8) NOT NULL,
  PRIMARY KEY (ArtistUID, AID),
  FOREIGN KEY (ArtistUID) REFERENCES ARTIST(ArtistUID),
  FOREIGN KEY (AID) REFERENCES ALBUM(AID)
);
-- Insert into Uploads
INSERT INTO Uploads (ArtistUID, AID) VALUES
('U001', 'A001'),
('U002', 'A002'),
('U003', 'A003'),
('U004', 'A004'),
('U005', 'A005');

CREATE TABLE Follows
(
  UID_1 CHAR(8) NOT NULL,
  FollowsUID_2 CHAR(8) NOT NULL,
  PRIMARY KEY (UID_1, FollowsUID_2),
  FOREIGN KEY (UID_1) REFERENCES USER(UID),
  FOREIGN KEY (FollowsUID_2) REFERENCES USER(UID)
);
-- Insert into Follows
INSERT INTO Follows (UID_1, FollowsUID_2) VALUES
('U001', 'U002'),
('U003', 'U004'),
('U005', 'U001'),
('U002', 'U005'),
('U004', 'U003');

CREATE TABLE EVENT_EType
(
  EType VARCHAR(12) NOT NULL,
  EID CHAR(8) NOT NULL,
  PRIMARY KEY (EType, EID),
  FOREIGN KEY (EID) REFERENCES EVENT(EID)
);
-- Insert into EVENT_EType
INSERT INTO EVENT_EType (EType, EID) VALUES
('Music', 'E001'),
('Conference', 'E002'),
('Dance', 'E003'),
('Gala', 'E004'),
('Expo', 'E005');

CREATE TABLE SONG
(
  SID CHAR(8) NOT NULL,
  STitle VARCHAR(25) NOT NULL,
  SDuration_mins FLOAT NOT NULL,
  SReleaseDate DATETIME NOT NULL,
  SLyrics VARCHAR(200) NOT NULL,
  IsExplicit ENUM("Yes","No") NOT NULL,
  AudioURL VARCHAR(255) NOT NULL,
  AID CHAR(8) NOT NULL,
  PRIMARY KEY (SID),
  FOREIGN KEY (AID) REFERENCES ALBUM(AID)
);
-- Insert into SONG
INSERT INTO SONG (SID, STitle, SDuration_mins, SReleaseDate, SLyrics, IsExplicit, AudioURL, AID) VALUES
('S001', 'Summer Vibes', 3.45, '2024-06-01 00:00:00', 'Living the moment under the summer sky', 'No', 'http://example.com/audio/summer_vibes.mp3', 'A001'),
('S002', 'Tech Beats', 4.15, '2024-07-10 00:00:00', 'Innovation is the future of sound', 'No', 'http://example.com/audio/tech_beats.mp3', 'A002'),
('S003', 'Dance Forever', 5.00, '2024-08-20 00:00:00', 'Let the rhythm take over your soul', 'Yes', 'http://example.com/audio/dance_forever.mp3', 'A003'),
('S004', 'ArtHound', 6.30, '2024-09-05 00:00:00', 'The canvas of music awaits', 'No', 'http://example.com/audio/art_of_sound.mp3', 'A004'),
('S005', 'ScienceBeats', 3.50, '2024-10-12 00:00:00', 'Exploring the universe of musical theory', 'No', 'http://example.com/audio/science_of_music.mp3', 'A005');


CREATE TABLE PLAYLIST_TRACK
(
  PLTDateAdded DATETIME NOT NULL,
  PLTListPosition CHAR(4) NOT NULL,
  PLID CHAR(8) NOT NULL,
  SID CHAR(8) NOT NULL,
  PRIMARY KEY (PLTListPosition, PLID, SID),
  FOREIGN KEY (PLID) REFERENCES PLAYLIST(PLID),
  FOREIGN KEY (SID) REFERENCES SONG(SID)
);
-- Insert into PLAYLIST_TRACK
INSERT INTO PLAYLIST_TRACK (PLTDateAdded, PLTListPosition, PLID, SID) VALUES
('2024-06-01 12:00:00', '001', 'PL001', 'S001'),
('2024-07-10 15:30:00', '002', 'PL001', 'S002'),
('2024-08-20 10:15:00', '003', 'PL002', 'S003'),
('2024-09-05 18:45:00', '001', 'PL002', 'S004'),
('2024-10-12 09:00:00', '004', 'PL003', 'S005');

CREATE TABLE Plays
(
  UID CHAR(8) NOT NULL,
  SID CHAR(8) NOT NULL,
  PRIMARY KEY (UID, SID),
  FOREIGN KEY (UID) REFERENCES USER(UID),
  FOREIGN KEY (SID) REFERENCES SONG(SID)
);
-- Insert into Plays
INSERT INTO Plays (UID, SID) VALUES
('U001', 'S001'),
('U002', 'S002'),
('U003', 'S003'),
('U004', 'S004'),
('U005', 'S005');


CREATE TABLE Produces
(
  ProducerUID CHAR(8) NOT NULL,
  SID CHAR(8) NOT NULL,
  PRIMARY KEY (ProducerUID, SID),
  FOREIGN KEY (ProducerUID) REFERENCES PRODUCER(ProducerUID),
  FOREIGN KEY (SID) REFERENCES SONG(SID)
);
-- Insert into Produces
INSERT INTO Produces (ProducerUID, SID) VALUES
('U001', 'S001'),
('U002', 'S002'),
('U003', 'S003'),
('U004', 'S004'),
('U005', 'S005');


CREATE TABLE Featured_In
(
  SID CHAR(8) NOT NULL,
  ArtistUID CHAR(8) NOT NULL,
  PRIMARY KEY (SID, ArtistUID),
  FOREIGN KEY (SID) REFERENCES SONG(SID),
  FOREIGN KEY (ArtistUID) REFERENCES ARTIST(ArtistUID)
);
-- Insert into Featured_In
INSERT INTO Featured_In (SID, ArtistUID) VALUES
('S001', 'U001'),
('S002', 'U002'),
('S003', 'U003'),
('S004', 'U004'),
('S005', 'U005');

CREATE TABLE SONG_Genre
(
  Genre VARCHAR(25) NOT NULL,
  SID CHAR(8) NOT NULL,
  PRIMARY KEY (Genre, SID),
  FOREIGN KEY (SID) REFERENCES SONG(SID)
);
-- Insert into SONG_Genre
INSERT INTO SONG_Genre (Genre, SID) VALUES
('Pop', 'S001'),
('Rock', 'S002'),
('Hip-Hop', 'S003'),
('Jazz', 'S004'),
('Electronic', 'S005');