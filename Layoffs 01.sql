-- Create dataset

select *
from layoffs ;

-- Remove Duplicates

create table layoffs_staging
like layoffs ;

select *
from layoffs_staging ;

INSERT  layoffs_staging
SELECT *
FROM layoffs ;

SELECT *
FROM layoffs_staging;

-- Rename The layoff  column name 
ALTER TABLE layoffs  change ï»¿company Company varchar(100);
select *
from layoffs ;

-- Rename The layoffs_staging column name 
ALTER TABLE layoffs_staging CHANGE ï»¿company Company VARCHAR(100);
select *
from layoffs_staging ;


-- Find the duplicate value and Remove The Duplicate
SELECT *,ROW_NUMBER() 
OVER(PARTITION BY Company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) as row_num
FROM layoffs_staging ;

WITH Duplicate_cate AS (
SELECT *,ROW_NUMBER() 
OVER(PARTITION BY Company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) as row_num
FROM layoffs_staging 
)
SELECT *
FROM Duplicate_cate
WHERE row_num > 1;

select *
FROM layoffs_staging
WHERE Company = "Patreon";

SELECT *
FROM layoffs_staging
WHERE Company = "Humu";


CREATE TABLE `layoffs_staging2` (
  `Company` varchar(100) DEFAULT NULL,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
   `row_num`INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2;

INSERT layoffs_staging2
SELECT *,
ROW_NUMBER() 
OVER(PARTITION BY Company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) as row_num
FROM layoffs_staging; 
 
SELECT *
FROM layoffs_staging2
WHERE row_num >1;

DELETE 
FROM layoffs_staging2
WHERE row_num >1;

SELECT *
FROM layoffs_staging2

-- Standardizing Data

SELECT Company, (TRIM(Company))
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET Company =TRIM(Company);

select * 
from layoffs_staging2;

select distinct industry
from layoffs_staging2
order by 1;

-- why are the industry
select*
from layoffs_staging2
where industry like "Crypto%";

update layoffs_staging2
set industry ='Crypto'
where industry like "Crypto%";

select distinct industry
from layoffs_staging2;

-- See The  location
SELECT DISTINCT location
from layoffs_staging2
order by 1; 

-- SEE The Country 
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERE country LIKE "United States%";

SELECT DISTINCT country, TRIM(country)
FROM layoffs_staging2
ORDER BY 1;

SELECT DISTINCT country,TRIM(TRAILING " "FROM country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING "."FROM country)
WHERE country LIKE "United states%";

-- Change The Day Data Set

SELECT `date`,
STR_TO_DATE(`date`,'%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- Change Day Date Tyep

SELECT `date`
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_staging2;

-- ******* Removing Null Value in The Data set
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL;
-- *****
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND  percentage_laid_off IS NULL;

UPDATE layoffs_staging2
SET industry = NULL 
WHERE industry = ' ';


-- ******** Find a bank Values AND Null values
SELECT *
FROM layoffs_staging2
WHERE industry IS NULL 
OR industry = ' ';


SELECT *
FROM layoffs_staging2
WHERE Company = "Airbnb";

SELECT t1.industry,t1.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
     ON t1.Company = t2.Company
     AND t1.location = t2.location
WHERE(t1.industry IS NULL OR t1.industry='')
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
   ON t1.Company = t2.Company
   SET t1.industry = t2.industry
WHERE(t1.industry IS NULL OR t1.industry='')
AND t2.industry IS NOT NULL;

SELECT *
FROM layoffs_staging2
WHERE Company ="Bally's Interactive";


SELECT *
FROM layoffs_staging2;

-- DELETE Null Values

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND  percentage_laid_off IS NULL;

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND  percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging2;

-- DROP The column ( we are not run this code )

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;













