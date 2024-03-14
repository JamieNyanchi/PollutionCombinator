-- ================================================================
-- Technology
-- ================================================================


-- ================================================================
-- Requires
-- ================================================================

-- Constants for the mod
local pc_constants = require("constants");


-- ================================================================
-- Declarations
-- ================================================================

-- Add the recipe to the circuit network technology
table.insert(data.raw["technology"]["circuit-network"].effects, {
    type = "unlock-recipe",
    recipe = pc_constants.recipes.pollution_combinator_name,
});
