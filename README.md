# Data Jobs Analysis Project

## Overview

The Data Jobs Analysis Project aims to analyze job postings related to data roles, focusing on the programming languages required, job classifications, and salary information. This project utilizes data from Glassdoor to provide insights into the current job market for data professionals.

## Goals

- Identify the most commonly used programming languages in data job postings.
- Classify job titles into categories such as Data Scientist, Data Analyst, Data Engineer, and Manager of Data.
- Analyze salary data to understand compensation trends in the data job market.
- Gather insights on educational requirements and job locations in future iterations.

## Features

- **Salary Conversion**: Converts minimum, maximum, and average salaries from raw data into thousands for easier analysis.
- **Job Title Classification**: Classifies job titles into predefined categories based on keywords in the job title.
- **Programming Language Detection**: Identifies the presence of various programming languages in job descriptions and creates corresponding binary columns.
- **Data Aggregation**: Summarizes the count of programming languages mentioned across job postings and stores the results in a new table.
- **Data Transformation**: Converts the aggregated data from columns to rows for better analysis and visualization.

## Database Schema

### Tables

- **Glassdoor_Data_Jobs**: Contains raw job data including job titles, descriptions, and salary information.
- **Prog_lang_count**: Stores the aggregated counts of programming languages mentioned in job descriptions.
- **Program_Lang_Count**: Contains the unpivoted data of programming languages and their mention counts, along with additional metrics like percentage of mentions.

## SQL Queries

The project includes several SQL queries to perform the following operations:

1. **Update Salary Data**: Converts salary figures to thousands.
2. **Alter Table for Job Classification**: Adds a new column for job title classification.
3. **Classify Job Titles**: Updates the job title classification based on keywords.
4. **Add Programming Language Columns**: Creates new columns for various programming languages.
5. **Update Programming Language Mentions**: Sets binary values indicating the presence of programming languages in job descriptions.
6. **Aggregate Programming Language Counts**: Sums the counts of programming languages and stores them in a new table.
7. **Transform Data**: Converts aggregated data from columns to rows for easier analysis.
8. **Add Additional Metrics**: Adds columns for data science counts and percentage calculations.

## Future Work

- Scrape additional data to analyze educational requirements for data jobs.
- Investigate job locations and their correlation with salary data.
- Explore the relationship between programming languages and salary levels.

## Getting Started

To run this project, ensure you have access to a SQL database where you can execute the provided SQL scripts. Follow the steps below:

1. Set up your database and create the necessary tables.
2. Execute the SQL scripts in the order provided to populate and analyze the data.
3. Review the results in the `Prog_lang_count` and `Program_Lang_Count` tables.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for any suggestions or improvements.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.