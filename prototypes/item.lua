-- ================================================================
-- Item
-- ================================================================


-- ================================================================
-- Requires
-- ================================================================

-- Constants for the mod
local mod_constants = require("scripts.constants");


-- ================================================================
-- Declarations
-- ================================================================

-- Copy base constant combinator item
local pollution_combinator = table.deepcopy(data.raw["item"]["constant-combinator"]);

-- Adjust values for the pollution combinator
pollution_combinator.name = mod_constants.prototype_names.pollution_combinator;
pollution_combinator.place_result = mod_constants.prototype_names.pollution_combinator;
pollution_combinator.stack_size = 50;

-- Ensure icon values are unset
pollution_combinator.icon = nil;
pollution_combinator.icon_size = nil;
pollution_combinator.icon_mipmaps = nil;

-- Set the subgroup and order
pollution_combinator.subgroup = "circuit-network";
pollution_combinator.order = "c[combinators]-d[pollution-combinator]";

-- Replace icon
pollution_combinator.icons = {
    {
        icon = mod_constants.mod_path .. "graphics/icons/pollution-combinator.png",
        icon_size = 64,
        icon_mipmaps = 4,
    },
};

-- Add the pollution combinator icon
data:extend({
    pollution_combinator,
});
