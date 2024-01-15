/*
Covid 19 Data Exploration 

Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

*/
EXEC sp_rename 'CovidDeaths$', 'CovidDeaths';


Select *
From CovidDeaths
Where continent like 'World'
order by 3,4


-- Select Data that we are going to be starting with

Select Location, date, total_cases, new_cases, total_deaths, population
From CovidDeaths
Where continent is not null 
order by 1,2


-- Nombre total de cas par rapport au nombre total de décès
-- Montre la probabilité de mourir si vous contractez le covid dans votre pays

Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From CovidDeaths
Where location like '%states%'
and continent is not null 
order by 1,2


-- Total des cas par rapport à la population
-- Montre quel pourcentage de la population est infecté par Covid
-- for exemple in morocco
Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From CovidDeaths
Where location like 'morocco'
order by 1,2


-- Pays avec le taux d'infection le plus élevé par rapport à la population? trier selon ordre décroissant

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From CovidDeaths
Group by Location, Population
order by PercentPopulationInfected desc

-- Le pays Andorre est le plus élevé

-- Pays avec le plus grand nombre de décès par population

Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount --using cast for casting the type of total_dearhs(varchar)
From CovidDeaths
Where continent is not null 
Group by Location
order by TotalDeathCount desc

--       -->  united state is the number one

-- BREAKING THINGS DOWN BY CONTINENT

select distinct(continent) from  CovidDeaths
Where continent is not null 

-- Showing contintents with the highest death count per population
Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From CovidDeaths
Where continent is not null 
Group by continent
order by TotalDeathCount desc
--       -->  euroup is the number one


-- GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths,
  SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage -- calcul the percent of death in the world
From CovidDeaths
where continent is not null 
order by 1,2




                                         -- import dataset covid Vaccination

EXEC sp_rename 'CovidVaccinations$', 'CovidVaccinations';   
-- Total Population vs Vaccinations

Select death.continent, death.location, death.date, death.population, vac.new_vaccinations
From CovidDeaths death Join CovidVaccinations vac  --alias of tables
	On death.location = vac.location and death.date = vac.date -- join tables
where death.continent is not null 
order by 2,3

-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select death.continent, death.location, death.date, death.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by death.Location Order by death.location, death.Date) as RollingPeopleVaccinated

From CovidDeaths death Join CovidVaccinations vac  --alias of tables
	On death.location = vac.location
	and death.date = vac.date
where death.continent is not null 
order by 2,3


-- Using CTE to perform Calculation on Partition By in previous query (vieu)

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select death.continent, death.location, death.date, death.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by death.Location Order by death.location, death.Date) as RollingPeopleVaccinated
From CovidDeaths death
Join CovidVaccinations vac
	On death.location = vac.location
	and death.date = vac.date
where death.continent is not null 
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac



-- Using Temp Table to perform Calculation on Partition By in previous query

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select death.continent, death.location, death.date, death.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by death.Location Order by death.location, death.Date) as RollingPeopleVaccinated
From .CovidDeaths death
Join CovidVaccinations vac
	On death.location = vac.location
	and death.date = vac.date

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated




-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select death.continent, death.location, death.date, death.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by death.Location Order by death.location, death.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From CovidDeaths death
Join CovidVaccinations vac
	On death.location = vac.location
	and death.date = vac.date
where death.continent is not null 


