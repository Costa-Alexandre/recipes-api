/*
  Warnings:

  - A unique constraint covering the columns `[currency]` on the table `Currency` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "Currency_currency_key" ON "Currency"("currency");
