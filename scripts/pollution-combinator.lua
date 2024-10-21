-- ================================================================
-- Pollution Combinator
-- ================================================================


-- ================================================================
-- Requires
-- ================================================================

-- Constants for the mod
local mod_constants = require("scripts.constants");

-- Settings for the mod
local mod_settings = require("scripts.settings");


-- ================================================================
-- Members
-- ================================================================

-- Local references for global mod data
-- Set during on_init and on_load
---@type {pcs:{[number]:{control:LuaConstantCombinatorControlBehavior?, surface:LuaSurface, position:MapPosition, pollution:number}}, pcs_length:number, pcs_interval_length:number, pcs_current_index:number?, pcs_params:table}
local pc_data = nil;

-- Local references for global functions
local ceil = math.ceil;
local next = next;

-- Local copies of mod constants
local mod_name = mod_constants.mod_name;
local prototype_name_pollution_combinator = mod_constants.prototype_names.pollution_combinator;
local prototype_name_pollution_signal = mod_constants.prototype_names.pollution_signal;

-- Local copies of mod setting names
-- Only localize the names and use them to get the actual setting value later
local setting_name_update_rate = mod_constants.setting_names.update_rate;
local setting_name_update_distribute = mod_constants.setting_names.update_distribute;

-- Return data
---@type event_handler
local pollution_combinator = {};


-- ================================================================
-- Functions
-- ================================================================

-- ----------------------------------------------------------------
-- register_pollution_combinator
-- Adds new pollution combinators to the global list
-- ----------------------------------------------------------------
---@param entity LuaEntity
local function register_pollution_combinator(entity)
    -- Verify the entity is valid and is a pollution combinator
    -- Note: entity.valid should already have been checked by the calling function, so skip checking here to save the API call time
    if (not (pc_data and entity and entity.name == prototype_name_pollution_combinator)) then
        return;
    end

    -- Get the control behavior for the combinator
    ---@class LuaConstantCombinatorControlBehavior
    local control = entity.get_or_create_control_behavior();
    if (not (control and control.valid)) then
        return;
    end

    -- Set the combinator as inoperable
    entity.operable = false;

    -- Only increment the length if a new combinator is being added
    if (pc_data.pcs[entity.unit_number] == nil) then
        pc_data.pcs_length = pc_data.pcs_length + 1;
    end

    -- Get the position and pollution of the combinator
    local surface = entity.surface;
    local position = entity.position;
    local pollution = surface.get_pollution(position);

    -- Set the parameters of the combinator control
    -- Also clears out any extra signals that may have been set (by fast replacing, etc)
    local pcs_params = pc_data.pcs_params;
    pcs_params[1].count = pollution;
    control.parameters = pcs_params;

    -- Register or update the combinator entry
    pc_data.pcs[entity.unit_number] = {
        control = control,
        surface = surface,
        position = position,
        pollution = pollution,
    };
end

-- ----------------------------------------------------------------
-- unregister_pollution_combinator_by_index
-- Removes pollution combinators from the global list by index
-- ----------------------------------------------------------------
---@param index number
local function unregister_pollution_combinator_by_index(index)
    -- Verify the index is valid and a combinator exists at the index
    if (not (pc_data and index and pc_data.pcs[index])) then
        return;
    end

    -- Decrement the length
    pc_data.pcs_length = pc_data.pcs_length - 1;

    -- If the current interval index is the same as the index being removed, move to the next item in the list before removing
    if (pc_data.pcs_current_index == index) then
        pc_data.pcs_current_index, _ = next(pc_data.pcs, index)
    end

    -- Remove the combinator
    pc_data.pcs[index] = nil;
end

-- ----------------------------------------------------------------
-- unregister_pollution_combinator_by_entity
-- Removes pollution combinators from the global list by entity
-- ----------------------------------------------------------------
---@param entity LuaEntity
local function unregister_pollution_combinator_by_entity(entity)
    -- Verify the entity is valid and is a pollution combinator
    -- If not valid, but this entity is in the list, it'll be removed during the next traversal in on_tick()
    -- Note: entity.valid should already have been checked by the calling function, so skip checking here to save the API call time
    if (not (pc_data and entity and entity.name == prototype_name_pollution_combinator)) then
        return;
    end

    -- Remove the combinator by index
    unregister_pollution_combinator_by_index(entity.unit_number);
end

