-- =====================================================================
-- THEME: default
-- =====================================================================
-- COLORES (Inyectados directamente al core de Hyprland desde Lua)
local color = require("modules/colors")
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 20,
        border_size = 2,
        col = {
            active_border   = color.on_primary_container,
            inactive_border = color.on_primary,
        },
    },
    decoration = {
        rounding       = 10,
        rounding_power = 2,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow = { enabled = true, range = 4, render_power = 3, color = color.background },
        blur   = { enabled = true, size = 3, passes = 1, vibrancy = 0.1696 },
    },
    animations = { enabled = true },
})

