-- ================================================================
-- Constants
-- ================================================================


-- ================================================================
-- Members
-- ================================================================

-- Constants table
local constants = {};

-- Mod constants
constants.mod_name = "PollutionCombinator-JamieFork";
constants.mod_path = "__" .. constants.mod_name .. "__/";
constants.mod_prefix = "pc-";

-- Prototype name constants
constants.prototype_names = {
    pollution_combinator = constants.mod_prefix .. "pollution-combinator",
    pollution_signal = constants.mod_prefix .. "pollution-signal",
};

-- Setting name constants
constants.setting_names = {
    update_rate = constants.mod_prefix .. "update-rate",
    update_distribute = constants.mod_prefix .. "update-distribute",
};

-- Tint constants
constants.tints = {
    pollution = { r = 179 / 255, g = 74 / 255, b = 194 / 255, a = 1 },

    -- Original mod tint color (darker purple)
    -- pollution = {r = 93/255, g = 34/255, b = 102/255, a = 1};
};

-- Return constants table
return constants;
