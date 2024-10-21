-- ================================================================
-- Signal
-- ================================================================


-- ================================================================
-- Requires
-- ================================================================

-- Constants for the mod
local mod_constants = require("scripts.constants");


-- ================================================================
-- Declarations
-- ================================================================

-- Create the pollution signal
local pollution_signal = {};

-- Set values for the pollution signal
pollution_signal.name = mod_constants.prototype_names.pollution_signal;
pollution_signal.type = "virtual-signal";

-- Set the subgroup and order
pollution_signal.subgroup = "virtual-signal";
pollution_signal.order = "u[pollution]";

-- Set the signal icon
pollution_signal.icons = {
    {
        icon = mod_constants.mod_path .. "graphics/icons/signal/pollution-signal.png",
        icon_size = 64,
        icon_mipmaps = 1,
        tint = mod_constants.tints.pollution,
    },
};

-- Add the pollution signal
data:extend({
    pollution_signal,
});
