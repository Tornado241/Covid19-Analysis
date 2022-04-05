select * from covid19

--S? ca m?c v� t? vong tr�n to�n th? gi?i
select sum(new_cases) as 'Caese', sum(new_deaths) as 'Deaths'
from covid19
where location <> continent

--T? l? t? vong tr�n s? ca m?c ? m?i n??c
select location, SUM(new_deaths) / SUM(new_cases) as deaths_on_caaes
from covid19
where location <> continent
group by location
order by deaths_on_caaes desc

--N??c co t? l? t? vong cao nh?t
select location, sum(new_deaths) as deaths
from covid19
where location <> continent
group by location
order by deaths desc

--T? l? nhi?m covid tr�n to�n d�n s?
select location, SUM(new_cases) / population as cases_on_pop
from covid19
where location <> continent
group by location, population
order by cases_on_pop desc

--T? l? t? vong tr�n to�n d�n s?
select location, SUM(new_deaths) / population as deaths_on_pop
from covid19
where location <> continent
group by location, population
order by deaths_on_pop desc

--Ng�y c� s? ca m?i nhi?u nh?t ? m?i n??c
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

--T?ng s? ng??i ???c ti�m vaccine ? m?i n??c
select location, max(people_vaccinated) as 'people vaccinated'
from covid19
where location <> continent
group by location

--T? l? ti�m vaccine tr�n t?ng d�n s?
select location, max(people_vaccinated) / population * 100 as 'rate vaccinated'
from covid19
where location <> continent
group by location, population
order by 'rate vaccinated' desc

--T?ng s? ca m?c ? m?i l?c ??a
select location, sum(new_cases)
from covid19
where location in (select distinct continent from covid19)
group by location

--S? ng??i t? vong ? m?i l?c ??a
select location, sum(new_deaths) as 'Total deaths', sum(new_deaths) / population as 'Death rate'
from covid19
where location in (select distinct continent from covid19)
group by location, population

--T? l? ti�m vaccine ? m?i l?c ??a
select location, population, max(people_vaccinated)/population * 100 as 'Vaccination rate'
from covid19
where location  in (select distinct continent
					from covid19)
group by location, population
