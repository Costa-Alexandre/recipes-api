ALTER TABLE "User"
ADD CONSTRAINT valid_email CHECK ("email" LIKE '%_@_%');