use [Layoffs ]

--- Creating duplicate table for better practice

select * into layoffs_dup from layoffs_try 
select * from layoffs_dup

--- Finding Duplicate values and deleting it

 with temp as 
         (select * , ROW_NUMBER() over(partition by company , [location] , industry ,
		                              total_laid_off ,percentage_laid_off , [date] ,stage , country ,
                                      funds_raised_millions order by company ) row_num from layoffs_dup ) 
					select * from temp where row_num > 1
					
with temp as 
         (select * , ROW_NUMBER() over(partition by company , [location] , industry ,
		                              total_laid_off ,percentage_laid_off , [date] ,stage , country ,
                                      funds_raised_millions order by company ) row_num from layoffs_dup ) 
					delete from temp where row_num > 1


--- Standardizing Data

select distinct industry from layoffs_dup order by 1 

update layoffs_dup set industry = 'Crypto' 
where industry like 'crypto%' 

select distinct Country from layoffs_dup order by 1 

select distinct country , TRIM(trailing '.' from country) from layoffs_dup

update layoffs_dup set country = TRIM(trailing '.' from country) where country like 'united states%'

select [date] , Convert( date,'3/6/2023',103) as newdate from layoffs_dup

update layoffs_dup set date = Convert( date,'3/6/2023',103)

select * from layoffs_dup

Exec sp_columns layoffs_dup

Alter table layoffs_dup alter column date date;


--- Handling Null values and blank values

select * from layoffs_dup where industry is Null or industry = ' '

select * from layoffs_dup where company = 'Airbnb'

select t1.industry  , t2.industry  from layoffs_dup t1 
join layoffs_dup t2 on t1.company = t2.company 
where t1.industry is null and t2.industry is not null

with tabl as
(
select t1.industry as ind1 , t2.industry as ind2 from layoffs_dup t1 
join layoffs_dup t2 on t1.company = t2.company 
where t1.industry is null and t2.industry is not null
)
update tabl set ind1 = ind2

select * from layoffs_dup 
where total_laid_off = 'Null' and percentage_laid_off = 'null'

delete from layoffs_dup 
where total_laid_off = 'Null' and percentage_laid_off = 'null'










