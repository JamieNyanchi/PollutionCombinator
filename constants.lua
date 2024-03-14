-- ================================================================
-- Constants
-- ================================================================


-- ================================================================
-- Members
-- ================================================================

-- Constants table
local constants = {};

-- Mod constants
constants.mod_prefix = "pc:";
constants.mod_name = "PollutionCombinator-JamieFork";
constants.mod_path = "__" .. constants.mod_name .. "__/";

-- Entity constants
constants.entities = {
    pollution_combinator_name = constants.mod_prefix .. "pollution-combinator",
};

-- Item constants
constants.items = {
    pollution_combinator_name = constants.mod_prefix .. "pollution-combinator",
};

-- Recipe constants
constants.recipes = {
    pollution_combinator_name = constants.mod_prefix .. "pollution-combinator",
};

-- Signal constants
constants.signals = {
    pollution_name = constants.mod_prefix .. "pollution-signal",
};

-- Tint constants
constants.tints = {
    pollution = { r = 179 / 255, g = 74 / 255, b = 194 / 255, a = 1 },

    -- Original tint color (darker purple)
    -- pollution = {r = 93/255, g = 34/255, b = 102/255, a = 1};
};

-- Settings constants
constants.settings = {
    update_rate = constants.mod_prefix .. "update-rate",
    update_distribute = constants.mod_prefix .. "update-distribute",
};

-- Return
return constants;
