-- ================================================================
-- Settings
-- ================================================================


-- ================================================================
-- Requires
-- ================================================================

-- Constants for the mod
local mod_constants = require("scripts.constants");


-- ================================================================
-- Members
-- ================================================================

-- Create mod setting table
local mod_settings = {};

-- Populate settings table with all mod settings
for _, setting in pairs(mod_constants.setting_names) do
    if (settings.global[setting]) then
        mod_settings[setting] = settings.global[setting].value;
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
    if (mod_settings[event.setting] ~= nil) then
        mod_settings[event.setting] = settings.global[event.setting].value;
    end
end


-- ================================================================
-- Event registration
-- ================================================================

-- Standard events
mod_settings.events = {
    -- Settings events
    [defines.events.on_runtime_mod_setting_changed] = on_runtime_mod_setting_changed,
};

-- Return mod setting table
return mod_settings;
