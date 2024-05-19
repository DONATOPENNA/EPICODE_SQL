/*Esercizio 1

Elencate il numero di tracce per ogni genere in ordine discendente, escludendo quei generi che hanno meno di 10 tracce. */

SELECT G.NAME GENRE_NAME, COUNT(DISTINCT T.NAME) AS NUM_TRACK
FROM TRACK T
LEFT JOIN GENRE G ON T.GENREID=G.GENREID
GROUP BY G.NAME
HAVING NUM_TRACK>=10
ORDER BY NUM_TRACK DESC;

/*
SELECT G.NAME GENRE_NAME, COUNT(DISTINCT T.NAME) AS NUM_TRACK
FROM TRACK T
RIGHT JOIN GENRE G ON T.GENREID=G.GENREID
GROUP BY G.NAME
-- HAVING NUM_TRACK>=10
ORDER BY NUM_TRACK DESC; */

/* Esercizio 2

Trovate le tre canzoni più costose. */

SELECT *
FROM TRACK T
WHERE MEDIATYPEID <> 3
ORDER BY UNITPRICE DESC
LIMIT 3;


/* Esercizio 3

Elencate gli artisti che hanno canzoni più lunghe di 6 minuti. */ 


SELECT  DISTINCT
AR.NAME
FROM TRACK T
LEFT JOIN ALBUM AL ON T.ALBUMID=AL.ALBUMID
LEFT JOIN ARTIST AR ON AR.ARTISTID=AL.ARTISTID
WHERE T.MILLISECONDS > 360000;



/* Esercizio 4

Individuate la durata media delle tracce per ogni genere. */

SELECT 
    G.NAME AS GENRE,
    M.NAME AS MEDIATYPE,
    CAST(AVG(MILLISECONDS) / 1000 AS DECIMAL(7,3)) AS AVG_DURATION_SEC,
    CAST(AVG(MILLISECONDS) / 60000 AS DECIMAL(5,3)) AS AVG_DURATION_MIN
FROM
    TRACK T
        LEFT JOIN
    GENRE G ON T.GENREID = G.GENREID
		LEFT JOIN
    MEDIATYPE M ON T.MEDIATYPEID = M.MEDIATYPEID
GROUP BY G.NAME,    M.NAME
ORDER BY G.NAME DESC;


/* Esercizio 5

Elencate tutte le canzoni con la parola “Love” nel titolo, ordinandole alfabeticamente prima per genere e poi per nome. */

SELECT G.NAME AS GENRE_NAME, T.NAME AS TRACK_NAME
FROM TRACK T
LEFT JOIN GENRE G ON T.GENREID=G.GENREID
WHERE T.NAME LIKE '%LOVE%'
AND T.NAME NOT LIKE '%LLOVE%'
-- AND T.NAME NOT LIKE '%BELOVE%'
ORDER BY G.NAME, T.NAME;

/* Esercizio 6

Trovate il costo medio per ogni tipologia di media. */

SELECT M.NAME AS MEDIATYPE_NAME, cast(avg(UNITPRICE) as decimal(10,2)) AS AVG_PRICE
FROM TRACK T
LEFT JOIN MEDIATYPE M ON T.MEDIATYPEID=M.MEDIATYPEID
GROUP BY M.NAME
ORDER BY AVG_PRICE DESC;

/* Esercizio 7

Individuate il genere con più tracce. */

SELECT G.NAME AS GENRE_NAME
FROM TRACK T
LEFT JOIN GENRE G ON T.GENREID=G.GENREID
GROUP BY G.NAME
HAVING COUNT(DISTINCT T.NAME)=(SELECT MAX(NUM_TRACK)
					FROM(SELECT G.NAME AS GENRE_NAME, COUNT(DISTINCT T.NAME) AS NUM_TRACK
							FROM TRACK T
							LEFT JOIN GENRE G ON T.GENREID=G.GENREID
							GROUP BY G.NAME) A );



/* Esercizio 8

Trovate gli artisti che hanno lo stesso numero di album dei Rolling Stones.*/



SELECT AR.NAME ARTISTA, COUNT(AL.TITLE) AS NUM_ALBUM
FROM ALBUM AL 
LEFT JOIN ARTIST  AR ON AL.ARTISTID=AR.ARTISTID
GROUP BY AR.NAME
HAVING NUM_ALBUM=(	SELECT COUNT(AL.TITLE) AS NUM_ALBUM
					FROM ALBUM AL 
					LEFT JOIN ARTIST  AR  ON AL.ARTISTID=AR.ARTISTID
					WHERE AR.NAME = 'The Rolling Stones') ;


/* Esercizio 9

Trovate l’artista con l’album più costoso. */

SELECT AR.NAME ARTIST, AL.TITLE ALBUM -- , SUM(T.UNITPRICE) AS ALBUM_PRICE
FROM TRACK T
LEFT JOIN ALBUM AL ON T.ALBUMID=AL.ALBUMID
LEFT JOIN ARTIST AR ON AL.ARTISTID=AR.ARTISTID
GROUP BY AR.NAME, AL.TITLE
HAVING SUM(T.UNITPRICE)=(	SELECT MAX(ALBUM_PRICE)
							FROM(
							SELECT AR.NAME ARTIST, AL.TITLE ALBUM, SUM(T.UNITPRICE) AS ALBUM_PRICE
							FROM TRACK T
							LEFT JOIN ALBUM AL ON T.ALBUMID=AL.ALBUMID
							LEFT JOIN ARTIST AR ON AL.ARTISTID=AR.ARTISTID
							GROUP BY AR.NAME, AL.TITLE)A);


