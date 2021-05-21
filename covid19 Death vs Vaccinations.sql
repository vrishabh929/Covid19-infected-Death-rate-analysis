select *
from Coviddeaths
order by 
 date,
 total_cases

--select * 
--from CovidVaccination
--order by date,new_tests

select 
	location,
	date,
	total_cases,
	new_cases,
	total_deaths,
	population
from Coviddeaths
order by 
	location,
	date

select distinct(location)
from Coviddeaths
order by location

--Total_cases vs total_deaths
select 
	location,
	date,
	total_cases,
	total_deaths,
	(total_deaths/total_cases)*100 as DeathPercentage
from Coviddeaths
where
	location = 'India'
order by 
	location,
	date

--Total cases vs population
select 
	location,
	date,
	population,
	total_cases,
	round((total_cases/population)*100,5) as Infectionrate
from Coviddeaths
--where
--	location = 'India'
order by 
	location,
	date

-- Country with higher infection rate

select 
	location,
	population,
	max(total_cases) as highest_infection_count,
	max((total_cases/population)*100) as Percentinfected
from Coviddeaths
--where
--	location = 'India'
group by 
	location,
	population
order by 
	percentinfected desc

--Highest Death (country)

select 
	location,
	max(cast(total_deaths as int)) as TotalDeath
from Coviddeaths
where
	continent is not null
group by 
	location
order by 
	TotalDeath desc

--Highest Death (continent)

select 
	continent,
	max(cast(total_deaths as int)) as TotalDeath
from Coviddeaths
where
	continent is not null
group by 
	continent
order by 
	TotalDeath desc

-- Global Number

select 
	date,
	sum(new_cases) as total_cases,
	sum(cast(new_deaths as int)) as total_deaths,
	sum(cast(new_deaths as int))/sum(new_cases) * 100 as deathpercentage
	--total_cases,
	--total_deaths,
	--(total_deaths/total_cases)*100 as DeathPercentage
from Coviddeaths
where
	continent is not null
group by 
	date
order by 
	date

select 
	sum(new_cases) as total_cases,
	sum(cast(new_deaths as int)) as total_deaths,
	sum(cast(new_deaths as int))/sum(new_cases) * 100 as deathpercentage
	--total_cases,
	--total_deaths,
	--(total_deaths/total_cases)*100 as DeathPercentage
from Coviddeaths
where
	continent is not null
--group by 
--	date
--order by 
--	date

--

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From CovidDeaths dea
Join CovidVaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3





---CTE


with PopsvsVac (Continent, Location ,date,population,new_vaccinations,RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From CovidDeaths dea
Join CovidVaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
select *, (RollingPeopleVaccinated/population)*100
from PopsvsVac


Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Coviddeaths dea
Join CovidVaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
