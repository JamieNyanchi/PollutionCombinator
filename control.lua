-- ================================================================
-- Control
-- ================================================================


-- ================================================================
-- Requires
-- ================================================================

-- Constants for the mod
local pc_constants = require("constants");

-- Factorio Lua's built in event handler
local handler = require("__core__/lualib/event_handler");


-- ================================================================
-- Main
-- ================================================================

-- Register events
handler.add_libraries({
    require(pc_constants.mod_path .. "scripts/settings"),
    require(pc_constants.mod_path .. "scripts/pollution-combinator"),
});
