-- ================================================================
-- Settings
-- ================================================================


-- ================================================================
-- Requires
-- ================================================================

-- Constants for the mod
local pc_constants = require("constants");

-- ================================================================
-- Declarations
-- ================================================================

data:extend({
    -- Runtime global settings
    {
        type = "int-setting",
        name = pc_constants.settings.update_rate,
        setting_type = "runtime-global",
        default_value = 32,
        minimum_value = 1,
        maximum_value = 2147483647,
        order = "s01",
    },
    {
        type = "bool-setting",
        name = pc_constants.settings.update_distribute,
        setting_type = "runtime-global",
        default_value = true,
        order = "s02",
    },
});
