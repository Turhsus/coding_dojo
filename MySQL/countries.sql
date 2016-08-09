SELECT name, language, percentage 
FROM languages
JOIN countries 
ON countries.id = languages.country_id
WHERE language = "Slovene"
ORDER BY percentage DESC;

-- Problem 2 MySQL Countries

SELECT countries.name, COUNT(cities.country_id) AS cities
FROM countries
JOIN cities ON cities.country_id = countries.id
GROUP BY cities.country_id
ORDER BY cities DESC;

-- Problem 3 MySQL Countries

SELECT countries.name, countries.population
FROM countries
WHERE countries.population > 500000
ORDER BY population DESC;

-- Problem 4

SELECT countries.name, languages.language, languages.percentage
FROM countries
JOIN languages ON countries.id = languages.country_id
ORDER BY languages.percentage DESC;

-- Problem 5

SELECT countries.name, countries.surface_area, countries.population
FROM countries
WHERE countries.surface_area < 501 AND countries.population > 100000;

-- Problem 6

SELECT countries.name, countries.government_form, countries.capital, countries.life_expectancy
FROM countries
WHERE countries.government_form = "Constitutional Monarchy"
AND countries.capital > 200
AND countries.life_expectancy > 75;

-- Problem 7

SELECT countries.name, cities.name, cities.district, cities.population
FROM countries
JOIN cities ON countries.id = cities.country_id
WHERE cities.district = "Buenos Aires"
ORDER BY cities.population DESC;

-- Problem 8

SELECT countries.region, COUNT(countries.region) AS countries
FROM countries
GROUP BY countries.region
ORDER BY countries DESC;
