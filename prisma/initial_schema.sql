CREATE SCHEMA "recipes";

CREATE SCHEMA "ingredients";

CREATE SCHEMA "markets";

CREATE SCHEMA "users";

CREATE SCHEMA "countries";

CREATE TABLE "recipes"."recipes" (
  "id" bigserial PRIMARY KEY,
  "fk_user_id" uuid NOT NULL,
  "title" varchar NOT NULL,
  "fk_level_id" smallint DEFAULT 0,
  "image" varchar,
  "instructions" varchar,
  "created_at" timestamp DEFAULT (now()),
  "modified_at" timestamp DEFAULT (now())
);

CREATE TABLE "recipes"."recipe_categories" (
  "fk_recipe_id" bigint,
  "fk_category_id" integer,
  PRIMARY KEY ("fk_recipe_id", "fk_category_id")
);

CREATE TABLE "recipes"."categories" (
  "id" serial PRIMARY KEY,
  "category" varchar UNIQUE NOT NULL
);

CREATE TABLE "recipes"."recipes_ingredients" (
  "fk_ingredient_id" integer,
  "fk_recipe_id" bigint,
  "quantity" numeric(8,3),
  PRIMARY KEY ("fk_ingredient_id", "fk_recipe_id")
);

CREATE TABLE "recipes"."levels" (
  "id" smallserial PRIMARY KEY,
  "level" varchar UNIQUE NOT NULL
);

CREATE TABLE "ingredients"."ingredients" (
  "id" serial PRIMARY KEY,
  "ingredient" varchar UNIQUE NOT NULL,
  "fk_type_id" integer DEFAULT 0,
  "fk_measure_unit_id" smallint NOT NULL
);

CREATE TABLE "ingredients"."types" (
  "id" serial PRIMARY KEY,
  "type" varchar UNIQUE NOT NULL
);

CREATE TABLE "ingredients"."measure_units" (
  "id" smallserial PRIMARY KEY,
  "unit" varchar UNIQUE NOT NULL
);

CREATE TABLE "ingredients"."ingredient_prices_log" (
  "id" bigserial PRIMARY KEY,
  "fk_ingredient_id" integer NOT NULL,
  "fk_market_unit_id" integer NOT NULL,
  "log_date" date NOT NULL,
  "price" numeric(10,2) NOT NULL,
  "discount_percentage" numeric(3,2) DEFAULT 0
);

CREATE TABLE "markets"."markets" (
  "id" serial PRIMARY KEY,
  "market" varchar NOT NULL,
  "observations" varchar
);

CREATE TABLE "markets"."markets_units" (
  "id" serial PRIMARY KEY,
  "fk_market_id" integer,
  "market_unit_name" varchar,
  "address" varchar,
  "coordinates" point,
  "fk_country_id" integer NOT NULL
);

CREATE TABLE "markets"."delivery_contact" (
  "id" serial PRIMARY KEY,
  "fk_market_unit_id" integer NOT NULL,
  "site" varchar,
  "phone" varchar
);

CREATE TABLE "users"."users" (
  "id" uuid PRIMARY KEY,
  "email" varchar UNIQUE NOT NULL,
  "username" varchar NOT NULL,
  "full_name" varchar,
  "address" varchar,
  "city" varchar,
  "country" varchar NOT NULL,
  "avatar" varchar,
  "created_at" timestamp DEFAULT (now()),
  "modified_at" timestamp DEFAULT (now())
);

CREATE TABLE "users"."favorite_recipes" (
  "fk_user_id" uuid,
  "fk_recipe_id" bigint,
  "favorited_at" timestamp DEFAULT (now()),
  PRIMARY KEY ("fk_user_id", "fk_recipe_id")
);

CREATE TABLE "countries"."countries" (
  "id" serial PRIMARY KEY,
  "country_code" varchar(2) UNIQUE NOT NULL,
  "short_country_name" varchar UNIQUE NOT NULL,
  "official_country_name" varchar UNIQUE,
  "fk_currency_id" integer
);

CREATE TABLE "countries"."country_languages" (
  "fk_country_id" integer,
  "fk_language_id" integer,
  PRIMARY KEY ("fk_country_id", "fk_language_id")
);

CREATE TABLE "countries"."languages" (
  "id" serial PRIMARY KEY,
  "language_code" varchar(2),
  "language_name" varchar NOT NULL
);

CREATE TABLE "countries"."currencies" (
  "id" serial PRIMARY KEY,
  "currency_code" varchar(3) UNIQUE NOT NULL,
  "currency_name" varchar NOT NULL,
  "symbol" varchar NOT NULL
);

CREATE INDEX ON "recipes"."recipes" ("fk_user_id");

