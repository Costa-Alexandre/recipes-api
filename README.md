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
1. [Contributing](#contributing)
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

   - Locally: Install PostgreSQL on your local machine.
   - Docker Container: Run a PostgreSQL instance in a Docker container.
   - Cloud Managed Database: Use a cloud service to create and manage a PostgreSQL database.

   Ensure you take note of the connection URL to your database (e.g.: `postgresql://johndoe:randompassword@localhost:5432/mydb`)

2. **Clone the Repository:**

`git clone https://github.com/Costa-Alexandre/recipes-api.git`

3. **Install Dependencies:**

Navigate to the project directory and run the following command to install dependencies:

`npm install`

4. **Create a .env File:**
   Generate a `.env` file in the project directory and add the following variables:

```shell
DATABASE_URL=<your_database_connection_url>
JWT_SECRET=<your_secure_password>
JWT_REFRESH=<your_secure_password>
```

5. **Run Database Migrations:**
   Execute the following command to run Prisma database migrations:

`npx prisma migrate`

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

  - [ ] Users can filter recipes based on:
    - [ ] required utensils
    - [ ] price range
    - [ ] ingredient availability

#### Recipe Integrity

- **Recipe Constraints:**
  - [ ] A recipe must always have:
    - [ ] one or more ingredients
    - [ ] one or more categories (e.g., meat, vegetarian)
    - [ ] only one difficulty level
    - [ ] only one author

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
    - [ ] category

#### Ingredient Integrity

- **Ingredient Constraints:**
  - [ ] An ingredient must have an unique name
  - [ ] An ingredient must have a single measuring unit

### PriceLog

#### PriceLog Management

PriceLogs are considered sensitive information for containing data about the user's shopping habits. Editors and Users can only access their own PriceLogs.

- **Create a PriceLog:**

  - [ ] Users can log the price of ingredients at specific markets and dates

- **Edit or Delete a PriceLog:**

  - [ ] Users can modify and delete their own PriceLogs
  - [ ] Admins can modify and delete any PriceLog

- **View a PriceLog:**

  - [ ] Users can view their own PriceLogs
  - [ ] Users can view aggregated PriceLogs data for a specific ingredient, without user information
  - [ ] Admins can view all PriceLogs

- **Search PriceLogs:**

  - [ ] Users can search for PriceLog based on:
    - [ ] ingredient name
    - [ ] market name
    - [ ] market unit
    - [ ] date range
    - [ ] location

- **Aggregate PriceLogs:**
  - [ ] Users can get price estimations for a specific ingredient, using aggregation functions in queries filtered by:
    - [ ] market
    - [ ] market unit
    - [ ] location
    - [ ] date range

#### PriceLog Integrity

- **PriceLog Constraints:**
  - [ ] A PriceLog must have a valid ingredient
  - [ ] A PriceLog must have a valid market unit
  - [ ] A PriceLog must have a valid user
  - [ ] A PriceLog must have a valid price
  - [ ] A PriceLog must have a valid date

### User

#### User Management

- **Authentication and Authorization:**

  - [ ] Users can log in and receive authentication tokens
  - [ ] Users receive a refresh token valid for 7 days on login
  - [ ] Authentication tokens are valid for 1 hour and can be refreshed
  - [ ] Users have limited access, mainly to public and authenticated views restricted to their data.
  - [ ] Editors have all permissions as the users, with additional privileges:
    - [ ] Editors can access, edit or delete all recipes, ingredients, market, market units and other non-sensitive data
  - [ ] Admins have all permissions as the editors, with additional privileges:
    - [ ] Admins can create new editors and admins
    - [ ] Admins can access, edit or delete any data

#### User Integrity

- **User Constraints:**

  - [ ] A user must have a unique username
  - [ ] A user must have a unique email
  - [ ] A user must have a valid and hashed password with exactly 60 characters and starting with `$2b$10$`
  - [ ] A user must have a country
  - [ ] A user must have a valid role
  - [ ] A user must have created at and updated at dates

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

![ERD Diagram](src/docs/Recipes.png)

This diagram provides an overview of the data structure and relationships within the project's database.

### Auto-Generating the ERD with dbdocs.io

To automatically generate an Entity-Relationship Diagram (ERD) from your Prisma schema, you can use the dbdocs.io tool. Follow these steps to create an ERD:

1. **Generate a dump.sql File:**
   Use the following command to generate a SQL script from your Prisma migrations:

`npx prisma migrate diff --from-empty --to-schema-datasource prisma/schema.prisma --script > dump.sql`

2. **Convert SQL to .dbml:**
   Run the following command to convert the SQL script to a .dbml file:

`npx -p @dbml/cli sql2dbml --postgres dump.sql -o mydatabase.dbml`

Note: Using the `--postgres` flag will generate a .dbml file with a different syntax. This syntax is currently not supported by dbdocs/0.8.1 or prior versions. Use the `--postgres-legacy` flag instead.

3. **Log in to dbdocs.io:**

- Run the command:
  `npx dbdocs login`
- Choose your preferred authentication method (e.g., Email).
- Input the OTP code received via email or token generated by authenticating to a third-party service. Your credentials will be saved locally.

4. **Build the ERD:**
   Run the following command to build the ERD using your .dbml file:

`npx dbdocs build mydatabase.dbml`

5. **Name Your Project:**
   When prompted, select a name for your project.

6. **View Your ERD:**
   After naming your project, you will receive a link to your Entity-Relationship Diagram (ERD) on dbdocs.io. You can access your ERD by visiting the provided link in the following pattern:

`https://dbdocs.io/<username>/<project_name>?view=relationships`

6. **Cleanup [optionally]:**
   After generating the ERD, you can clean up the auto-generated files with the following command:

`rm mydatabase.dbml dump.sql`

By following these steps, you can easily generate and visualize the Entity-Relationship Diagram (ERD) for your Prisma schema using dbdocs.io.

## API Documentation

For detailed API documentation, please visit the API Documentation available at `http://localhost:3000/docs`.

## Contributing

This section outlines guidelines and information for those looking to contribute to the project.

### How to Contribute

We welcome contributions from the community! To contribute to the project, follow these steps:

1. Fork the repository and clone it to your local machine.
1. Create a new branch for your feature or bug fix
1. Make your modifications and ensure they adhere to the project's coding standards.
1. Test your changes thoroughly. If possible, write unit tests for your changes.
1. Commit your changes and push them to your fork.
1. Open a pull request in the project's repository and provide a detailed description of your changes.

### Coding Guidelines

Adhere to the project's coding style and guidelines. Refer to the existing codebase for examples. Format and lint your code before committing your changes.

### Reporting Issues

If you encounter bugs or have suggestions, please [open an issue](https://github.com/Costa-Alexandre/recipes-api/issues) on the project's GitHub repository.
Please check the existing issues to ensure your issue has not already been reported.

## License

This project is licensed under the [Mozilla Public License Version 2.0](LICENSE).
