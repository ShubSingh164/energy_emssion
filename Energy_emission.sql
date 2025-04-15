CREATE TABLE Industry_Emissions (
    id INT PRIMARY KEY,
    industry_name VARCHAR(100),
    year INT,
    emissions_in_tonnes FLOAT,
    region VARCHAR(50)
);

INSERT INTO Industry_Emissions (id, industry_name, year, emissions_in_tonnes, region) VALUES
(1, 'Steel Manufacturing', 2020, 120000.5, 'North'),
(2, 'Textiles', 2020, 45000.2, 'South'),
(3, 'Automobile', 2020, 98000.0, 'East'),
(4, 'Pharmaceuticals', 2020, 23000.8, 'West'),
(5, 'Steel Manufacturing', 2021, 125000.0, 'North'),
(6, 'Textiles', 2021, 47000.5, 'South'),
(7, 'Automobile', 2021, 99500.6, 'East'),
(8, 'Pharmaceuticals', 2021, 24000.0, 'West');

SELECT industry_name, SUM(emissions_in_tonnes) AS total_emissions
FROM Industry_Emissions
GROUP BY industry_name
ORDER BY total_emissions DESC;

SELECT region, AVG(emissions_in_tonnes) AS avg_emissions
FROM Industry_Emissions
GROUP BY region
ORDER BY avg_emissions DESC;

SELECT industry_name, year, emissions_in_tonnes
FROM Industry_Emissions
ORDER BY industry_name, year;

SELECT year, industry_name, emissions_in_tonnes
FROM Industry_Emissions ei
WHERE emissions_in_tonnes = (
    SELECT MAX(emissions_in_tonnes)
    FROM Industry_Emissions
    WHERE year = ei.year
);

SELECT a.industry_name, a.year, 
       ((a.emissions_in_tonnes - b.emissions_in_tonnes) / b.emissions_in_tonnes) * 100 AS percent_change
FROM Industry_Emissions a
JOIN Industry_Emissions b ON a.industry_name = b.industry_name AND a.year = b.year + 1
ORDER BY a.industry_name, a.year;
