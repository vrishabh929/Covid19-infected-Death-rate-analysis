--Query for visualizations
--1
select
	sum(new_cases) as total_cases,
	sum(cast(new_deaths as int)) as total_death,
	sum(cast(new_deaths as int))/sum(new_cases) *100 as deathpercentage
from
	Coviddeaths
where 
	continent is not null

--2
select 
	continent,sum(cast(new_deaths as int)) as totaldeath
from
	Coviddeaths
where
	continent is not null and
	location not in('World','European Union','International')
group by 
	continent
order by 
	totaldeath desc

select distinct(continent)
from Coviddeaths
where continent is not null
order by continent

--3
select 
	location,
	population,
	max(total_cases) as HighestInfectedcount,
	max((total_cases/population)*100) as percentpopulationinfected
from
	Coviddeaths
where
	continent is not null
group by 
	location,
	population
order by 
	HighestInfectedcount desc

--4
select 
	location,
	population,
	date,
	max(total_cases) as HighestInfectedcount,
	max((total_cases/population)*100) as percentpopulationinfected
from
	Coviddeaths
where
	continent is not null
group by 
	location,
	population,
	date
order by 
	HighestInfectedcount desc