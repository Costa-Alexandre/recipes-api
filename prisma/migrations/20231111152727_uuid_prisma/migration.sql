/*
  Warnings:

  - The primary key for the `Ingredient` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `IngredientsOnRecipes` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `MarketUnit` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `PriceLog` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Recipe` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `RecipesOnShoppingList` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `ShoppingList` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Token` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `User` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `UtensilOnRecipe` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - Changed the type of `marketUnitId` on the `DeliveryContact` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `id` on the `Ingredient` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `ingredientId` on the `IngredientsOnRecipes` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `recipeId` on the `IngredientsOnRecipes` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `id` on the `MarketUnit` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `id` on the `PriceLog` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `ingredientId` on the `PriceLog` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `marketUnitId` on the `PriceLog` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Added the required column `userId` to the `PriceLog` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `id` on the `Recipe` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `authorId` on the `Recipe` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `recipeId` on the `RecipesOnShoppingList` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `shoppingListId` on the `RecipesOnShoppingList` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `id` on the `ShoppingList` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `authorId` on the `ShoppingList` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `id` on the `Token` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `userId` on the `Token` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `id` on the `User` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `recipeId` on the `UtensilOnRecipe` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `B` on the `_CategoryToRecipe` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `B` on the `_MarketToShoppingList` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

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
ALTER TABLE "PriceLog" DROP CONSTRAINT "PriceLog_userId_fkey";

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

-- AlterTable
ALTER TABLE "DeliveryContact" DROP COLUMN "marketUnitId",
ADD COLUMN     "marketUnitId" UUID NOT NULL;

-- AlterTable
ALTER TABLE "Ingredient" DROP CONSTRAINT "Ingredient_pkey",
DROP COLUMN "id",
ADD COLUMN     "id" UUID NOT NULL,
ADD CONSTRAINT "Ingredient_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "IngredientsOnRecipes" DROP CONSTRAINT "IngredientsOnRecipes_pkey",
DROP COLUMN "ingredientId",
ADD COLUMN     "ingredientId" UUID NOT NULL,
DROP COLUMN "recipeId",
ADD COLUMN     "recipeId" UUID NOT NULL,
ADD CONSTRAINT "IngredientsOnRecipes_pkey" PRIMARY KEY ("ingredientId", "recipeId");

-- AlterTable
ALTER TABLE "MarketUnit" DROP CONSTRAINT "MarketUnit_pkey",
DROP COLUMN "id",
ADD COLUMN     "id" UUID NOT NULL,
ADD CONSTRAINT "MarketUnit_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "PriceLog" DROP CONSTRAINT "PriceLog_pkey",
DROP COLUMN "id",
ADD COLUMN     "id" UUID NOT NULL,
DROP COLUMN "ingredientId",
ADD COLUMN     "ingredientId" UUID NOT NULL,
DROP COLUMN "marketUnitId",
ADD COLUMN     "marketUnitId" UUID NOT NULL,
DROP COLUMN "userId",
ADD COLUMN     "userId" UUID NOT NULL,
ADD CONSTRAINT "PriceLog_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "Recipe" DROP CONSTRAINT "Recipe_pkey",
DROP COLUMN "id",
ADD COLUMN     "id" UUID NOT NULL,
DROP COLUMN "authorId",
ADD COLUMN     "authorId" UUID NOT NULL,
ADD CONSTRAINT "Recipe_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "RecipesOnShoppingList" DROP CONSTRAINT "RecipesOnShoppingList_pkey",
DROP COLUMN "recipeId",
ADD COLUMN     "recipeId" UUID NOT NULL,
DROP COLUMN "shoppingListId",
ADD COLUMN     "shoppingListId" UUID NOT NULL,
ADD CONSTRAINT "RecipesOnShoppingList_pkey" PRIMARY KEY ("recipeId", "shoppingListId");

-- AlterTable
ALTER TABLE "ShoppingList" DROP CONSTRAINT "ShoppingList_pkey",
DROP COLUMN "id",
ADD COLUMN     "id" UUID NOT NULL,
DROP COLUMN "authorId",
ADD COLUMN     "authorId" UUID NOT NULL,
ADD CONSTRAINT "ShoppingList_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "Token" DROP CONSTRAINT "Token_pkey",
DROP COLUMN "id",
ADD COLUMN     "id" UUID NOT NULL,
DROP COLUMN "userId",
ADD COLUMN     "userId" UUID NOT NULL,
ADD CONSTRAINT "Token_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "User" DROP CONSTRAINT "User_pkey",
DROP COLUMN "id",
ADD COLUMN     "id" UUID NOT NULL,
ADD CONSTRAINT "User_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "UtensilOnRecipe" DROP CONSTRAINT "UtensilOnRecipe_pkey",
DROP COLUMN "recipeId",
ADD COLUMN     "recipeId" UUID NOT NULL,
ADD CONSTRAINT "UtensilOnRecipe_pkey" PRIMARY KEY ("utensilId", "recipeId");

-- AlterTable
ALTER TABLE "_CategoryToRecipe" DROP COLUMN "B",
ADD COLUMN     "B" UUID NOT NULL;

-- AlterTable
ALTER TABLE "_MarketToShoppingList" DROP COLUMN "B",
ADD COLUMN     "B" UUID NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "_CategoryToRecipe_AB_unique" ON "_CategoryToRecipe"("A", "B");

-- CreateIndex
CREATE INDEX "_CategoryToRecipe_B_index" ON "_CategoryToRecipe"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_MarketToShoppingList_AB_unique" ON "_MarketToShoppingList"("A", "B");

-- CreateIndex
CREATE INDEX "_MarketToShoppingList_B_index" ON "_MarketToShoppingList"("B");

-- AddForeignKey
ALTER TABLE "UtensilOnRecipe" ADD CONSTRAINT "UtensilOnRecipe_recipeId_fkey" FOREIGN KEY ("recipeId") REFERENCES "Recipe"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PriceLog" ADD CONSTRAINT "PriceLog_ingredientId_fkey" FOREIGN KEY ("ingredientId") REFERENCES "Ingredient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PriceLog" ADD CONSTRAINT "PriceLog_marketUnitId_fkey" FOREIGN KEY ("marketUnitId") REFERENCES "MarketUnit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PriceLog" ADD CONSTRAINT "PriceLog_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

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
