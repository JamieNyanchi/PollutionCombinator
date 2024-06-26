-- ================================================================
-- Recipe
-- ================================================================


-- ================================================================
-- Requires
-- ================================================================

-- Constants for the mod
local pc_constants = require("constants");


-- ================================================================
-- Declarations
-- ================================================================

-- Copy base constant combinator recipe
local pc = table.deepcopy(data.raw["recipe"]["constant-combinator"]);

-- Adjust values for the pollution combinator
pc.name = pc_constants.recipes.pollution_combinator_name;
pc.result = pc_constants.items.pollution_combinator_name;
pc.enabled = false;

pc.ingredients = {
    { "constant-combinator", 1 },
    { "electronic-circuit",  1 },
};

-- Add the pollution combinator recipe
data:extend({
    pc,
});
