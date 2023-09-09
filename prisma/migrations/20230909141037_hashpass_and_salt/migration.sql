/*
  Warnings:

  - The primary key for the `Ingredient` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `IngredientsOnRecipes` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `MarketUnit` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Recipe` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - Added the required column `hashPassword` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `saltPassword` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "DeliveryContact" DROP CONSTRAINT "DeliveryContact_marketUnitId_fkey";

-- DropForeignKey
ALTER TABLE "IngredientsOnRecipes" DROP CONSTRAINT "IngredientsOnRecipes_ingredientId_fkey";

-- DropForeignKey
ALTER TABLE "IngredientsOnRecipes" DROP CONSTRAINT "IngredientsOnRecipes_recipeId_fkey";

-- DropForeignKey
ALTER TABLE "_CategoryToRecipe" DROP CONSTRAINT "_CategoryToRecipe_B_fkey";

-- DropForeignKey
ALTER TABLE "_RecipeToUtensil" DROP CONSTRAINT "_RecipeToUtensil_A_fkey";

-- AlterTable
ALTER TABLE "DeliveryContact" ALTER COLUMN "marketUnitId" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "Ingredient" DROP CONSTRAINT "Ingredient_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "Ingredient_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "Ingredient_id_seq";

-- AlterTable
ALTER TABLE "IngredientsOnRecipes" DROP CONSTRAINT "IngredientsOnRecipes_pkey",
ALTER COLUMN "ingredientId" SET DATA TYPE TEXT,
ALTER COLUMN "recipeId" SET DATA TYPE TEXT,
ADD CONSTRAINT "IngredientsOnRecipes_pkey" PRIMARY KEY ("ingredientId", "recipeId");

-- AlterTable
ALTER TABLE "MarketUnit" DROP CONSTRAINT "MarketUnit_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "MarketUnit_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "MarketUnit_id_seq";

-- AlterTable
ALTER TABLE "Recipe" DROP CONSTRAINT "Recipe_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "Recipe_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "Recipe_id_seq";

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "hashPassword" TEXT NOT NULL,
ADD COLUMN     "saltPassword" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "_CategoryToRecipe" ALTER COLUMN "B" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "_RecipeToUtensil" ALTER COLUMN "A" SET DATA TYPE TEXT;

-- CreateTable
CREATE TABLE "PriceLog" (
    "id" TEXT NOT NULL,
    "ingredientId" TEXT NOT NULL,
    "marketUnitId" TEXT NOT NULL,
    "date" DATE NOT NULL,
    "price" MONEY NOT NULL,

    CONSTRAINT "PriceLog_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "PriceLog" ADD CONSTRAINT "PriceLog_ingredientId_fkey" FOREIGN KEY ("ingredientId") REFERENCES "Ingredient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PriceLog" ADD CONSTRAINT "PriceLog_marketUnitId_fkey" FOREIGN KEY ("marketUnitId") REFERENCES "MarketUnit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DeliveryContact" ADD CONSTRAINT "DeliveryContact_marketUnitId_fkey" FOREIGN KEY ("marketUnitId") REFERENCES "MarketUnit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "IngredientsOnRecipes" ADD CONSTRAINT "IngredientsOnRecipes_ingredientId_fkey" FOREIGN KEY ("ingredientId") REFERENCES "Ingredient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "IngredientsOnRecipes" ADD CONSTRAINT "IngredientsOnRecipes_recipeId_fkey" FOREIGN KEY ("recipeId") REFERENCES "Recipe"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_RecipeToUtensil" ADD CONSTRAINT "_RecipeToUtensil_A_fkey" FOREIGN KEY ("A") REFERENCES "Recipe"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CategoryToRecipe" ADD CONSTRAINT "_CategoryToRecipe_B_fkey" FOREIGN KEY ("B") REFERENCES "Recipe"("id") ON DELETE CASCADE ON UPDATE CASCADE;
