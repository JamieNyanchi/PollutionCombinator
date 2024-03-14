-- ================================================================
-- Settings
-- ================================================================


-- ================================================================
-- Requires
-- ================================================================

-- Constants for the mod
local pc_constants = require("constants");


-- ================================================================
-- Members
-- ================================================================

-- Return data
local pc_settings = {};

-- Populate return data with all mod settings
for _, setting in pairs(pc_constants.settings) do
    if (settings.global[setting]) then
        pc_settings[setting] = settings.global[setting].value;
    end
end


-- ================================================================
-- Functions
-- ================================================================


-- ================================================================
-- Event handlers
-- ================================================================

-- ----------------------------------------------------------------
-- on_runtime_mod_setting_changed
-- Updates the local copy of the settings when they change
-- ----------------------------------------------------------------
---@param event EventData.on_runtime_mod_setting_changed
local function on_runtime_mod_setting_changed(event)
    if (pc_settings[event.setting] ~= nil) then
        pc_settings[event.setting] = settings.global[event.setting].value;
    end
end


-- ================================================================
-- Event registration
-- ================================================================

-- Standard events
pc_settings.events = {
    -- Settings events
    [defines.events.on_runtime_mod_setting_changed] = on_runtime_mod_setting_changed,
};

return pc_settings;
