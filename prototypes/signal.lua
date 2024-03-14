-- ================================================================
-- Signal
-- ================================================================


-- ================================================================
-- Requires
-- ================================================================

-- Constants for the mod
local pc_constants = require("constants");


-- ================================================================
-- Declarations
-- ================================================================

-- Add the pollution signal
data:extend({
  {
    type = "virtual-signal",
    name = pc_constants.signals.pollution_name,
    icons = {
      {
        icon = pc_constants.mod_path .. "graphics/icons/signal/pollution-signal.png",
        icon_size = 64,
        icon_mipmaps = 1,
        tint = pc_constants.tints.pollution,
      },
    },
    subgroup = "virtual-signal",
    order = "u[pollution]",
  },
});
