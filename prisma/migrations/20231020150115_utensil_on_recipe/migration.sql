/*
  Warnings:

  - You are about to drop the `_RecipeToUtensil` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "_RecipeToUtensil" DROP CONSTRAINT "_RecipeToUtensil_A_fkey";

-- DropForeignKey
ALTER TABLE "_RecipeToUtensil" DROP CONSTRAINT "_RecipeToUtensil_B_fkey";

-- DropTable
DROP TABLE "_RecipeToUtensil";

-- CreateTable
CREATE TABLE "UtensilOnRecipe" (
    "utensilId" INTEGER NOT NULL,
    "recipeId" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,

    CONSTRAINT "UtensilOnRecipe_pkey" PRIMARY KEY ("utensilId","recipeId")
);

-- AddForeignKey
ALTER TABLE "UtensilOnRecipe" ADD CONSTRAINT "UtensilOnRecipe_utensilId_fkey" FOREIGN KEY ("utensilId") REFERENCES "Utensil"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UtensilOnRecipe" ADD CONSTRAINT "UtensilOnRecipe_recipeId_fkey" FOREIGN KEY ("recipeId") REFERENCES "Recipe"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
