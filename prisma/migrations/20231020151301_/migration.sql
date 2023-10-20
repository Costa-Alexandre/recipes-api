/*
  Warnings:

  - You are about to drop the column `image` on the `Recipe` table. All the data in the column will be lost.
  - You are about to drop the column `instructions` on the `Recipe` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Recipe" DROP COLUMN "image",
DROP COLUMN "instructions",
ADD COLUMN     "template" TEXT;
