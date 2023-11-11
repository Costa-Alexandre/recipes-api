-- checks that hashedPassword starts with $2b$10$
-- and has exactly 60 characters

ALTER TABLE "User" 
  ADD CONSTRAINT hashed_password 
  CHECK ("hashedPassword" ~* '^\$2b\$10\$[\S]{53}$');