-- ----------------------------------------------------------------
-- initialize_global_data
-- Sets the global pollution combinator data to a new state and re-adds existing combinators to the list
-- ----------------------------------------------------------------
local function initialize_global_data()
    -- Initialize (or reset) the pollution combinator data
    pc_data = {
        -- Table of all pollution combinators
        pcs = {},
        pcs_length = 0,

        -- Data used for iterating over the combinators over multiple ticks
        pcs_interval_length = 0,
        pcs_current_index = nil,

        -- Table for setting the signal output for each combinator
        pcs_params = {
            {
                signal = {
                    type = "virtual",
                    name = prototype_name_pollution_signal,
                },
                count = 1,
                index = 1,
            },
        },
    };

    -- Set the global pollution combinator table
    global.PollutionCombinator = pc_data;

    -- Register all the existing pollution combinators on all surfaces
    for _, surface in pairs(game.surfaces) do
        for _, entity in pairs(surface.find_entities_filtered { name = prototype_name_pollution_combinator }) do
            register_pollution_combinator(entity);
        end
    end
end

-- ----------------------------------------------------------------
-- enable_recipes
-- Verifies and sets the recipe enabled state for each force
-- ----------------------------------------------------------------
local function enable_recipes()
    -- Set the recipe enabled state for each force
    for _, force in pairs(game.forces) do
        local recipes = force.recipes;
        local technologies = force.technologies;
        recipes[prototype_name_pollution_combinator].enabled = technologies["circuit-network"].researched;
    end
end


-- ================================================================
-- Event handlers
-- ================================================================

-- ----------------------------------------------------------------
-- on_init
-- Runs when starting a new save game, or for mods that are new to an existing one
-- ----------------------------------------------------------------
local function on_init()
    -- Initialize the global data and recipe enable state
    initialize_global_data();
    enable_recipes();
end

-- ----------------------------------------------------------------
-- on_load
-- Runs for every mod that has been a part of the save previously,
-- including when loading a save to connect to a running multiplayer session
-- ----------------------------------------------------------------
local function on_load()
    -- Set the local reference for the global data
    pc_data = global.PollutionCombinator;
end

-- ----------------------------------------------------------------
-- on_configuration_changed
-- Runs for all mods if the save's mod configuration has changed
-- ----------------------------------------------------------------
---@param event ConfigurationChangedData
local function on_configuration_changed(event)
    -- Check if this mod's configuration changed
    if (event.mod_changes and event.mod_changes[mod_name]) then
        -- Reinitialize the global data and recipe enable state
        initialize_global_data();
        enable_recipes();
    end
end

-- ----------------------------------------------------------------
-- on_tick
-- Primary logic function for updating pollution values on combinators
-- Updates values on multiples of the update tick rate
-- ----------------------------------------------------------------
---@param event EventData.on_tick
local function on_tick(event)
    -- Stop if the pollution combinator data is not initialized
    if (not pc_data) then
        return;
    end

    -- Stop if there are no pollution combinators
    local pcs_length = pc_data.pcs_length;
    if (pcs_length <= 0) then
        return;
    end

    -- Localize the combinator and traversal data
    local pcs = pc_data.pcs;
    local pcs_current_index = nil;
    local pcs_current_entry = nil;
    local pcs_interval_length = nil;
    local pcs_signal = pc_data.pcs_params[1];

    -- Get the current update rate from the settings
    local settings_update_rate = mod_settings[setting_name_update_rate];

    -- If the current tick is a multiple of the update rate, reset the current array index and recalculate the interval amount
    if (event.tick % settings_update_rate == 0) then
        -- Get whether the update should be distributed over multiple ticks from the settings
        local settings_update_distribute = mod_settings[setting_name_update_distribute];

        -- Calculate and save the new interval length
        pcs_interval_length = settings_update_distribute and ceil(pcs_length / settings_update_rate) or pcs_length;
        pc_data.pcs_interval_length = pcs_interval_length;

        -- Initiate the new interval
        -- Use next() instead of pairs() to get the index for later
        pcs_current_index, pcs_current_entry = next(pcs, nil);
    else
        -- Ensure the local variables are set
        pcs_current_index = pc_data.pcs_current_index;
        pcs_current_entry = pcs[pcs_current_index];
        pcs_interval_length = pc_data.pcs_interval_length;
    end

    -- Iterate across the list of combinators
    for _ = 1, pcs_interval_length, 1 do
        -- If the index or entry are nil, stop here and wait for the next update interval
        if (pcs_current_index == nil or pcs_current_entry == nil) then
            break;
        end

        -- Get the next combinator in the list
        -- Use next() instead of pairs() to get the index for later
        local pcs_next_index, pcs_next_entry = next(pcs, pcs_current_index);

        -- Get the new pollution value for the current entry
        local surface = pcs_current_entry.surface;
        local position = pcs_current_entry.position;
        local pollution = surface.get_pollution(position);

        -- Check if the combinator needs updating
        -- Saves an API call to set the signal otherwise
        if (pcs_current_entry.pollution ~= pollution) then
            pcs_current_entry.pollution = pollution;
            pcs_signal.count = pollution;

            -- Verify the entity control is valid, and update the combinator if so
            local control = pcs_current_entry.control;
            if (control and control.valid) then
                -- Use set_signal instead of parameters for better performance
                control.set_signal(1, pcs_signal);
            else
                -- If the entity control isn't valid, remove it from the list
                -- This is safe to do while traversing with next()
                unregister_pollution_combinator_by_index(pcs_current_index);
            end
        end

        -- Set the new index and entry for the next loop
        pcs_current_index = pcs_next_index;
        pcs_current_entry = pcs_next_entry;
    end

    -- Save the current index for the next tick
    pc_data.pcs_current_index = pcs_current_index;
