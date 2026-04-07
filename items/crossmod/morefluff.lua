-- Cross-mod stuff for Mineral card pool. Iron, gold and diamonds are valid examples,
-- but bronze and steel are not intended for this pool for being alloys.
sendInfoMessage("Added Gemstone cards of More Fluff to mineral pool.", "TOGAPack - MoreFluff")
togabalatro.add_to_oredict('m_mf_gemstone', 'minerals', true)
togabalatro.add_to_oredict('m_mf_gemstone', 'gemstone', true)
sendInfoMessage("Added Brass cards of More Fluff to mineral pool.", "TOGAPack - MoreFluff")
togabalatro.add_to_oredict('m_mf_brass', 'minerals', true)
togabalatro.add_to_oredict('m_mf_brass', 'brass', true)

togabalatro.mf_art_credit = function(name)
	if mf_config["Programmer Art"] then return nil end
	if mf_config["Disable Art Credits"] then return nil end
	return "{s:0.8,C:inactive}Art by: "..name
end

togabalatro.mf_colours_held = function()
	if G.consumeables and G.consumeables.cards then
		for i = 1, #G.consumeables.cards do
			if G.consumeables.cards[i].config.center.set == 'Colour' then return true end
		end
	end
	return false
end

togabalatro.mf_displayproperties = function()
	local display = {}
	SMODS.calculate_context({ coloureof = true }, display)
	for _, eval in pairs(display) do
		for key, eval2 in pairs(eval) do
			if eval2.rescore and eval2.card then
				card_eval_status_text(eval2.card, 'extra', nil, nil, nil, {message = localize('toga_colourful'), sound = togabalatro.config.SFXWhenTriggered and 'toga_winxpinfobar'})
				colour_end_of_round_effects()
			end
		end
	end
end

local atlastype = ".png"
if mf_config["Programmer Art"] then atlastype = "progart.png" end

