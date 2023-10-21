/*
  Warnings:

  - You are about to alter the column `price` on the `PriceLog` table. The data in that column could be lost. The data in that column will be cast from `Money` to `Decimal(10,2)`.

*/
-- AlterTable
ALTER TABLE "PriceLog" ALTER COLUMN "price" SET DATA TYPE DECIMAL(10,2);
