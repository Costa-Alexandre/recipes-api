ALTER TABLE "Recipe"
ADD CONSTRAINT positive_servings CHECK ("servings" > 0);