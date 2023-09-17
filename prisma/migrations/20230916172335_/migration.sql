/*
  Warnings:

  - You are about to alter the column `code` on the `Language` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(2)`.

*/
-- AlterTable
ALTER TABLE "Language" ALTER COLUMN "code" SET DATA TYPE VARCHAR(2);
