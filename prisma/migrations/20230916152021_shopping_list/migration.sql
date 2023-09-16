/*
  Warnings:

  - Added the required column `servings` to the `Recipe` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "SelectionCriteria" AS ENUM ('PRICE', 'DISTANCE', 'AVAILABILITY');

-- AlterTable
ALTER TABLE "Recipe" ADD COLUMN     "servings" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "ShoppingList" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL DEFAULT 'My Shopping List',
    "authorId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "selectionCriteria" "SelectionCriteria",

    CONSTRAINT "ShoppingList_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RecipesOnShoppingList" (
    "recipeId" TEXT NOT NULL,
    "shoppingListId" TEXT NOT NULL,
    "servings" INTEGER NOT NULL,

    CONSTRAINT "RecipesOnShoppingList_pkey" PRIMARY KEY ("recipeId","shoppingListId")
);

-- CreateTable
CREATE TABLE "_MarketToShoppingList" (
    "A" INTEGER NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_MarketToShoppingList_AB_unique" ON "_MarketToShoppingList"("A", "B");

-- CreateIndex
CREATE INDEX "_MarketToShoppingList_B_index" ON "_MarketToShoppingList"("B");

-- AddForeignKey
ALTER TABLE "ShoppingList" ADD CONSTRAINT "ShoppingList_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RecipesOnShoppingList" ADD CONSTRAINT "RecipesOnShoppingList_recipeId_fkey" FOREIGN KEY ("recipeId") REFERENCES "Recipe"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RecipesOnShoppingList" ADD CONSTRAINT "RecipesOnShoppingList_shoppingListId_fkey" FOREIGN KEY ("shoppingListId") REFERENCES "ShoppingList"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_MarketToShoppingList" ADD CONSTRAINT "_MarketToShoppingList_A_fkey" FOREIGN KEY ("A") REFERENCES "Market"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_MarketToShoppingList" ADD CONSTRAINT "_MarketToShoppingList_B_fkey" FOREIGN KEY ("B") REFERENCES "ShoppingList"("id") ON DELETE CASCADE ON UPDATE CASCADE;
