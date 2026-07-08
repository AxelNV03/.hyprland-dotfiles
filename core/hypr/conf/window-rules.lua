-- =====================================================================
-- WINDOW RULES
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- =====================================================================

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})

-- Regla de ventana para el monitor de procesos flotante lanzado desde Waybar
hl.window_rule({
  match = { 
    class = "waybar-monitor" 
  },
  float = true,
  size  = { "850", "550" }, -- La API pide strings para expresiones o medidas fijas
  center = true
})