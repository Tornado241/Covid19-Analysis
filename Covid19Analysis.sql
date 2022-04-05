select * from covid19

--Number of cases and deaths on the world
select sum(new_cases) as 'Caese', sum(new_deaths) as 'Deaths'
from covid19
where location <> continent

--Deaths per cases in each country
select location, SUM(new_deaths) / SUM(new_cases) as deaths_on_caaes
from covid19
where location <> continent
group by location
order by deaths_on_caaes desc

--The country with the highest death rate
select location, sum(new_deaths) as deaths
from covid19
where location <> continent
group by location
order by deaths desc

--Covid cases per population
select location, SUM(new_cases) / population as cases_on_pop
from covid19
where location <> continent
group by location, population
order by cases_on_pop desc

--Deaths per population
select location, SUM(new_deaths) / population as deaths_on_pop
from covid19
where location <> continent
group by location, population
order by deaths_on_pop desc

--The day with the highest number of new cases in each country
select c.location, c.date, c.new_cases
from covid19 c
inner join (
	select	location,  MAX(new_cases) as max_case
	from covid19
	where location <> continent
	group by location
) t
on c.location = t.location
and c.new_cases = t.max_case

--Total number of people vaccinated in each country
select location, max(people_vaccinated) as 'people vaccinated'
from covid19
where location <> continent
group by location

--people vaccinated population
select location, max(people_vaccinated) / population * 100 as 'rate vaccinated'
from covid19
where location <> continent
group by location, population
order by 'rate vaccinated' desc

--Total cases in each continent
select location, sum(new_cases)
from covid19
where location in (select distinct continent from covid19)
group by location

--Total deaths in each continent
select location, sum(new_deaths) as 'Total deaths', sum(new_deaths) / population as 'Death rate'
from covid19
where location in (select distinct continent from covid19)
group by location, population

--Total people vaccinated in each continent
select location, population, max(people_vaccinated)/population * 100 as 'Vaccination rate'
from covid19
where location  in (select distinct continent
					from covid19)
group by location, population