end

-- ----------------------------------------------------------------
-- on_entity_built
-- Called whenever an entity was built
-- ----------------------------------------------------------------
---@param event EventData.on_built_entity|EventData.on_robot_built_entity|EventData.on_entity_cloned|EventData.script_raised_built|EventData.script_raised_revive
local function on_entity_built(event)
    -- Verify the entity is valid and is a pollution combinator
    local entity = event.created_entity or event.entity or event.destination;
    if (entity and entity.valid and entity.name == prototype_name_pollution_combinator) then
        register_pollution_combinator(entity);
    end
end

-- ----------------------------------------------------------------
-- on_entity_removed
-- Called whenever an entity was removed
-- ----------------------------------------------------------------
---@param event EventData.on_player_mined_entity|EventData.on_robot_mined_entity|EventData.on_entity_died|EventData.script_raised_destroy
local function on_entity_removed(event)
    -- Verify the entity is valid and is a pollution combinator
    local entity = event.entity;
    if (entity and entity.valid and entity.name == prototype_name_pollution_combinator) then
        unregister_pollution_combinator_by_entity(entity);
    end
end

-- ----------------------------------------------------------------
-- on_entity_moved
-- Updates the data of a pollution combinator if one was moved
-- ----------------------------------------------------------------
---@param event EventData.script_raised_teleported|{moved_entity:number}
local function on_entity_moved(event)
    -- Verify the entity is valid and is a pollution combinator
    local entity = event.entity or event.moved_entity;
    if (entity and entity.valid and entity.name == prototype_name_pollution_combinator) then
        register_pollution_combinator(entity);
    end
end

-- ----------------------------------------------------------------
-- register_modded_events
-- Conditionally registers custom events from mods
-- ----------------------------------------------------------------
local function register_modded_events()
    -- Register moved event for PickerDollies
    if (remote.interfaces["PickerDollies"] and remote.interfaces["PickerDollies"]["dolly_moved_entity_id"]) then
        pollution_combinator.events = pollution_combinator.events or {};
        pollution_combinator.events[remote.call("PickerDollies", "dolly_moved_entity_id")] = on_entity_moved;
    end
end

-- ================================================================
-- Event registration
-- ================================================================

-- Load / Initialize events
pollution_combinator.on_init = on_init;
pollution_combinator.on_load = on_load;
pollution_combinator.on_configuration_changed = on_configuration_changed;

-- Remote interface events
-- Intended to add our own remote interface, but we use it to register remote interface events from other mods
pollution_combinator.add_remote_interface = register_modded_events;

-- Standard events
pollution_combinator.events = {
    -- Tick events
    [defines.events.on_tick] = on_tick,
};

-- Filtered events
-- Register these outside of the event handler so we can use filters, which are more efficient
-- If another file in this mod wants to register any of these events in the future, move it to the event handler without the filter

-- Filter for the events
local filters = { { filter = "name", name = prototype_name_pollution_combinator } };

-- Built events
script.on_event(defines.events.on_built_entity, on_entity_built, filters);
script.on_event(defines.events.on_robot_built_entity, on_entity_built, filters);
script.on_event(defines.events.on_entity_cloned, on_entity_built, filters);
script.on_event(defines.events.script_raised_built, on_entity_built, filters);
script.on_event(defines.events.script_raised_revive, on_entity_built, filters);

-- Destroyed events
script.on_event(defines.events.on_player_mined_entity, on_entity_removed, filters);
script.on_event(defines.events.on_robot_mined_entity, on_entity_removed, filters);
script.on_event(defines.events.on_entity_died, on_entity_removed, filters);
script.on_event(defines.events.script_raised_destroy, on_entity_removed, filters);

-- Moved events
script.on_event(defines.events.script_raised_teleported, on_entity_moved, filters);

-- Return
return pollution_combinator;
