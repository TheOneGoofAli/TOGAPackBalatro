sendInfoMessage("Initializing additional UI...", "TOGAPack")

local clr = {0,0,0,0.8}
function G.FUNCS.toga_execrestart(e)
	SMODS.full_restart = (SMODS.full_restart or 0) + 1
	G.FUNCS.exit_mods(e)
end

function G.FUNCS.toga_closeprompt(e)
	if G.ACTIVE_MOD_UI == togabalatro then G.FUNCS.openModUI_TOGAPack(e) else G.FUNCS.exit_overlay_menu(e) end
end

function togabalatro.oobeuifunc()
	local introtext = G.localization.misc.ui_strings.toga_intro
	play_sound('toga_chord', 1, 0.5)
	play_sound('toga_winnt4startorig', 1, 0.5)
	return { n = G.UIT.ROOT, config = { align = "cm", colour = clr, padding = 32.01, r = 0.1, minw = 5, id = 'toga_intro'}, nodes = {
		{n = G.UIT.C, config = { align = "cl", outline = 1, outline_colour = HEX('C3C3C3'), colour = G.C.UI.BACKGROUND_INACTIVE, padding = 0.035 }, nodes = {
			{n = G.UIT.R, config = {align = "cl", colour = HEX('000082'), minw = 11.5}, nodes = {
				{n = G.UIT.C, config = { align = "cl", padding = 0.1 }, nodes = {
					{n = G.UIT.T, config = { text = introtext[1], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
				}},
			}},
			{n = G.UIT.R, config = { align = "cl", minw = 5 }, nodes = {
				{n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {
					{n = G.UIT.O, config = { w = 1, h = 1, object = Sprite(36, 36, 36, 36, G.ASSET_ATLAS['toga_TOGAMoreIcons'], { x = 5, y = 0 }) } },
				}},
				{n = G.UIT.C, config = { align = "cl", padding = -0.05}, nodes = {
					{n = G.UIT.R, config = { align = "cl", padding = 0.2 }, nodes = {
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = introtext[2], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = introtext[3], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = introtext[4], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = introtext[5], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = introtext[6], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
					}},
				}},
			}},
			{n = G.UIT.R, config = {align = "cm", colour = HEX('c0c0c0'), padding = 0.15}, nodes = {
				{n = G.UIT.C, config = { align = "cm" }, nodes = {
					UIBox_button({label = { localize('toga_yes') }, button = "openModUI_TOGAPack", minw = 2, minh = 0.65, colour = HEX('555555')})
				}},
				{n = G.UIT.C, config = { align = "cm" }, nodes = {
					UIBox_button({label = { localize('toga_no') }, button = "toga_closeprompt", minw = 2, minh = 0.65, colour = HEX('555555')})
				}},
			}},
		}},
	}}
end

function togabalatro.needrestart()
	local rtxt = G.localization.misc.ui_strings.toga_needrestart
	play_sound('toga_chord', 1, 0.5)
	return { n = G.UIT.ROOT, config = { align = "cm", colour = clr, padding = 32.01, r = 0.1, minw = 5, id = 'toga_needrestart'}, nodes = {
		{n = G.UIT.C, config = { align = "cl", outline = 1, outline_colour = HEX('C3C3C3'), colour = G.C.UI.BACKGROUND_INACTIVE, padding = 0.035 }, nodes = {
			{n = G.UIT.R, config = {align = "cl", colour = HEX('000082'), minw = 5}, nodes = {
				{n = G.UIT.C, config = { align = "cl", padding = 0.1 }, nodes = {
					{n = G.UIT.T, config = { text = rtxt[1], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
				}},
			}},
			{n = G.UIT.R, config = { align = "cl", minw = 5 }, nodes = {
				{n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {
					{n = G.UIT.O, config = { w = 1, h = 1, object = Sprite(36, 36, 36, 36, G.ASSET_ATLAS['toga_TOGAMoreIcons'], { x = 6, y = 0 }) } },
				}},
				{n = G.UIT.C, config = { align = "cl", padding = -0.05}, nodes = {
					{n = G.UIT.R, config = { align = "cl", padding = 0.2 }, nodes = {
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = rtxt[2], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = rtxt[3], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = rtxt[4], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = rtxt[5], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
					}},
				}},
			}},
			{n = G.UIT.R, config = {align = "cm", colour = HEX('c0c0c0'), padding = 0.15}, nodes = {
				{n = G.UIT.C, config = { align = "cm" }, nodes = {
					UIBox_button({label = { localize('toga_yes') }, button = "toga_execrestart", minw = 2, minh = 0.65, colour = HEX('555555')})
				}},
				{n = G.UIT.C, config = { align = "cm" }, nodes = {
					UIBox_button({label = { localize('toga_no') }, button = "toga_closeprompt", minw = 2, minh = 0.65, colour = HEX('555555')})
				}},
			}},
		}},
	}}
end

function togabalatro.needrestartqeui()
	local rtxt = G.localization.misc.ui_strings.toga_needrestartqe
	play_sound('toga_chord', 1, 0.5)
	return { n = G.UIT.ROOT, config = { align = "cm", colour = clr, padding = 32.01, r = 0.1, minw = 5, id = 'toga_needrestart'}, nodes = {
		{n = G.UIT.C, config = { align = "cl", outline = 1, outline_colour = HEX('C3C3C3'), colour = G.C.UI.BACKGROUND_INACTIVE, padding = 0.035 }, nodes = {
			{n = G.UIT.R, config = {align = "cl", colour = HEX('000082'), minw = 5}, nodes = {
				{n = G.UIT.C, config = { align = "cl", padding = 0.1 }, nodes = {
					{n = G.UIT.T, config = { text = rtxt[1], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
				}},
			}},
			{n = G.UIT.R, config = { align = "cl", minw = 5 }, nodes = {
				{n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {
					{n = G.UIT.O, config = { w = 1, h = 1, object = Sprite(36, 36, 36, 36, G.ASSET_ATLAS['toga_TOGAMoreIcons'], { x = 6, y = 0 }) } },
				}},
				{n = G.UIT.C, config = { align = "cl", padding = -0.05}, nodes = {
					{n = G.UIT.R, config = { align = "cl", padding = 0.2 }, nodes = {
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = rtxt[2], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = rtxt[3], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = rtxt[4], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = rtxt[5], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
					}},
				}},
			}},
			{n = G.UIT.R, config = {align = "cm", colour = HEX('c0c0c0'), padding = 0.15}, nodes = {
				{n = G.UIT.C, config = { align = "cm" }, nodes = {
					UIBox_button({label = { localize('toga_yes') }, button = "toga_execrestart", minw = 2, minh = 0.65, colour = HEX('555555')})
				}},
				{n = G.UIT.C, config = { align = "cm" }, nodes = {
					UIBox_button({label = { localize('toga_no') }, button = "toga_closeprompt", minw = 2, minh = 0.65, colour = HEX('555555')})
				}},
			}},
		}},
	}}
end

function G.FUNCS.toga_enableallitemsBMP(e)
	togabalatro.config.BMPAllItems = true
	G.FUNCS.exit_overlay_menu(e)
end

function G.FUNCS.toga_disableallitemsBMP(e)
	togabalatro.config.BMPAllItems = nil
	G.FUNCS.exit_overlay_menu(e)
end

function togabalatro.bmpnoteui_normal()
	local bmpntxt = G.localization.misc.ui_strings.toga_bmpnormal
	play_sound('toga_dingy', 1, 0.8)
	return { n = G.UIT.ROOT, config = { align = "cm", colour = clr, padding = 32.01, r = 0.1, minw = 5, id = 'toga_bmpnote'}, nodes = {
		{n = G.UIT.C, config = { align = "cl", outline = 1, outline_colour = HEX('C3C3C3'), colour = G.C.UI.BACKGROUND_INACTIVE, padding = 0.035 }, nodes = {
			{n = G.UIT.R, config = {align = "cl", colour = HEX('000082'), minw = 5}, nodes = {
				{n = G.UIT.C, config = { align = "cl", padding = 0.1 }, nodes = {
					{n = G.UIT.T, config = { text = bmpntxt[1], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
				}},
			}},
			{n = G.UIT.R, config = { align = "cl", minw = 5 }, nodes = {
				{n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {
					{n = G.UIT.O, config = { w = 1, h = 1, object = Sprite(36, 36, 36, 36, G.ASSET_ATLAS['mp_modicon'], { x = 0, y = 0 }) } },
				}},
				{n = G.UIT.C, config = { align = "cl", padding = -0.05}, nodes = {
					{n = G.UIT.R, config = { align = "cl", padding = 0.2 }, nodes = {
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = bmpntxt[2], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = bmpntxt[3], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = bmpntxt[4], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
					}},
				}},
			}},
			{n = G.UIT.R, config = {align = "cm", colour = HEX('c0c0c0'), padding = 0.15}, nodes = {
				{n = G.UIT.C, config = { align = "cm" }, nodes = {
					UIBox_button({label = { localize('toga_ok') }, button = "exit_overlay_menu", minw = 2, minh = 0.65, colour = HEX('555555')})
				}},
				{n = G.UIT.C, config = { align = "cm" }, nodes = {
					UIBox_button({label = { localize('toga_loaddisitems') }, button = "toga_enableallitemsBMP", minw = 4.6, minh = 0.65, colour = HEX('555555')})
				}},
			}},
		}},
	}}
end

function togabalatro.bmpnoteui_allitems()
	local bmpatxt = G.localization.misc.ui_strings.toga_bmpallitems
	play_sound('toga_dingy', 1, 0.8)
	return { n = G.UIT.ROOT, config = { align = "cm", colour = clr, padding = 32.01, r = 0.1, minw = 5, id = 'toga_bmpnote_alt'}, nodes = {
		{n = G.UIT.C, config = { align = "cl", outline = 1, outline_colour = HEX('C3C3C3'), colour = G.C.UI.BACKGROUND_INACTIVE, padding = 0.035 }, nodes = {
			{n = G.UIT.R, config = {align = "cl", colour = HEX('000082'), minw = 5}, nodes = {
				{n = G.UIT.C, config = { align = "cl", padding = 0.1 }, nodes = {
					{n = G.UIT.T, config = { text = bmpatxt[1], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
				}},
			}},
			{n = G.UIT.R, config = { align = "cl", minw = 5 }, nodes = {
				{n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {
					{n = G.UIT.O, config = { w = 1, h = 1, object = Sprite(36, 36, 36, 36, G.ASSET_ATLAS['mp_modicon'], { x = 0, y = 0 }) } },
				}},
				{n = G.UIT.C, config = { align = "cl", padding = -0.05}, nodes = {
					{n = G.UIT.R, config = { align = "cl", padding = 0.2 }, nodes = {
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = bmpatxt[2], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = bmpatxt[3], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = bmpatxt[4], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = bmpatxt[5], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = bmpatxt[6], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
					}},
				}},
			}},
			{n = G.UIT.R, config = {align = "cm", colour = HEX('c0c0c0'), padding = 0.15}, nodes = {
				{n = G.UIT.C, config = { align = "cm" }, nodes = {
					UIBox_button({label = { localize('toga_ok') }, button = "exit_overlay_menu", minw = 2, minh = 0.65, colour = HEX('555555')})
				}},
				{n = G.UIT.C, config = { align = "cm" }, nodes = {
					UIBox_button({label = { localize('toga_unloaddisitems') }, button = "toga_disableallitemsBMP", minw = 6, minh = 0.65, colour = HEX('555555')})
				}},
			}},
		}},
	}}
end

function togabalatro.needrestartbmpui()
	local bmprtxt = G.localization.misc.ui_strings.toga_needrestartbmp
	play_sound('toga_chord', 1, 0.5)
	return { n = G.UIT.ROOT, config = { align = "cm", colour = clr, padding = 32.01, r = 0.1, minw = 5, id = 'toga_needrestartbmp'}, nodes = {
		{n = G.UIT.C, config = { align = "cl", outline = 1, outline_colour = HEX('C3C3C3'), colour = G.C.UI.BACKGROUND_INACTIVE, padding = 0.035 }, nodes = {
			{n = G.UIT.R, config = {align = "cl", colour = HEX('000082'), minw = 5}, nodes = {
				{n = G.UIT.C, config = { align = "cl", padding = 0.1 }, nodes = {
					{n = G.UIT.T, config = { text = bmprtxt[1], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
				}},
			}},
			{n = G.UIT.R, config = { align = "cl", minw = 5 }, nodes = {
				{n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {
					{n = G.UIT.O, config = { w = 1, h = 1, object = Sprite(36, 36, 36, 36, G.ASSET_ATLAS['toga_TOGAMoreIcons'], { x = 6, y = 0 }) } },
				}},
				{n = G.UIT.C, config = { align = "cl", padding = -0.05}, nodes = {
					{n = G.UIT.R, config = { align = "cl", padding = 0.2 }, nodes = {
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = bmprtxt[2], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = bmprtxt[3], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = bmprtxt[4], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = bmprtxt[5], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
					}},
				}},
			}},
			{n = G.UIT.R, config = {align = "cm", colour = HEX('c0c0c0'), padding = 0.15}, nodes = {
				{n = G.UIT.C, config = { align = "cm" }, nodes = {
					UIBox_button({label = { localize('toga_yes') }, button = "toga_execrestart", minw = 2, minh = 0.65, colour = HEX('555555')})
				}},
				{n = G.UIT.C, config = { align = "cm" }, nodes = {
					UIBox_button({label = { localize('toga_no') }, button = "toga_closeprompt", minw = 2, minh = 0.65, colour = HEX('555555')})
				}},
			}},
		}},
	}}
end

function togabalatro.needrestartkingcdi()
	local rtxt = G.localization.misc.ui_strings.toga_needrestartkingcdi
	play_sound('toga_chord', 1, 0.5)
	return { n = G.UIT.ROOT, config = { align = "cm", colour = clr, padding = 32.01, r = 0.1, minw = 5, id = 'toga_needrestart'}, nodes = {
		{n = G.UIT.C, config = { align = "cl", outline = 1, outline_colour = HEX('C3C3C3'), colour = G.C.UI.BACKGROUND_INACTIVE, padding = 0.035 }, nodes = {
			{n = G.UIT.R, config = {align = "cl", colour = HEX('000082'), minw = 5}, nodes = {
				{n = G.UIT.C, config = { align = "cl", padding = 0.1 }, nodes = {
					{n = G.UIT.T, config = { text = rtxt[1], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
				}},
			}},
			{n = G.UIT.R, config = { align = "cl", minw = 5 }, nodes = {
				{n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {
					{n = G.UIT.O, config = { w = 1, h = 1, object = Sprite(36, 36, 36, 36, G.ASSET_ATLAS['toga_TOGAMoreIcons'], { x = 6, y = 0 }) } },
				}},
				{n = G.UIT.C, config = { align = "cl", padding = -0.05}, nodes = {
					{n = G.UIT.R, config = { align = "cl", padding = 0.2 }, nodes = {
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = rtxt[2], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = rtxt[3], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = rtxt[4], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = rtxt[5], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
					}},
				}},
			}},
			{n = G.UIT.R, config = {align = "cm", colour = HEX('c0c0c0'), padding = 0.15}, nodes = {
				{n = G.UIT.C, config = { align = "cm" }, nodes = {
					UIBox_button({label = { localize('toga_yes') }, button = "toga_execrestart", minw = 2, minh = 0.65, colour = HEX('555555')})
				}},
				{n = G.UIT.C, config = { align = "cm" }, nodes = {
					UIBox_button({label = { localize('toga_no') }, button = "toga_closeprompt", minw = 2, minh = 0.65, colour = HEX('555555')})
				}},
			}},
		}},
	}}
end

function togabalatro.needrestartwtfdeck()
	local rtxt = G.localization.misc.ui_strings.toga_needrestartwtfdeck
	play_sound('toga_chord', 1, 0.5)
	return { n = G.UIT.ROOT, config = { align = "cm", colour = clr, padding = 32.01, r = 0.1, minw = 5, id = 'toga_needrestart'}, nodes = {
		{n = G.UIT.C, config = { align = "cl", outline = 1, outline_colour = HEX('C3C3C3'), colour = G.C.UI.BACKGROUND_INACTIVE, padding = 0.035 }, nodes = {
			{n = G.UIT.R, config = {align = "cl", colour = HEX('000082'), minw = 5}, nodes = {
				{n = G.UIT.C, config = { align = "cl", padding = 0.1 }, nodes = {
					{n = G.UIT.T, config = { text = rtxt[1], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
				}},
			}},
			{n = G.UIT.R, config = { align = "cl", minw = 5 }, nodes = {
				{n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {
					{n = G.UIT.O, config = { w = 1, h = 1, object = Sprite(36, 36, 36, 36, G.ASSET_ATLAS['toga_TOGAMoreIcons'], { x = 6, y = 0 }) } },
				}},
				{n = G.UIT.C, config = { align = "cl", padding = -0.05}, nodes = {
					{n = G.UIT.R, config = { align = "cl", padding = 0.2 }, nodes = {
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = rtxt[2], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = rtxt[3], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = rtxt[4], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = rtxt[5], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
					}},
				}},
			}},
			{n = G.UIT.R, config = {align = "cm", colour = HEX('c0c0c0'), padding = 0.15}, nodes = {
				{n = G.UIT.C, config = { align = "cm" }, nodes = {
					UIBox_button({label = { localize('toga_yes') }, button = "toga_execrestart", minw = 2, minh = 0.65, colour = HEX('555555')})
				}},
				{n = G.UIT.C, config = { align = "cm" }, nodes = {
					UIBox_button({label = { localize('toga_no') }, button = "toga_closeprompt", minw = 2, minh = 0.65, colour = HEX('555555')})
				}},
			}},
		}},
	}}
end

function togabalatro.albanianvirusnote()
	local rtxt = G.localization.misc.ui_strings.toga_albavirusnote
	play_sound('toga_chord', 1, 0.5)
	return { n = G.UIT.ROOT, config = { align = "cm", colour = clr, padding = 32.01, r = 0.1, minw = 5, id = 'toga_albavirusnote'}, nodes = {
		{n = G.UIT.C, config = { align = "cl", outline = 1, outline_colour = HEX('C3C3C3'), colour = G.C.UI.BACKGROUND_INACTIVE, padding = 0.035 }, nodes = {
			{n = G.UIT.R, config = {align = "cl", colour = HEX('000082'), minw = 5}, nodes = {
				{n = G.UIT.C, config = { align = "cl", padding = 0.1 }, nodes = {
					{n = G.UIT.T, config = { text = rtxt[1], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
				}},
			}},
			{n = G.UIT.R, config = { align = "cl", minw = 5 }, nodes = {
				{n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {
					{n = G.UIT.O, config = { w = 1, h = 1, object = Sprite(36, 36, 36, 36, G.ASSET_ATLAS['toga_TOGAMoreIcons'], { x = 1, y = 0 }) } },
				}},
				{n = G.UIT.C, config = { align = "cl", padding = -0.05}, nodes = {
					{n = G.UIT.R, config = { align = "cl", padding = 0.2 }, nodes = {
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = rtxt[2], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = rtxt[3], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = rtxt[4], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
					}},
				}},
			}},
			{n = G.UIT.R, config = {align = "cm", colour = HEX('c0c0c0'), padding = 0.15}, nodes = {
				{n = G.UIT.C, config = { align = "cm" }, nodes = {
					UIBox_button({label = { localize('toga_ok') }, button = "exit_overlay_menu", minw = 2, minh = 0.65, colour = HEX('555555')})
				}},
			}},
		}},
	}}
end

function togabalatro.stjnoteui()
	local stjtxt = G.localization.misc.ui_strings.toga_stjnote
	play_sound('toga_dingy', 1, 0.8)
	return { n = G.UIT.ROOT, config = { align = "cm", colour = clr, padding = 32.01, r = 0.1, minw = 5, id = 'toga_stjnote'}, nodes = {
		{n = G.UIT.C, config = { align = "cl", outline = 1, outline_colour = HEX('C3C3C3'), colour = G.C.UI.BACKGROUND_INACTIVE, padding = 0.035 }, nodes = {
			{n = G.UIT.R, config = {align = "cl", colour = HEX('000082'), minw = 5}, nodes = {
				{n = G.UIT.C, config = { align = "cl", padding = 0.1 }, nodes = {
					{n = G.UIT.T, config = { text = stjtxt[1], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
				}},
			}},
			{n = G.UIT.R, config = { align = "cl", minw = 5 }, nodes = {
				{n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {
					{n = G.UIT.O, config = { w = 1, h = 1, object = Sprite(36, 36, 36, 36, G.ASSET_ATLAS['stj_modicon'], { x = 0, y = 0 }) } },
				}},
				{n = G.UIT.C, config = { align = "cl", padding = -0.05}, nodes = {
					{n = G.UIT.R, config = { align = "cl", padding = 0.2 }, nodes = {
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = stjtxt[2], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = stjtxt[3], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = stjtxt[4], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
					}},
				}},
			}},
			{n = G.UIT.R, config = {align = "cm", colour = HEX('c0c0c0'), padding = 0.15}, nodes = {
				{n = G.UIT.C, config = { align = "cm" }, nodes = {
					UIBox_button({label = { localize('toga_ok') }, button = "exit_overlay_menu", minw = 2, minh = 0.65, colour = HEX('555555')})
				}},
			}},
		}},
	}}
end

function togabalatro.qualatronote()
	local stjtxt = G.localization.misc.ui_strings.toga_qualatro
	play_sound('toga_dingy', 1, 0.8)
	return { n = G.UIT.ROOT, config = { align = "cm", colour = clr, padding = 32.01, r = 0.1, minw = 5, id = 'toga_qualatronote'}, nodes = {
		{n = G.UIT.C, config = { align = "cl", outline = 1, outline_colour = HEX('C3C3C3'), colour = G.C.UI.BACKGROUND_INACTIVE, padding = 0.035 }, nodes = {
			{n = G.UIT.R, config = {align = "cl", colour = HEX('000082'), minw = 5}, nodes = {
				{n = G.UIT.C, config = { align = "cl", padding = 0.1 }, nodes = {
					{n = G.UIT.T, config = { text = stjtxt[1], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
				}},
			}},
			{n = G.UIT.R, config = { align = "cl", minw = 5 }, nodes = {
				{n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {
					{n = G.UIT.O, config = { w = 1, h = 1, object = Sprite(36, 36, 36, 36, G.ASSET_ATLAS['qualatro_modicon'], { x = 0, y = 0 }) } },
				}},
				{n = G.UIT.C, config = { align = "cl", padding = -0.05}, nodes = {
					{n = G.UIT.R, config = { align = "cl", padding = 0.2 }, nodes = {
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = stjtxt[2], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
					}},
				}},
			}},
			{n = G.UIT.R, config = {align = "cm", colour = HEX('c0c0c0'), padding = 0.15}, nodes = {
				{n = G.UIT.C, config = { align = "cm" }, nodes = {
					UIBox_button({label = { localize('toga_ok') }, button = "exit_overlay_menu", minw = 2, minh = 0.65, colour = HEX('555555')})
				}},
			}},
		}},
	}}
end

function togabalatro.talismanjoke()
	local rtxt = G.localization.misc.ui_strings.toga_talismanjoke
	play_sound('toga_chord', 1, 0.5)
	return { n = G.UIT.ROOT, config = { align = "cm", colour = clr, padding = 32.01, r = 0.1, minw = 5, id = 'toga_talismanjoke'}, nodes = {
		{n = G.UIT.C, config = { align = "cl", outline = 1, outline_colour = HEX('C3C3C3'), colour = G.C.UI.BACKGROUND_INACTIVE, padding = 0.035 }, nodes = {
			{n = G.UIT.R, config = {align = "cl", colour = HEX('000082'), minw = 5}, nodes = {
				{n = G.UIT.C, config = { align = "cl", padding = 0.1 }, nodes = {
					{n = G.UIT.T, config = { text = rtxt[1], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
				}},
			}},
			{n = G.UIT.R, config = { align = "cl", minw = 5 }, nodes = {
				{n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {
					{n = G.UIT.O, config = { w = 1, h = 1, object = Sprite(36, 36, 36, 36, G.ASSET_ATLAS['talisman_modicon'], { x = 0, y = 0 }) } },
				}},
				{n = G.UIT.C, config = { align = "cl", padding = -0.05}, nodes = {
					{n = G.UIT.R, config = { align = "cl", padding = 0.2 }, nodes = {
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = rtxt[2], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
						{n = G.UIT.R, config = { align = "cl", padding = -0.05 }, nodes = {
							{n = G.UIT.T, config = { text = rtxt[3], scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
						}},
					}},
				}},
			}},
			{n = G.UIT.R, config = {align = "cm", colour = HEX('c0c0c0'), padding = 0.15}, nodes = {
				{n = G.UIT.C, config = { align = "cm" }, nodes = {
					UIBox_button({label = { localize('toga_ok') }, button = "exit_overlay_menu", minw = 2, minh = 0.65, colour = HEX('555555')})
				}},
			}},
		}},
	}}
end

function togabalatro.msoobe()
	if not togabalatro.config.oobe then
		togabalatro.config.oobe = true
		togabalatro.has_tried_startup = true
		SMODS.save_mod_config(togabalatro)
		G.SETTINGS.paused = true
		G.FUNCS.overlay_menu({
			definition = togabalatro.oobeuifunc(),
			config = {
				align = "cm",
				offset = {x = 0, y = 0},
				bond = 'Weak',
				no_esc = true,
				no_back = true,
			}
		})
	end
end

-- If we have a source that is passing a UI function along, return it or fallback to generic.
local function theuifuncs(args)
	if args.source and type(args.uifunc) == 'function' then return args.uifunc else return togabalatro.needrestart end
end

function togabalatro.systemchanges(args)
	args = args or {}
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = theuifuncs(args)(),
		config = {
			align = "cm",
			offset = {x = 0, y = 0},
			bond = 'Weak',
			no_esc = true,
			no_back = true,
		}
	})
end

function togabalatro.albavirusnoted()
	if not togabalatro.config.albavirusnoted then
		togabalatro.config.albavirusnoted = true
		G.SETTINGS.paused = true
		G.FUNCS.overlay_menu({
			definition = togabalatro.albanianvirusnote(),
			config = {
				align = "cm",
				offset = {x = 0, y = 0},
				bond = 'Weak',
				no_esc = true,
				no_back = true,
			}
		})
	end
end

function togabalatro.bmpnote()
	if not togabalatro.config.mpnotice then
		togabalatro.config.mpnotice = true
		G.SETTINGS.paused = true
		G.FUNCS.overlay_menu({
			definition = togabalatro.config.BMPAllItems and togabalatro.bmpnoteui_allitems() or togabalatro.bmpnoteui_normal(),
			config = {
				align = "cm",
				offset = {x = 0, y = 0},
				bond = 'Weak',
				no_esc = true,
				no_back = true,
			}
		})
	end
end

function togabalatro.stjnotice()
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = togabalatro.stjnoteui(),
		config = {
			align = "cm",
			offset = {x = 0, y = 0},
			bond = 'Weak',
			no_esc = true,
			no_back = true,
		}
	})
end

function togabalatro.qualatronotice()
	if not togabalatro.config.qualatronotice then
		togabalatro.config.qualatronotice = true
		G.SETTINGS.paused = true
		G.FUNCS.overlay_menu({
			definition = togabalatro.qualatronote(),
			config = {
				align = "cm",
				offset = {x = 0, y = 0},
				bond = 'Weak',
				no_esc = true,
				no_back = true,
			}
		})
	end
end