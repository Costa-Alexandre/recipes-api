/*
  Warnings:

  - You are about to alter the column `category` on the `Category` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `code` on the `Country` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(2)`.
  - You are about to alter the column `country` on the `Country` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `code` on the `Currency` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(3)`.
  - You are about to alter the column `currency` on the `Currency` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `symbol` on the `Currency` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(3)`.
  - You are about to alter the column `site` on the `DeliveryContact` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - You are about to alter the column `phone` on the `DeliveryContact` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `marketUnitId` on the `DeliveryContact` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - The primary key for the `Ingredient` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `Ingredient` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `type` on the `IngredientType` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - The primary key for the `IngredientsOnRecipes` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `ingredientId` on the `IngredientsOnRecipes` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `recipeId` on the `IngredientsOnRecipes` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `language` on the `Language` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `market` on the `Market` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `observations` on the `Market` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - The primary key for the `MarketUnit` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `MarketUnit` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `unitName` on the `MarketUnit` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `address` on the `MarketUnit` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - You are about to alter the column `coordinates` on the `MarketUnit` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - You are about to alter the column `unit` on the `MeasureUnit` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - The primary key for the `PriceLog` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `PriceLog` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `ingredientId` on the `PriceLog` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `marketUnitId` on the `PriceLog` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - The primary key for the `Recipe` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `Recipe` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `title` on the `Recipe` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - You are about to alter the column `authorId` on the `Recipe` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `template` on the `Recipe` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - You are about to alter the column `level` on the `RecipeLevel` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - The primary key for the `RecipesOnShoppingList` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `recipeId` on the `RecipesOnShoppingList` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `shoppingListId` on the `RecipesOnShoppingList` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - The primary key for the `ShoppingList` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `ShoppingList` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `title` on the `ShoppingList` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - You are about to alter the column `authorId` on the `ShoppingList` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - The primary key for the `Token` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `Token` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `userId` on the `Token` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - The primary key for the `User` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `User` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `email` on the `User` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - You are about to alter the column `username` on the `User` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `fullName` on the `User` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - You are about to alter the column `address` on the `User` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - You are about to alter the column `city` on the `User` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `avatar` on the `User` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(2000)`.
  - You are about to alter the column `hashedPassword` on the `User` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(100)`.
  - You are about to alter the column `utensil` on the `Utensil` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - The primary key for the `UtensilOnRecipe` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `recipeId` on the `UtensilOnRecipe` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `B` on the `_CategoryToRecipe` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `B` on the `_MarketToShoppingList` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.

*/
-- DropForeignKey
ALTER TABLE "DeliveryContact" DROP CONSTRAINT "DeliveryContact_marketUnitId_fkey";

-- DropForeignKey
ALTER TABLE "IngredientsOnRecipes" DROP CONSTRAINT "IngredientsOnRecipes_ingredientId_fkey";

-- DropForeignKey
ALTER TABLE "IngredientsOnRecipes" DROP CONSTRAINT "IngredientsOnRecipes_recipeId_fkey";

-- DropForeignKey
ALTER TABLE "PriceLog" DROP CONSTRAINT "PriceLog_ingredientId_fkey";

-- DropForeignKey
ALTER TABLE "PriceLog" DROP CONSTRAINT "PriceLog_marketUnitId_fkey";

-- DropForeignKey
ALTER TABLE "Recipe" DROP CONSTRAINT "Recipe_authorId_fkey";

-- DropForeignKey
ALTER TABLE "RecipesOnShoppingList" DROP CONSTRAINT "RecipesOnShoppingList_recipeId_fkey";

-- DropForeignKey
ALTER TABLE "RecipesOnShoppingList" DROP CONSTRAINT "RecipesOnShoppingList_shoppingListId_fkey";

-- DropForeignKey
ALTER TABLE "ShoppingList" DROP CONSTRAINT "ShoppingList_authorId_fkey";

-- DropForeignKey
ALTER TABLE "Token" DROP CONSTRAINT "Token_userId_fkey";

