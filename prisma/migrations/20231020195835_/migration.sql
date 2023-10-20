/*
  Warnings:

  - You are about to alter the column `ingredient` on the `Ingredient` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.

*/
-- AlterTable
ALTER TABLE "Ingredient" ALTER COLUMN "ingredient" SET DATA TYPE VARCHAR(36);
