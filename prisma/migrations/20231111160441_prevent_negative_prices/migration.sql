ALTER TABLE "PriceLog"
ADD CONSTRAINT positive_price CHECK ("price" > 0);