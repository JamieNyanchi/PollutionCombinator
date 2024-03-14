-- ================================================================
-- Item
-- ================================================================


-- ================================================================
-- Requires
-- ================================================================

-- Constants for the mod
local pc_constants = require("constants");


-- ================================================================
-- Declarations
-- ================================================================

-- Copy base constant combinator item
local pc = table.deepcopy(data.raw["item"]["constant-combinator"]);

-- Adjust values for the pollution combinator
pc.name = pc_constants.items.pollution_combinator_name;
pc.place_result = pc_constants.entities.pollution_combinator_name;
pc.stack_size = 50;

pc.icon = pc_constants.mod_path .. "graphics/icons/pollution-combinator.png";
pc.icon_size = 64;
pc.icon_mipmaps = 4;

pc.subgroup = "circuit-network";
pc.order = "c[combinators]-d[pollution-combinator]";

-- Add the pollution combinator icon
data:extend({
    pc,
});
