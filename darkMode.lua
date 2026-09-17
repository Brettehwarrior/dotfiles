
-- DARK MODE https://www.reddit.com/r/hyprland/comments/1h4abmt/how_do_i_apply_dark_theme/

-- -- for libadwaita gtk4 apps you can use this command:
-- local gtk4_theme = "gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"   -- for GTK4 apps

-- -- for gtk3 apps you need to install adw-gtk3 theme (in arch linux sudo pacman -S adw-gtk-theme)
-- local gtk3_theme = "gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'"   -- for GTK3 apps

-- -- for kde apps you need to install: sudo pacman -S qt5ct qt6ct kvantum kvantum breeze-icons
-- -- you will need to set dark theme for qt apps from kde more difficult thans with gnome :D:
-- local env_qt_theme_var = "QT_QPA_PLATFORMTHEME"   -- for Qt apps# Them
-- local qt_theme = "qt6ct"

-- hl.on("hyprland.start", function ()
--   hl.exec_cmd(gtk4_theme)
--   hl.exec_cmd(gtk3_theme)
-- end)

-- hl.env(env_qt_theme_var, qt_theme)

hl.env("GTK_THEME", "Breeze-Dark")
hl.env("QT_STYLE_OVERRIDE", "Breeze-Dark")
hl.env("QT_QPA_PLATFORMTHEME", "kde")
hl.on("hyprland.start", function ()
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-application-prefer-dark-theme true")
end)