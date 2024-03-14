-- ================================================================
-- Data
-- ================================================================


-- ================================================================
-- Requires
-- ================================================================

-- Constants for the mod
local pc_constants = require("constants");


-- ================================================================
-- Main
-- ================================================================

-- Entities
require(pc_constants.mod_path .. "prototypes/entity");

-- Items
require(pc_constants.mod_path .. "prototypes/item");

-- Recipes
require(pc_constants.mod_path .. "prototypes/recipe");

-- Signals
require(pc_constants.mod_path .. "prototypes/signal");

-- Technology
require(pc_constants.mod_path .. "prototypes/technology");
