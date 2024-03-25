# Pollution Combinator (Jamie's Fork) #
This is a forked and updated version of starruler's [Pollution Combinator mod](https://mods.factorio.com/mod/pollution-combinator). It adds a new, simple combinator that outputs the amount of pollution in the chunk where it is placed as a new pollution signal.

# Changes from original #
- **Performance Improvements**: Pollution combinators now update every 180 game ticks (3 seconds) instead of every single game tick, and the update is distributed over multiple ticks instead of all on a single tick. The code is also more optimized to avoid unnecessary API calls when possible, further improving performance.
- **New Settings**: Two new settings were added to allow the user to control how often the combinators should update. If you want the combinators to update as frequently as the original mod, you can change the update rate to every 1 tick in the settings.
- **New Appearance**: Thanks to [S6X's](https://mods.factorio.com/user/S6X) kind contribution, the pollution combinators have now been recolored purple to differentiate them from other combinators.
- **Picker Dollies Support**: Full support has been added for the Picker Dollies mod. When you move the combinators around with that mod, they will now update to output the pollution amount of their new position.
- **Other Minor Fixes**: Includes various small fixes such as listening to more build/destroy events to ensure all placed combinators work as expected.

# Migration #
If you are switching from the original mod to this version, then everything will transfer over and work perfectly fine. There's no extra steps necessary. All your existing combinators and circuit networks will continue working.

**Important**: This mod is not compatible with the original mod. If you enable this mod, you must disable the original. Please note that due to some changes, such as renaming the pollution signal's internal name, it will not be possible to seamlessly go back to the original if you save with this mod active. If you only wish to try out this mod and not commit to switching, please make a copy of your existing save first.

# Performance notes #
I did not conduct any full, proper performance tests. However, when playing on default settings and with 400 pollution combinators placed, I have a 95% performance impact reduction compared to the original mod. Even when updating on every tick like the original mod, I have a 30% performance impact reduction compared to the original mod. If you need further performance impact reductions, use the settings to update the combinators even less frequently than the default.

# Future #
There is still some room for potential further performance improvements. However, the current changes should still be great for most players! If you'd like to contribute to help improve the mod further, feel free to check the Github and submit a pull request!
