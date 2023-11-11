ALTER TABLE "Recipe"
ADD CONSTRAINT non_empty_string CHECK ("title" <> '');