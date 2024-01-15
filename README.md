# COVID-19 Data Exploration Project

This project focuses on exploring COVID-19 data using SQL queries. It utilizes various SQL skills such as Joins, CTEs, Temp Tables, Window Functions, Aggregate Functions, Creating Views, and Converting Data Types. The dataset includes information on COVID-19 deaths (`CovidDeaths`) and vaccinations (`CovidVaccinations`).

## Project Structure

- **Data Exploration Queries:** The SQL queries in the script (`CovidDataExploration.sql`) are designed to extract meaningful insights from the COVID-19 dataset.
  
  - **Filtering Data:** Initial queries filter the data to focus on specific continents, countries, and regions of interest.
  
  - **Calculations:** Various calculations are performed, including death percentage, population infection rate, and identifying countries with the highest infection count and death count per population.
  
  - **Continent-wise Analysis:** The script breaks down the analysis by continent, highlighting the continents with the highest death count per population.
  
  - **Global Numbers:** A summary of global COVID-19 numbers is provided, including total cases, total deaths, and the death percentage.
  
- **Vaccination Data Integration:** The script integrates COVID-19 vaccination data (`CovidVaccinations`) to explore the relationship between population and vaccinations.

  - **Percentage of Population Vaccinated:** The script calculates the percentage of the population that has received at least one COVID-19 vaccine dose.

  - **Rolling Vaccination Statistics:** It uses techniques such as Window Functions and Common Table Expressions (CTEs) to perform calculations on the vaccination data.

- **Data Storage:** The script demonstrates different methods of storing and retrieving calculated data, including using Temporary Tables, CTEs, and creating a View (`PercentPopulationVaccinated`) for later visualizations.

## Getting Started

1. Clone the repository to your local machine:

    ```bash
    git clone https://github.com/your-username/covid-data-exploration.git
    ```

2. Import the provided dataset files (`CovidDeaths.csv` and `CovidVaccinations.csv`) into your database.

3. Execute the SQL script (`CovidDataExploration.sql`) against your database to perform the data exploration and analysis.

4. Customize the queries or add additional analyses as needed.

## Dependencies

- SQL Server or any other SQL database that supports the features used in the script.

## Notes

- Ensure that your SQL Server instance is configured and running.

- Adjust database connection parameters in the script according to your environment.

- The script may need modifications based on the structure of your specific COVID-19 dataset.

## Acknowledgments

- The COVID-19 dataset used in this project is assumed to be sourced from reliable and publicly available data repositories.