-- DropForeignKey
ALTER TABLE "UtensilOnRecipe" DROP CONSTRAINT "UtensilOnRecipe_recipeId_fkey";

-- DropForeignKey
ALTER TABLE "_CategoryToRecipe" DROP CONSTRAINT "_CategoryToRecipe_B_fkey";

-- DropForeignKey
ALTER TABLE "_MarketToShoppingList" DROP CONSTRAINT "_MarketToShoppingList_B_fkey";

-- DropIndex
DROP INDEX "Token_token_key";

-- AlterTable
ALTER TABLE "Category" ALTER COLUMN "category" SET DATA TYPE VARCHAR(36);

-- AlterTable
ALTER TABLE "Country" ALTER COLUMN "code" SET DATA TYPE VARCHAR(2),
ALTER COLUMN "country" SET DATA TYPE VARCHAR(36);

-- AlterTable
ALTER TABLE "Currency" ALTER COLUMN "code" SET DATA TYPE VARCHAR(3),
ALTER COLUMN "currency" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "symbol" SET DATA TYPE VARCHAR(3);

-- AlterTable
ALTER TABLE "DeliveryContact" ALTER COLUMN "site" SET DATA TYPE VARCHAR(255),
ALTER COLUMN "phone" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "marketUnitId" SET DATA TYPE VARCHAR(36);

-- AlterTable
ALTER TABLE "Ingredient" DROP CONSTRAINT "Ingredient_pkey",
ALTER COLUMN "id" SET DATA TYPE VARCHAR(36),
ADD CONSTRAINT "Ingredient_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "IngredientType" ALTER COLUMN "type" SET DATA TYPE VARCHAR(36);

-- AlterTable
ALTER TABLE "IngredientsOnRecipes" DROP CONSTRAINT "IngredientsOnRecipes_pkey",
ALTER COLUMN "ingredientId" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "recipeId" SET DATA TYPE VARCHAR(36),
ADD CONSTRAINT "IngredientsOnRecipes_pkey" PRIMARY KEY ("ingredientId", "recipeId");

-- AlterTable
ALTER TABLE "Language" ALTER COLUMN "language" SET DATA TYPE VARCHAR(36);

-- AlterTable
ALTER TABLE "Market" ALTER COLUMN "market" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "observations" SET DATA TYPE VARCHAR(255);

-- AlterTable
ALTER TABLE "MarketUnit" DROP CONSTRAINT "MarketUnit_pkey",
ALTER COLUMN "id" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "unitName" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "address" SET DATA TYPE VARCHAR(255),
ALTER COLUMN "coordinates" SET DATA TYPE VARCHAR(255),
ADD CONSTRAINT "MarketUnit_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "MeasureUnit" ALTER COLUMN "unit" SET DATA TYPE VARCHAR(36);

-- AlterTable
ALTER TABLE "PriceLog" DROP CONSTRAINT "PriceLog_pkey",
ALTER COLUMN "id" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "ingredientId" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "marketUnitId" SET DATA TYPE VARCHAR(36),
ADD CONSTRAINT "PriceLog_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "Recipe" DROP CONSTRAINT "Recipe_pkey",
ALTER COLUMN "id" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "title" SET DATA TYPE VARCHAR(255),
ALTER COLUMN "authorId" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "servings" SET DEFAULT 4,
ALTER COLUMN "template" SET DATA TYPE VARCHAR(255),
ADD CONSTRAINT "Recipe_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "RecipeLevel" ALTER COLUMN "level" SET DATA TYPE VARCHAR(36);

-- AlterTable
ALTER TABLE "RecipesOnShoppingList" DROP CONSTRAINT "RecipesOnShoppingList_pkey",
ALTER COLUMN "recipeId" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "shoppingListId" SET DATA TYPE VARCHAR(36),
ADD CONSTRAINT "RecipesOnShoppingList_pkey" PRIMARY KEY ("recipeId", "shoppingListId");