if SMODS.Mods['MoreFluff'].config['Colour Cards'] then
	SMODS.Atlas{key = "TOGAJokersColours", path = "togacolours"..atlastype, px = 71, py = 95}
	SMODS.Joker{
		key = 'penwheel',
		config = { extra = { percolormoney = 2 } },
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.extra.percolormoney } }
		end,
		unlocked = true,
		discovered = true,
		rarity = 1,
		atlas = 'TOGAJokersMain',
		pos = { x = 1, y = 4 },
		cost = 4,
		pools = { ["TOGAJKR"] = true },
		blueprint_compat = true,
		demicolon_compat = true,
		calculate = function(self, card, context)
			if (context.end_of_round or context.forcetrigger) and not context.repetition and not context.individual and not context.game_over then
				return { func = function()
					for i = 1, #G.consumeables.cards do
						if G.consumeables.cards[i].config.center.set == 'Colour' then
							local effects = { dollars = card.ability.extra.percolormoney, message_card = G.consumeables.cards[i]}
							local stacked, stackamount = togabalatro.stackingcompat(G.consumeables.cards[i])
							if stacked then
								for i = 1, stackamount do
									SMODS.calculate_individual_effect(effects, G.consumeables.cards[i], 'dollars', effects.dollars, false)
								end
							else SMODS.calculate_individual_effect(effects, G.consumeables.cards[i], 'dollars', effects.dollars, false) end
						end
					end
				end }
			end
		end,
		set_badges = function(self, card, badges)
			if self.discovered then SMODS.create_mod_badges({ mod = SMODS.find_mod('MoreFluff')[1] }, badges) end
		end,
		attributes = { 'economy', 'colour', 'consumeable' }
	}
	SMODS.Joker{
		key = 'displayproperties',
		unlocked = true,
		discovered = true,
		rarity = 2,
		atlas = 'TOGAJokersMain',
		pos = { x = 2, y = 4 },
		cost = 7,
		pools = { ["TOGAJKR"] = true },
		blueprint_compat = true,
		calculate = function(self, card, context)
			if context.coloureof then return { rescore = true, card = context.blueprint_card or card } end
		end,
		set_badges = function(self, card, badges)
			if self.discovered then SMODS.create_mod_badges({ mod = SMODS.find_mod('MoreFluff')[1] }, badges) end
		end,
		attributes = { 'colour', 'consumeable' }
	}
	SMODS.Joker{
		key = 'colourfulprinter',
		unlocked = true,
		discovered = true,
		blueprint_compat = false,
		eternal_compat = true,
		perishable_compat = false,
		demicolon_compat = true,
		rarity = "crv_p",
		atlas = 'TOGAJokersMain',
		pos = { x = 3, y = 4 },
		cost = 10,
		pools = { ["TOGAJKR"] = true },
		calculate = function(self, card, context)
			if context.setting_blind or context.forcetrigger then
				return {
					func = function()
						local createnegative = false
						if G.GAME.used_vouchers["v_crv_printerup"] == true then createnegative = true end
						if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit or createnegative then
							G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
							G.E_MANAGER:add_event(Event({
								func = function()
									local colourcard = SMODS.create_card({ set = 'Colour', no_edition = createnegative and true or false }) -- egg.
									if createnegative then colourcard:set_edition('e_negative', true, true) end
									colourcard:add_to_deck()
									G.consumeables:emplace(colourcard)
									G.GAME.joker_buffer = math.max(G.GAME.joker_buffer - 1, 0)
									return true
								end
							}))
						end
					end
				}
			end
		end,
		set_badges = function(self, card, badges)
			if self.discovered then
				SMODS.create_mod_badges({ mod = SMODS.find_mod('MoreFluff')[1] }, badges)
				SMODS.create_mod_badges({ mod = SMODS.find_mod('RevosVault')[1] }, badges)
			end
		end,
		dependencies = 'RevosVault',
		attributes = { 'colour', 'consumeable', 'printer' }
	}
	SMODS.Consumable({
		object_type = "Consumable",
		set = "Colour",
		name = "col_TOGAClassic",
		key = "classic",
		pos = { x = 0, y = 0 },
		config = {
			val = 0,
			partial_rounds = 0,
			upgrade_rounds = 2,
		},
		cost = 4,
		atlas = "TOGAJokersColours",
		unlocked = true,
		discovered = true,
		display_size = { w = 71, h = 87 },
		pixel_size = { w = 71, h = 87 },
		can_use = function(self, card)
			return true
		end,
		use = function(self, card, area, copier)
			local tag_type = "tag_toga_togajokerziparchive"
			for i = 1, card.ability.val do
				G.E_MANAGER:add_event(Event({
					func = (function()
						add_tag(Tag(tag_type))
						play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
						play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
						return true
						end)
					}))
				delay(0.2)
			end
			delay(0.6)
		end,
		loc_vars = function(self, info_queue, card)
			local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
			info_queue[#info_queue + 1] = G.P_TAGS.tag_toga_togajokerziparchive
			return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
		end,
		set_badges = function(self, card, badges)
			if self.discovered then SMODS.create_mod_badges({ mod = SMODS.find_mod('MoreFluff')[1] }, badges) end
		end
	})
	SMODS.Consumable({
		object_type = "Consumable",
		set = "Colour",
		name = "col_TOGAProfessional",
		key = "professional",
		pos = { x = 1, y = 0 },
		config = {
			val = 0,
			partial_rounds = 0,
			upgrade_rounds = 3,
		},
		cost = 4,
		atlas = "TOGAJokersColours",
		unlocked = true,
		discovered = true,
		display_size = { w = 71, h = 87 },
		pixel_size = { w = 71, h = 87 },
		can_use = function(self, card)
			return true
		end,
		use = function(self, card, area, copier)
			local tag_type = "tag_toga_togarararchive"
			for i = 1, card.ability.val do
				G.E_MANAGER:add_event(Event({
					func = (function()
						add_tag(Tag(tag_type))
						play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
						play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
						return true
						end)
					}))
				delay(0.2)
			end
			delay(0.6)
		end,
		loc_vars = function(self, info_queue, card)
			local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
			info_queue[#info_queue + 1] = G.P_TAGS.tag_toga_togarararchive
			return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
		end,
		set_badges = function(self, card, badges)
			if self.discovered then SMODS.create_mod_badges({ mod = SMODS.find_mod('MoreFluff')[1] }, badges) end
		end
	})
	SMODS.Consumable({
		object_type = "Consumable",
		set = "Colour",
		name = "col_TOGALuna",
		key = "luna",
		pos = { x = 2, y = 0 },
		config = {
			val = 0,
			partial_rounds = 0,
			upgrade_rounds = 2,
		},
		cost = 4,
		atlas = "TOGAJokersColours",
		unlocked = true,
		discovered = true,
		display_size = { w = 71, h = 87 },
		pixel_size = { w = 71, h = 87 },
		can_use = function(self, card)
			return true
		end,
		use = function(self, card, area, copier)
			local tag_type = "tag_toga_togacardcabarchive"
			for i = 1, card.ability.val do
				G.E_MANAGER:add_event(Event({
					func = (function()
						add_tag(Tag(tag_type))
						play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
						play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
						return true
						end)
					}))
				delay(0.2)
			end
			delay(0.6)
		end,
		loc_vars = function(self, info_queue, card)
			local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
			info_queue[#info_queue + 1] = G.P_TAGS.tag_toga_togacardcabarchive
			return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
		end,
		set_badges = function(self, card, badges)
			if self.discovered then SMODS.create_mod_badges({ mod = SMODS.find_mod('MoreFluff')[1] }, badges) end
		end
	})
	SMODS.Consumable({
		object_type = "Consumable",
		set = "Colour",
		name = "col_TOGAAero",
		key = "aero",
		pos = { x = 3, y = 0 },
		config = {
			val = 0,
			partial_rounds = 0,
			upgrade_rounds = 2,
		},
		cost = 4,
		atlas = "TOGAJokersColours",
		unlocked = true,
		discovered = true,
		display_size = { w = 71, h = 87 },
		pixel_size = { w = 71, h = 87 },
		can_use = function(self, card)
			return true
		end,
		use = function(self, card, area, copier)
			local tag_type = "tag_toga_togaxcopydnaarchive"
			for i = 1, card.ability.val do
				G.E_MANAGER:add_event(Event({
					func = (function()
						add_tag(Tag(tag_type))
						play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
						play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
						return true
						end)
					}))
				delay(0.2)
			end
			delay(0.6)
		end,
		loc_vars = function(self, info_queue, card)
			local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
			info_queue[#info_queue + 1] = G.P_TAGS.tag_toga_togaxcopydnaarchive
			return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
		end,
		set_badges = function(self, card, badges)
			if self.discovered then SMODS.create_mod_badges({ mod = SMODS.find_mod('MoreFluff')[1] }, badges) end
		end
	})
end