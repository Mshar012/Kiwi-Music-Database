

-- 1.This query counts the number of songs each producer has worked on.
SELECT p.StudioName, COUNT(pr.SID) AS SongCount
FROM PRODUCER p
INNER JOIN Produces pr ON p.ProducerUID = pr.ProducerUID
GROUP BY p.StudioName;

-- 2. List all users with the playlists they have created
SELECT U.FName, U.LName, P.PLName
FROM USER U
LEFT JOIN PLAYLIST P ON U.UID = P.UID;

-- 3. Show playlist name that has the word "Relaxing"
select plname as Playlist_Name from playlist where pldescription like "%relaxing%";


-- 4. Display all songs in each playlist with the track position
SELECT PL.PLName, S.STitle, PT.PLTListPosition
FROM PLAYLIST PL
JOIN PLAYLIST_TRACK PT ON PL.PLID = PT.PLID
JOIN SONG S ON PT.SID = S.SID
ORDER BY PL.PLName, PT.PLTListPosition;

-- 5. List the producers and the songs they have produced
SELECT P.StudioName, S.STitle
FROM PRODUCER P
INNER JOIN Produces Pr ON P.ProducerUID = Pr.ProducerUID
INNER JOIN SONG S ON Pr.SID = S.SID;

-- 6. Get all events with ticket price, along with the users who are interested
SELECT E.EName, E.TicketPrice, U.FName, U.LName
FROM EVENT E
LEFT JOIN InterestedIn I ON E.EID = I.EID
LEFT JOIN USER U ON I.UID = U.UID;

-- 7. Get the average ticket price for all the events
SELECT ROUND(AVG(TicketPrice),2) AS Average_Ticket_Price_AllEvents from Event; 

-- 8. List all songs in the database, including their genre
SELECT S.STitle, SG.Genre
FROM SONG S
INNER JOIN SONG_Genre SG ON S.SID = SG.SID;

-- 9. Show all Users who are born after the year 1994
select concat(FName,' ',LName) AS Name from user 
where YEAR(UBirthDate)>1994;


-- 10. Show the users who follow each other
SELECT F1.FollowsUID_2 AS Follower, F2.FollowsUID_2 AS Followed
FROM Follows F1
INNER JOIN Follows F2 ON F1.UID_1 = F2.FollowsUID_2 AND F1.FollowsUID_2 = F2.UID_1;

-- 11. Display all users with events they are interested in (using OUTER JOIN)
SELECT U.FName, U.LName, E.EName, E.EDate
FROM USER U
LEFT OUTER JOIN InterestedIn I ON U.UID = I.UID
LEFT OUTER JOIN EVENT E ON I.EID = E.EID
ORDER BY U.FName;