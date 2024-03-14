-- ================================================================
-- Entity
-- ================================================================


-- ================================================================
-- Requires
-- ================================================================

-- Constants for the mod
local pc_constants = require("constants");


-- ================================================================
-- Declarations
-- ================================================================

-- Copy base constant combinator entity
local pc = table.deepcopy(data.raw["constant-combinator"]["constant-combinator"]);

-- Adjust values for the pollution combinator
pc.name = pc_constants.entities.pollution_combinator_name;
pc.minable.result = pc_constants.items.pollution_combinator_name;
pc.item_slot_count = 1;

-- Replace icon with pollution combinator icon
pc.icon = pc_constants.mod_path .. "graphics/icons/pollution-combinator.png";
pc.icon_size = 64;
pc.icon_mipmaps = 4;

-- Replace the sprite images with the pollution combinator sprite images
for _, sprite in pairs(pc.sprites) do
    local image = sprite.layers[1];
    image.filename = pc_constants.mod_path .. "graphics/entity/pollution-combinator.png";
    image.hr_version.filename = pc_constants.mod_path .. "graphics/entity/hr-pollution-combinator.png";
end

-- Add the pollution combinator entity
data:extend({
    pc,
});
