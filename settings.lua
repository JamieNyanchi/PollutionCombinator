-- ================================================================
-- Settings
-- ================================================================


-- ================================================================
-- Requires
-- ================================================================

-- Constants for the mod
local mod_constants = require("scripts.constants");

-- ================================================================
-- Declarations
-- ================================================================

data:extend({
    -- Runtime global settings
    {
        type = "int-setting",
        name = mod_constants.setting_names.update_rate,
        setting_type = "runtime-global",
        default_value = 180,
        minimum_value = 1,
        maximum_value = 2147483647,
        order = "s01",
    },
    {
        type = "bool-setting",
        name = mod_constants.setting_names.update_distribute,
        setting_type = "runtime-global",
        default_value = true,
        order = "s02",
    },
});
