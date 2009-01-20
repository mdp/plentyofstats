SELECT age, zipcode, gender, result / (SELECT max(result) FROM stats WHERE zipcode = '30309' AND gender = 'f') AS normalized_result FROM stats WHERE scrape_id = '1' OR scrape_id = '2';
SELECT age, zipcode, gender, (result + 0.0) / (SELECT max(result) FROM stats WHERE zipcode = s1.zipcode AND gender = s1.gender) AS normalized_result FROM stats as s1 WHERE scrape_id = '1' OR scrape_id = '2';
