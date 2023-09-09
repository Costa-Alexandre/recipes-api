/*
  Warnings:

  - You are about to drop the column `saltPassword` on the `User` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "User" DROP COLUMN "saltPassword";
