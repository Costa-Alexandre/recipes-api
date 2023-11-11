# Not a HelloFresh Recipes API

A RESTful API using Express, Prisma and PostgreSQL. This documentation is generated with the assistance of AI to provide comprehensive information about this project. The content is co-authored and edited by [Alex Costa](https://github.com/Costa-Alexandre), the project's creator.

## Table of Contents

1. [Introduction](#introduction)
1. [Key Features](#key-features)
1. [Prerequisites](#prerequisites)
1. [Installation](#installation)
1. [Use Cases](#use-cases)
   - [Recipe](#recipe)
   - [Ingredient](#ingredient)
   - [PriceLog](#pricelog)
   - [User](#user)
   - [ShoppingList](#shoppinglist)
1. [Data Models](#data-models)
   - [Auto-Generating the ERD with dbdocs.io](#auto-generating-the-erd-with-dbdocsio)
1. [API Documentation](#api-documentation)
1. [Contribution List](#contribution-list)
1. [License](#license)

## Introduction

This project is a backend API designed to simplify the process of managing recipes and shopping lists. It empowers users to effortlessly create and organize their favorite recipes, estimate the cost of ingredients based on market prices, and generate shopping lists tailored to their preferences. Additionally, users can log market prices from various locations, allowing for cost-effective decision-making when planning their grocery shopping.

This API provides a robust backend for your recipe management and shopping planning needs. Whether you're a cooking enthusiast or someone looking to make more informed grocery shopping decisions, this project has you covered.

## Key Features

- Recipe Creation: Easily create and store your favorite recipes.
- Shopping List Generation: Automatically generate smart shopping lists based on selected recipes.
- Price Tracking: Log and track ingredient prices from different markets.
- Cost Estimation: Estimate the cost of recipes and shopping lists based on current market prices.
- Location-Based Recommendations: Find markets with the best prices or nearest to a specified address.

## Prerequisites

Before you can use this project, make sure you have the following prerequisites in place:

- **Node.js:** Version 16 or higher.
- **PostgreSQL Database:** Ensure you have a PostgreSQL database up and running.
- **npm:** Version 9 or higher.

## Installation

1. **Set up a PostgreSQL Database:**
   You can set up a PostgreSQL database using one of the following methods:

   - [Locally: Install PostgreSQL on your local machine.](https://www.prisma.io/dataguide/postgresql/setting-up-a-local-postgresql-database)
   - [Docker Container: Run a PostgreSQL instance in a Docker container.](https://www.code4it.dev/blog/run-postgresql-with-docker/)
   - Cloud Managed Database: Use a cloud service to create and manage a PostgreSQL database. (e.g., [AWS RDS](https://aws.amazon.com/getting-started/hands-on/create-connect-postgresql-db/))

   Ensure you take note of the connection URL to your database (e.g.: `postgresql://johndoe:randompassword@localhost:5432/mydb`)

2. **Clone the Repository:**

`git clone https://github.com/Costa-Alexandre/recipes-api.git`

3. **Install Dependencies:**

Navigate to the project directory and run the following command to install dependencies:

`npm install`

4. **Create a .env File:**
   Generate a `.env` file in the project directory and add the following variables:

```shell
DATABASE_URL=<your_database_connection_url_from_step_1>
JWT_SECRET=<your_secure_password>
JWT_REFRESH=<another_secure_password>
```

5. **Run Database Migrations:**
   Execute the following command to run Prisma database migrations:

`npx prisma migrate dev`

6. **Start the Express Server:**
   Start the Express server by running the following command:

`npm run dev`

The server will be available at `http://localhost:3000/`.

Now, your project should be set up and ready to use.

## Use Cases

This section outlines the various use cases and functionalities supported by the project.

### Recipe

#### Recipe Management

- **Create Recipes:**

  - [ ] Users can create new recipes

- **Edit Recipes:**

  - [ ] Users can modify only their own recipes

- **Delete Recipes:**

  - [ ] Users can delete their own recipes.
  - [ ] Editors can delete any recipe.

- **View Recipes:**

  - [ ] Users can view all recipes.

- **Search Recipes:**

  - [ ] Users can search for recipes based on:

    - [ ] ingredients
    - [ ] categories (e.g., vegan, vegetarian)
    - [ ] difficulty level
    - [ ] author
    - [ ] title
    - [ ] date of creation

  - [ ] Users can filter recipes based on:
    - [ ] required utensils
    - [ ] price range
    - [ ] ingredient availability

#### Recipe Integrity

- **Recipe Constraints:**
  - [x] A recipe must have:
    - [x] an uuid
    - [x] a non-blank title
    - [x] a valid author (user)
    - [x] a positive number of servings
    - [x] created at and updated at dates

### Ingredient

#### Ingredient Management

- **Manage Ingredients:**

  - **Create Ingredients:**

    - [ ] Editors can create new ingredients
    - [ ] Users can create new ingredients, but they must be approved by an editor before being available to other users

  - **Edit or Delete Ingredients:**

    - [ ] Editors can modify and delete any ingredient

  - **View Ingredients:**
    - [ ] Users can view all ingredients

- **Search Ingredients:**
  - [ ] Users can search for ingredients based on:
    - [ ] name
    - [ ] type

#### Ingredient Integrity

- **Ingredient Constraints:**
- [x] An ingredient must have:
  - [x] an uuid
  - [x] a unique non-blank name
  - [x] only one measuring unit
  - [x] only on valid type

### PriceLog

#### PriceLog Management

PriceLogs are considered sensitive information for containing data about the user's shopping habits. Editors and Users can only access their own PriceLogs.

- **Create a PriceLog:**

  - [ ] Users can log the price of ingredients at specific markets and dates

- **Edit or Delete a PriceLog:**

  - [ ] Users can modify and delete their own PriceLogs
  - [ ] Admins can modify and delete any PriceLog

- **View a PriceLog:**

  - [x] Users can view their own PriceLogs
  - [x] Users can view aggregated PriceLogs data for a specific ingredient, without user information
  - [x] Admins can view all PriceLogs

- **Search PriceLogs:**

  - [x] Users can search for PriceLog based on:
    - [x] ingredient name
    - [x] market name
    - [x] market unit
    - [x] date range
    - [x] location

- **Aggregate PriceLogs:**
  - [x] Users can get price estimations for a specific ingredient, using aggregation functions in queries filtered by:
    - [x] market
    - [x] market unit
    - [x] location
    - [x] date range

#### PriceLog Integrity

- **PriceLog Constraints:**
- [x] A PriceLog must have:
  - [x] an uuid
  - [x] a valid ingredient
  - [x] a valid market unit
  - [x] a valid user
  - [x] a positive price
  - [x] a valid date

### User

#### User Management

- **Authentication and Authorization:**

  - [x] Users can log in and receive authentication tokens
  - [x] Users receive a refresh token valid for 7 days on login
  - [x] Authentication tokens are valid for 15 min and can be refreshed
  - [x] Users have limited access, mainly to public and authenticated views restricted to their data.
  - [x] Editors have all permissions as the users, with additional privileges:
    - [ ] Editors can access, edit or delete all recipes, ingredients, market, market units and other non-sensitive data
  - [x] Admins have all permissions as the editors, with additional privileges:
    - [ ] Admins can create new editors and admins
    - [ ] Admins can access, edit or delete any data

#### User Integrity

- **User Constraints:**
- [x] A user must have:
  - [x] a unique username
  - [x] a unique and valid email
  - [x] a valid and hashed password with exactly 60 characters and starting with `$2b$10$`
  - [x] a valid country
  - [x] a valid role (user, editor or admin)
  - [x] valid created at and updated at dates

### ShoppingList

#### ShoppingList Management

- **Create a ShoppingList:**

  - [ ] Users can generate a shopping list based on selected recipes and number of servings for each recipe
  - [ ] Users can select a criteria for selecting the markets suggested to buy ingredients from:
    - [ ] cheapest price
    - [ ] nearest location
    - [ ] ingredients availability
    - [ ] preferred markets

- **Edit or Delete a ShoppingList:**
  - [ ] Users can modify and delete their own ShoppingLists
  - [ ] Admins can modify and delete any ShoppingList
- **View a ShoppingList:**
  - [ ] Users can view their own ShoppingLists
  - [ ] Admins can view all ShoppingLists
- **Search ShoppingLists:**
  - [ ] Users can search their ShoppingLists by:
    - [ ] title
    - [ ] recipes included
- **Filter ShoppingLists:**
  - [ ] Users can filter their ShoppingLists by:
    - [ ] total price range
    - [ ] date range
    - [ ] market units
    - [ ] location distance

These use cases demonstrate the core functionalities and features of the project, providing users with a comprehensive recipe management and shopping planning experience.

## Data Models

Here is an Entity-Relationship Diagram (ERD) illustrating the key data models used in this project:

![ERD Diagram](static/Recipes.png)

This diagram provides an overview of the data structure and relationships within the project's database. You can visualize and interact with this ERD at [dbdocs.io](https://dbdocs.io/alexandre.costa/recipes-api?view=relationships).

### Auto-Generating the ERD with dbdocs.io

**TL;DR:** Copy-paste the following command in your terminal. You will be required to log in to dbdocs, but no account is required. You can use your email or authenticate with a third-party service (e.g., GitHub).

```bash
npx prisma migrate diff --from-empty --to-schema-datasource prisma/schema.prisma --script > dump.sql &&
npx -p @dbml/cli sql2dbml --postgres dump.sql -o mydatabase.dbml &&
npx dbdocs login &&
npx dbdocs build mydatabase.dbml --project recipes-api --public &&
rm mydatabase.dbml dump.sql dbml-error.log
```

Click the dbdocs.io link outputted in the terminal and navigate to "Relationships" to view your ERD.

## Step-by-Step Guide

To automatically generate an Entity-Relationship Diagram (ERD) from your Prisma schema, you can use the dbdocs.io tool. Follow these steps to create an ERD:

1. **Generate a dump.sql File:**
   Use the following command to generate a SQL script from your Prisma migrations:

```bash
npx prisma migrate diff --from-empty --to-schema-datasource prisma/schema.prisma --script > dump.sql
```

2. **Convert SQL to .dbml:**
   Run the following command to convert the SQL script to a .dbml file:

```bash
npx -p @dbml/cli sql2dbml --postgres dump.sql -o mydatabase.dbml
```

Note: Using the `--postgres` flag will generate a .dbml file with a different syntax. This syntax is currently not supported by dbdocs/0.8.1 or prior versions. Use the `--postgres-legacy` flag instead.

3. **Log in to dbdocs.io:**

- Run the command:

```bash
npx dbdocs login
```

- Choose your preferred authentication method (e.g., Email).
- Input the OTP code received via email or token generated by authenticating to a third-party service. Your credentials will be saved locally.

4. **Build the ERD:**
   Run the following command to build the ERD using your .dbml file:

```bash
npx dbdocs build mydatabase.dbml
```

5. **Name Your Project:**
   When prompted, select a name for your project.

6. **View Your ERD:**
   After naming your project, you will receive a link to your Entity-Relationship Diagram (ERD) on dbdocs.io. You can access your ERD by visiting the provided link in the following pattern:

`https://dbdocs.io/<username>/<project_name>?view=relationships`

6. **Cleanup [optionally]:**
   After generating the ERD, you can clean up the auto-generated files with the following command:

**CAUTION: This command will delete the newly generate .dbml and dump.sql files.**

```bash
rm mydatabase.dbml dump.sql dbml-error.log
```

By following these steps, you can easily generate and visualize the Entity-Relationship Diagram (ERD) for your Prisma schema using dbdocs.io.

## Deployment

This project is currently deployed on AWS and uses the following services:

- Elastic Compute Cloud (EC2)
- Relational Database Service (RDS)
- Virtual Private Cloud (VPC)

Additionally, the project is behind a Cloudflare proxy to provide additional security and performance benefits.

## API Documentation

For detailed API documentation, please visit the API Documentation available at `http://localhost:3000/docs`, on local development, or at `https://hellorecipes.online/docs/`, on production.

## Contribution List

This section contains a list of my main module-related (SE_05 Relational Databases) contributions

- [x] Application of the concepts of relational databases to the project
- [x] Design and implementation of the database schema, including the definition of tables, columns, primary and foreign keys, and relationships
- [x] Correct use of data types
- [x] Normalization of the database schema
- [x] Correct use of indexes
- [x] Enforcing data integrity through the use of constraints
- [x] Correct use of SQL statements
- [x] Correct use of the ORM framework (Prisma) to perform CRUD operations
- [x] Correct use of the ORM framework (Prisma) to perform complex queries (e.g., aggregations, filtering, sorting)
- [x] Limiting the amount of data returned by queries (pagination)
- [x] Prevention for SQL injection attacks with the use of server-side input validation (Zod)
- [x] Properly handling errors and exceptions
- [x] Prevention for broken object level authorization (BOLA)
- [x] Securely managing user sessions (short-lived JWT, refresh tokens) and access control (role-based access control)
- [x] Securely managing user passwords (hashing with cost factor, salting)
- [x] Application of transport layer security (HTTPS) and subnetwork isolation (VPC)
- [x] Use of Cloudflare proxy to provide additional security against DDoS and performance benefits
- [ ] Database backup and recovery

## License

This project is licensed under the [Mozilla Public License Version 2.0](LICENSE).
