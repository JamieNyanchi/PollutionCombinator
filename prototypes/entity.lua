-- ================================================================
-- Entity
-- ================================================================


-- ================================================================
-- Requires
-- ================================================================

-- Constants for the mod
local mod_constants = require("scripts.constants");


-- ================================================================
-- Declarations
-- ================================================================

-- Copy base constant combinator entity
local pollution_combinator = table.deepcopy(data.raw["constant-combinator"]["constant-combinator"]);

-- Adjust values for the pollution combinator
pollution_combinator.name = mod_constants.prototype_names.pollution_combinator;
pollution_combinator.fast_replaceable_group = "constant-combinator";
pollution_combinator.next_upgrade = nil;

-- Ensure the minable result values and icon values are unset
pollution_combinator.minable.result = nil;
pollution_combinator.minable.count = nil;
pollution_combinator.icon = nil;
pollution_combinator.icon_size = nil;
pollution_combinator.icon_mipmaps = nil;

-- Replace minable results
pollution_combinator.minable.results = {
    { type = "item", name = mod_constants.prototype_names.pollution_combinator, amount = 1 },
};

-- Replace icon
pollution_combinator.icons = {
    {
        icon = mod_constants.mod_path .. "graphics/icons/pollution-combinator.png",
        icon_size = 64,
        icon_mipmaps = 4,
    },
};

-- Replace sprite images
pollution_combinator.sprites = make_4way_animation_from_spritesheet({
    layers = {
        {
            filename = mod_constants.mod_path .. "graphics/entity/pollution-combinator.png",
            width = 58,
            height = 52,
            frame_count = 1,
            shift = util.by_pixel(0, 5),
            hr_version =
            {
                scale = 0.5,
                filename = mod_constants.mod_path .. "graphics/entity/hr-pollution-combinator.png",
                width = 114,
                height = 102,
                frame_count = 1,
                shift = util.by_pixel(0, 5)
            },
        },
        {
            filename = "__base__/graphics/entity/combinator/constant-combinator-shadow.png",
            width = 50,
            height = 34,
            frame_count = 1,
            shift = util.by_pixel(9, 6),
            draw_as_shadow = true,
            hr_version =
            {
                scale = 0.5,
                filename = "__base__/graphics/entity/combinator/hr-constant-combinator-shadow.png",
                width = 98,
                height = 66,
                frame_count = 1,
                shift = util.by_pixel(8.5, 5.5),
                draw_as_shadow = true
            },
        },
    },
});

-- Add the pollution combinator entity
data:extend({
    pollution_combinator,
});