-- AlterTable
ALTER TABLE "ShoppingList" DROP CONSTRAINT "ShoppingList_pkey",
ALTER COLUMN "id" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "title" SET DATA TYPE VARCHAR(255),
ALTER COLUMN "authorId" SET DATA TYPE VARCHAR(36),
ADD CONSTRAINT "ShoppingList_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "Token" DROP CONSTRAINT "Token_pkey",
ALTER COLUMN "id" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "userId" SET DATA TYPE VARCHAR(36),
ADD CONSTRAINT "Token_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "User" DROP CONSTRAINT "User_pkey",
ALTER COLUMN "id" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "email" SET DATA TYPE VARCHAR(255),
ALTER COLUMN "username" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "fullName" SET DATA TYPE VARCHAR(255),
ALTER COLUMN "address" SET DATA TYPE VARCHAR(255),
ALTER COLUMN "city" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "avatar" SET DATA TYPE VARCHAR(2000),
ALTER COLUMN "hashedPassword" SET DATA TYPE VARCHAR(100),
ADD CONSTRAINT "User_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "Utensil" ALTER COLUMN "utensil" SET DATA TYPE VARCHAR(36);

-- AlterTable
ALTER TABLE "UtensilOnRecipe" DROP CONSTRAINT "UtensilOnRecipe_pkey",
ALTER COLUMN "recipeId" SET DATA TYPE VARCHAR(36),
ADD CONSTRAINT "UtensilOnRecipe_pkey" PRIMARY KEY ("utensilId", "recipeId");

-- AlterTable
ALTER TABLE "_CategoryToRecipe" ALTER COLUMN "B" SET DATA TYPE VARCHAR(36);

-- AlterTable
ALTER TABLE "_MarketToShoppingList" ALTER COLUMN "B" SET DATA TYPE VARCHAR(36);

-- AddForeignKey
ALTER TABLE "UtensilOnRecipe" ADD CONSTRAINT "UtensilOnRecipe_recipeId_fkey" FOREIGN KEY ("recipeId") REFERENCES "Recipe"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PriceLog" ADD CONSTRAINT "PriceLog_ingredientId_fkey" FOREIGN KEY ("ingredientId") REFERENCES "Ingredient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PriceLog" ADD CONSTRAINT "PriceLog_marketUnitId_fkey" FOREIGN KEY ("marketUnitId") REFERENCES "MarketUnit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DeliveryContact" ADD CONSTRAINT "DeliveryContact_marketUnitId_fkey" FOREIGN KEY ("marketUnitId") REFERENCES "MarketUnit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Recipe" ADD CONSTRAINT "Recipe_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "IngredientsOnRecipes" ADD CONSTRAINT "IngredientsOnRecipes_ingredientId_fkey" FOREIGN KEY ("ingredientId") REFERENCES "Ingredient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "IngredientsOnRecipes" ADD CONSTRAINT "IngredientsOnRecipes_recipeId_fkey" FOREIGN KEY ("recipeId") REFERENCES "Recipe"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShoppingList" ADD CONSTRAINT "ShoppingList_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RecipesOnShoppingList" ADD CONSTRAINT "RecipesOnShoppingList_recipeId_fkey" FOREIGN KEY ("recipeId") REFERENCES "Recipe"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RecipesOnShoppingList" ADD CONSTRAINT "RecipesOnShoppingList_shoppingListId_fkey" FOREIGN KEY ("shoppingListId") REFERENCES "ShoppingList"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Token" ADD CONSTRAINT "Token_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_MarketToShoppingList" ADD CONSTRAINT "_MarketToShoppingList_B_fkey" FOREIGN KEY ("B") REFERENCES "ShoppingList"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CategoryToRecipe" ADD CONSTRAINT "_CategoryToRecipe_B_fkey" FOREIGN KEY ("B") REFERENCES "Recipe"("id") ON DELETE CASCADE ON UPDATE CASCADE;
