-- ================================================================
-- Recipe
-- ================================================================


-- ================================================================
-- Requires
-- ================================================================

-- Constants for the mod
local mod_constants = require("scripts.constants");


-- ================================================================
-- Declarations
-- ================================================================

-- Copy base constant combinator recipe
local pollution_combinator = table.deepcopy(data.raw["recipe"]["constant-combinator"]);

-- Adjust values for the pollution combinator
pollution_combinator.name = mod_constants.prototype_names.pollution_combinator;
pollution_combinator.enabled = false;

-- Replace ingredients
pollution_combinator.ingredients = {
    { type = "item", name = "constant-combinator", amount = 1 },
    { type = "item", name = "electronic-circuit",  amount = 1 },
};

-- Replace results
pollution_combinator.results = {
    { type = "item", name = mod_constants.prototype_names.pollution_combinator, amount = 1 },
};

-- Add the pollution combinator recipe
data:extend({
    pollution_combinator,
});
