ALTER TABLE "Ingredient"
ADD CONSTRAINT non_empty_string CHECK ("ingredient" <> '');