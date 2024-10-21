-- ================================================================
-- Technology
-- ================================================================


-- ================================================================
-- Requires
-- ================================================================

-- Constants for the mod
local mod_constants = require("scripts.constants");


-- ================================================================
-- Declarations
-- ================================================================

-- Add the pollution combinator recipe to the circuit network technology
table.insert(data.raw["technology"]["circuit-network"].effects, {
    type = "unlock-recipe",
    recipe = mod_constants.prototype_names.pollution_combinator,
});