CREATE INDEX ON "recipes"."recipes" ("title");

CREATE INDEX ON "recipes"."recipes" ("fk_level_id");

CREATE INDEX ON "recipes"."recipes" ("fk_user_id", "created_at");

CREATE INDEX ON "ingredients"."ingredients" ("ingredient");

CREATE INDEX ON "ingredients"."ingredients" ("fk_type_id");

CREATE INDEX ON "ingredients"."ingredient_prices_log" ("fk_ingredient_id");

CREATE INDEX ON "ingredients"."ingredient_prices_log" ("fk_market_unit_id");

CREATE INDEX ON "ingredients"."ingredient_prices_log" ("log_date");

CREATE INDEX ON "ingredients"."ingredient_prices_log" ("fk_ingredient_id", "price");

CREATE INDEX ON "ingredients"."ingredient_prices_log" ("fk_ingredient_id", "discount_percentage");

CREATE INDEX ON "markets"."markets_units" ("fk_market_id");

CREATE INDEX ON "markets"."delivery_contact" ("fk_market_unit_id");

CREATE INDEX ON "users"."users" ("email");

CREATE INDEX ON "users"."users" ("username");

CREATE INDEX ON "users"."users" ("city", "country");

CREATE INDEX ON "users"."users" ("created_at");

CREATE INDEX ON "users"."favorite_recipes" ("favorited_at");

CREATE INDEX ON "countries"."countries" ("country_code");

CREATE INDEX ON "countries"."languages" ("language_code");

COMMENT ON COLUMN "ingredients"."ingredient_prices_log"."discount_percentage" IS '[0.00,1.00]';

COMMENT ON COLUMN "countries"."countries"."country_code" IS 'ISO 3166';

COMMENT ON COLUMN "countries"."languages"."language_code" IS 'ISO 639';

ALTER TABLE "recipes"."recipes" ADD FOREIGN KEY ("fk_user_id") REFERENCES "users"."users" ("id");

ALTER TABLE "recipes"."recipes" ADD FOREIGN KEY ("fk_level_id") REFERENCES "recipes"."levels" ("id");

ALTER TABLE "recipes"."recipe_categories" ADD FOREIGN KEY ("fk_recipe_id") REFERENCES "recipes"."recipes" ("id");

ALTER TABLE "recipes"."recipe_categories" ADD FOREIGN KEY ("fk_category_id") REFERENCES "recipes"."categories" ("id");

ALTER TABLE "recipes"."recipes_ingredients" ADD FOREIGN KEY ("fk_ingredient_id") REFERENCES "ingredients"."ingredients" ("id");

ALTER TABLE "recipes"."recipes_ingredients" ADD FOREIGN KEY ("fk_recipe_id") REFERENCES "recipes"."recipes" ("id");

ALTER TABLE "ingredients"."ingredients" ADD FOREIGN KEY ("fk_type_id") REFERENCES "ingredients"."types" ("id");

ALTER TABLE "ingredients"."ingredients" ADD FOREIGN KEY ("fk_measure_unit_id") REFERENCES "ingredients"."measure_units" ("id");

ALTER TABLE "ingredients"."ingredient_prices_log" ADD FOREIGN KEY ("fk_ingredient_id") REFERENCES "ingredients"."ingredients" ("id");

ALTER TABLE "ingredients"."ingredient_prices_log" ADD FOREIGN KEY ("fk_market_unit_id") REFERENCES "markets"."markets_units" ("id");

ALTER TABLE "markets"."markets_units" ADD FOREIGN KEY ("fk_market_id") REFERENCES "markets"."markets" ("id");

ALTER TABLE "markets"."markets_units" ADD FOREIGN KEY ("fk_country_id") REFERENCES "countries"."countries" ("id");

ALTER TABLE "markets"."delivery_contact" ADD FOREIGN KEY ("fk_market_unit_id") REFERENCES "markets"."markets_units" ("id");

ALTER TABLE "users"."favorite_recipes" ADD FOREIGN KEY ("fk_user_id") REFERENCES "users"."users" ("id");

ALTER TABLE "users"."favorite_recipes" ADD FOREIGN KEY ("fk_recipe_id") REFERENCES "recipes"."recipes" ("id");

ALTER TABLE "countries"."countries" ADD FOREIGN KEY ("fk_currency_id") REFERENCES "countries"."currencies" ("id");

ALTER TABLE "countries"."country_languages" ADD FOREIGN KEY ("fk_country_id") REFERENCES "countries"."countries" ("id");

ALTER TABLE "countries"."country_languages" ADD FOREIGN KEY ("fk_language_id") REFERENCES "countries"."languages" ("id");
