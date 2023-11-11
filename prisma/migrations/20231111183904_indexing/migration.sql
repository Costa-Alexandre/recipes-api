-- CreateIndex
CREATE INDEX "idx_ingredients_type" ON "Ingredient"("typeId");

-- CreateIndex
CREATE INDEX "idx_ingredients_ingredient" ON "Ingredient"("ingredient");

-- CreateIndex
CREATE INDEX "idx_ingredient_on_recipe_ingredient" ON "IngredientsOnRecipes"("ingredientId");

-- CreateIndex
CREATE INDEX "MarketUnit_marketId_idx" ON "MarketUnit"("marketId");

-- CreateIndex
CREATE INDEX "idx_price_logs_ingredient" ON "PriceLog"("ingredientId");

-- CreateIndex
CREATE INDEX "idx_price_logs_market_unit" ON "PriceLog"("marketUnitId");

-- CreateIndex
CREATE INDEX "idx_price_logs_date" ON "PriceLog"("date");

-- CreateIndex
CREATE INDEX "idx_price_logs_user" ON "PriceLog"("userId");

-- CreateIndex
CREATE INDEX "PriceLog_price_idx" ON "PriceLog"("price");

-- CreateIndex
CREATE INDEX "idx_price_logs_combined" ON "PriceLog"("ingredientId", "marketUnitId", "date", "userId", "price");

-- CreateIndex
CREATE INDEX "idx_recipes_level" ON "Recipe"("recipeLevelId");

-- CreateIndex
CREATE INDEX "idx_recipes_author" ON "Recipe"("authorId");

-- CreateIndex
CREATE INDEX "idx_recipes_title" ON "Recipe"("title");

-- CreateIndex
CREATE INDEX "idx_recipes_created_at" ON "Recipe"("createdAt");

-- CreateIndex
CREATE INDEX "idx_recipe_on_shopping_list_recipe" ON "RecipesOnShoppingList"("recipeId");

-- CreateIndex
CREATE INDEX "idx_shopping_list_author" ON "ShoppingList"("authorId");

-- CreateIndex
CREATE INDEX "idx_shopping_list_title" ON "ShoppingList"("title");

-- CreateIndex
CREATE INDEX "idx_utensil_on_recipe_utensil" ON "UtensilOnRecipe"("utensilId");
