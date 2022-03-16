-- vine table
CREATE TABLE vine_table (
  review_id TEXT PRIMARY KEY,
  star_rating INTEGER,
  helpful_votes INTEGER,
  total_votes INTEGER,
  vine TEXT,
  verified_purchase TEXT
);

CREATE TABLE Vine20Plus AS
	SELECT *
	FROM vine_table
	WHERE total_votes >= 20;

CREATE TABLE Helpful50Plus AS
	SELECT *
	FROM Vine20Plus
	WHERE helpful_votes/total_votes >= 0.5

CREATE TABLE ReviewVineProgram AS
	SELECT *
	FROM Helpful50Plus
	WHERE vine = 'Y'

CREATE TABLE ReviewNotVineProgram AS
	SELECT *
	FROM Helpful50Plus
	WHERE vine = 'N'

-- Total Number of reviews
SELECT COUNT(review_id)
FROM vine_table

-- Five-star reviews
SELECT COUNT(review_id)
FROM vine_table
WHERE star_rating = 5

SELECT vine, count(review_id)
FROM vine_table
WHERE total_votes >= 20
AND helpful_votes/total_votes >= 0.5
GROUP BY vine

"N"	7696
"Y"	23

SELECT COUNT(review_id) 
FROM ReviewVineProgram

SELECT COUNT(review_id) 
FROM ReviewNotVineProgram
