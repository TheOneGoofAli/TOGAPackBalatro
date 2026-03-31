sendInfoMessage("Loading Consumeables...", "TOGAPack")

-- Initialize recipe table...
togabalatro.validsmeltrecipes = {}

-- Initialize our "OreDictionary".
togabalatro.oredict = {}

-- Vanilla...
togabalatro.oredict.steel = {'m_steel'}
togabalatro.oredict.gold = {'m_gold'}
togabalatro.oredict.stone = {'m_stone'}

-- Even these also count for OreDictionary.
togabalatro.oredict.bonus = {'m_bonus'}
togabalatro.oredict.mult = {'m_mult'}
togabalatro.oredict.wild = {'m_wild'}
togabalatro.oredict.glass = {'m_glass'}
togabalatro.oredict.lucky = {'m_lucky'}

-- Populate modded stuff...
togabalatro.oredict.notification = {'m_toga_notification'}
togabalatro.oredict.sms = {'m_toga_sms'}
togabalatro.oredict.copper = {'m_toga_copper'}
togabalatro.oredict.tin = {'m_toga_tin'}
togabalatro.oredict.iron = {'m_toga_iron'}
togabalatro.oredict.coalcoke = {'m_toga_coalcoke'}
togabalatro.oredict.silver = {'m_toga_silver'}
togabalatro.oredict.osmium = {'m_toga_osmium'}
togabalatro.oredict.electrum = {'m_toga_electrum'}
togabalatro.oredict.bronze = {'m_toga_bronze'}
togabalatro.oredict.redstone = {'m_toga_redstone'}
togabalatro.oredict.signalum = {'m_toga_signalum'}
togabalatro.oredict.nickel = {'m_toga_nickel'}
togabalatro.oredict.invar = {'m_toga_invar'}
togabalatro.oredict.glowstone = {'m_toga_glowstone'}
togabalatro.oredict.lumium = {'m_toga_lumium'}
togabalatro.oredict.chocolate = {'m_toga_chocolate'}
togabalatro.oredict.constantan = {'m_toga_constantan'}
togabalatro.oredict.lead = {'m_toga_lead'}
togabalatro.oredict.zinc = {'m_toga_zinc'}
togabalatro.oredict.brass = {'m_toga_brass'}
togabalatro.oredict.enderium = {'m_toga_enderium'}
togabalatro.oredict.platinum = {'m_toga_platinum'}
togabalatro.oredict.conductivealloy = {'m_toga_conductivealloy'}
togabalatro.oredict.energeticalloy = {'m_toga_energeticalloy'}

-- Set up a global pool of 'minerals' in our OreDictionary.
togabalatro.oredict.minerals = {'m_gold', 'm_toga_coalcoke', 'm_toga_iron', 'm_toga_copper', 'm_toga_tin', 'm_toga_silver', 'm_toga_osmium', 'm_toga_redstone', 'm_toga_nickel', 'm_toga_glowstone', 'm_toga_lead', 'm_toga_zinc', "m_toga_platinum"}
-- ...and one for alloys.
togabalatro.oredict.alloys = {'m_toga_electrum', 'm_toga_bronze', 'm_toga_signalum', 'm_toga_invar', 'm_toga_lumium', 'm_toga_refinedglowstone', 'm_toga_constantan', 'm_toga_brass', 'm_toga_enderium', 'm_toga_conductivealloy', 'm_toga_energeticalloy'}

togabalatro.is_mineral = function(card)
	if not card then return false end
	for k, v in pairs(togabalatro.oredict.minerals) do
		if v and SMODS.has_enhancement(card, v) then return true end
	end
	return false
end

togabalatro.is_alloy = function(card)
	if not card then return false end
	for k, v in pairs(togabalatro.oredict.alloys) do
		if v and SMODS.has_enhancement(card, v) then return true end
	end
	return false
end

togabalatro.has_mineral = function()
	if G.playing_cards then
		for i = 1, #G.playing_cards do
			if togabalatro.is_mineral(G.playing_cards[i]) then return true end
		end
	end
	return false
end

togabalatro.has_alloy = function()
	if G.playing_cards then
		for i = 1, #G.playing_cards do
			if togabalatro.is_alloy(G.playing_cards[i]) then return true end
		end
	end
	return false
end

togabalatro.add_to_oredict = function(key, material, quiet)
	quiet = quiet or false
	if not (key or material) then sendErrorMessage("Key or material not defined: ["..tostring(key).."] ["..tostring(material).."]", "TOGAPack - OreDictionary"); return end
	if type(key) ~= 'string' then sendErrorMessage("Key is not a string.", "TOGAPack - OreDictionary"); return end
	if type(material) ~= 'string' then sendErrorMessage("Material is not a string.", "TOGAPack - OreDictionary"); return end
	key, material = string.lower(key), string.lower(material)
	if not togabalatro.oredict[material] then
		if not quiet then sendInfoMessage("Registering new '"..material.."' type...", "TOGAPack - OreDictionary") end
		togabalatro.oredict[material] = {}
	end
	if not quiet then sendInfoMessage("Adding '"..material.."' entry: "..key, "TOGAPack - OreDictionary") end
	
	table.insert(togabalatro.oredict[material], key)
end

-- Check if card matches specific OreDictionary entries...
togabalatro.oredictcheck = function(card, pool)
	if not (card or pool) then return end
	if type(pool) == 'string' then pool = togabalatro.oredict[pool] end
	if type(pool) ~= 'table' then return end
	for i, v in ipairs(pool) do
		if type(v) == 'string' and SMODS.has_enhancement(card, v) then return true end
	end
end

-- Add recipe checks as functions. Moved to its' own file.
sendDebugMessage("Executing items/misc/alloy.lua...", "TOGAPack")
assert(SMODS.load_file("items/misc/alloy.lua"))()

-- Feel the heat of the Smeltery.
SMODS.Consumable{
	key = 'furnace',
	set = 'Tarot',
	atlas = "TOGAConsumables",
	pos = {x = 3, y = 0},
	cost = 1,
	config = { extra = { moneygain = 4 } },
	loc_vars = function(self, info_queue, card)
		local cando, txt = togabalatro.checkvalidrecipe()
		if cando and txt then
			info_queue[#info_queue + 1] = {key = txt, set = 'Other'}
		end
		return { key = card.togamodarea and self.key..'_modinfo' or card.fake_card and self.key..'_fakecard' or cando and self.key..'_ready' or G.hand and G.hand.highlighted and #G.hand.highlighted > 0 and self.key.."_novalidrecipe" or self.key, vars = { card.ability.extra.moneygain } }
	end,
	in_pool = function()
		return togabalatro.config.ShowPower and togabalatro.has_mineral() -- Should only spawn if mineral cards.
	end,
	can_use = function(self, card, area, copier)
		if togabalatro.validsmeltrecipes and #togabalatro.validsmeltrecipes < 0 then return false end
		
		if (G.hand.highlighted and #G.hand.highlighted > 0) then
			for i = 1, #togabalatro.validsmeltrecipes do
				if togabalatro.validsmeltrecipes[i](G.hand.highlighted) then return true end
			end
		end
		return false
	end,
	use = function(self, card, area)
		if togabalatro.validsmeltrecipes and #togabalatro.validsmeltrecipes < 0 then return end
		local cando, cardtable, enhancement, found = false, {}, "", false
		for i = 1, #togabalatro.validsmeltrecipes do
			if found then break end
			
			cando, cardtable, enhancement = togabalatro.validsmeltrecipes[i](G.hand.highlighted)
			if cando and cardtable and enhancement and G.P_CENTERS[enhancement] then found = true end
		end
		if not (cando or found) then return end
		
		if cardtable.cards and #cardtable.cards > 0 then
			for i, v in ipairs(cardtable.cards) do
				if v and G.P_CENTERS[enhancement] then
					v:set_ability(G.P_CENTERS[enhancement])
					card_eval_status_text(v, 'extra', nil, nil, nil, {message = localize('toga_furnaceprocess'), sound = togabalatro.config.SFXWhenTriggered and 'toga_xporb'})
				end
			end
		end
		
		if cardtable.destroycard and #cardtable.destroycard > 0 then
			local destroyed_cards = {}
			for i, v in ipairs(cardtable.destroycard) do
				destroyed_cards[#destroyed_cards+1] = v
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end}))
			
			SMODS.destroy_cards(destroyed_cards)
		end
		G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.2, func = function()
			G.hand:unhighlight_all()
			G.hand:parse_highlighted()
			SMODS.calculate_effect({ dollars = card.ability.extra.moneygain }, card)
			return true
		end,}))
	end,
	keep_on_use = function(self, card)
		return true
	end,
	set_card_type_badge = function(self, card, badges)
		if not (card and card.togamodarea) then badges[#badges+1] = create_badge(localize('toga_crafttarot'), G.C.SECONDARY_SET.Tarot, G.C.WHITE, 1.2) end
	end,
	shiftinfoclick = "toga_alloyrecipes",
	pixel_size = { w = 71, h = 77 },
	perishable_compat = false,
	eternal_compat = false,
	can_stack = false,
	select_card = 'consumeables',
	poweritem = true,
	toga_donotreuse = true
}

-- Find the metal pages... wait what?
SMODS.Consumable {
	key = 'miningprospect',
	set = 'Tarot',
	atlas = "TOGAConsumables",
	pos = {x = 4, y = 0},
	cost = 5,
	config = { extra = { odds = 3 } },
	loc_vars = function(self, info_queue, card)
		return { key = card.togamodarea and self.key..'_modinfo' or self.key, vars = { SMODS.get_probability_vars(card or self, 1, (card.ability.extra or self.config.extra).odds) }}
	end,
	in_pool = function()
		if G.playing_cards then
			for i = 1, #G.playing_cards do
				if SMODS.has_enhancement(G.playing_cards[i], "m_stone") then return true end -- Appear if there's a Stone card.
			end
		end
		return false
	end,
	can_use = function(self, card, area, copier)
		if G.playing_cards then
			for i = 1, #G.playing_cards do
				if SMODS.has_enhancement(G.playing_cards[i], "m_stone") then return true end
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		local cards = {}
		for i = 1, #G.playing_cards do
			cards[#cards+1] = G.playing_cards[i]
		end
		for k, v in ipairs(cards) do
			if SMODS.has_enhancement(v, 'm_stone') then
				if SMODS.pseudorandom_probability(card, "toga_minediamonds", 1, card.ability.extra.odds, 'miningprospect') then
					local enhancement = SMODS.poll_enhancement({ guaranteed = true, options = togabalatro.oredict.minerals, type_key = 'modmineral' })
					G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
						card:juice_up()
						v:set_ability(G.P_CENTERS[enhancement])
					return true end }))
					card_eval_status_text(v, 'extra', nil, nil, nil, {message = localize('toga_stonefound'), sound = togabalatro.config.SFXWhenTriggered and 'toga_xporb'})
				else
					card_eval_status_text(v, 'extra', nil, nil, nil, {message = localize('toga_stonenothing')})
					card:juice_up()
					SMODS.destroy_cards(v)
				end
			end
		end
	end,
	set_card_type_badge = function(self, card, badges)
		if not (card and card.togamodarea) then badges[#badges+1] = create_badge(localize('toga_minetarot'), G.C.SECONDARY_SET.Tarot, G.C.WHITE, 1.2) end
	end,
	pixel_size = { w = 71, h = 77 },
	shiftinfoclick = "toga_showminerals",
	perishable_compat = false,
	eternal_compat = false,
	can_stack = false,
	toga_donotreuse = true,
	no_bulkuse = true,
	can_mass_use = false,
}

SMODS.Consumable {
	key = 'inbox',
	set = 'Tarot',
	atlas = "TOGAConsumables",
	pos = {x = 8, y = 0},
	cost = 5,
	config = { extra = { max_cards = 2 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['m_toga_sms']
		return { vars = { (card.ability or self.config).extra.max_cards } }
	end,
	in_pool = function()
		if not togabalatro.config.ShowPower then return false end
		if G.playing_cards then
			for i = 1, #G.playing_cards do
				if SMODS.has_enhancement(G.playing_cards[i], "m_toga_sms") then return true end -- Appear if there's a SMS card.
			end
		end
		return false
	end,
	can_use = function(self, card, area, copier)
		if G.playing_cards then
			for i = 1, #G.playing_cards do
				if SMODS.has_enhancement(G.playing_cards[i], "m_toga_sms") then return true end -- Can be used if an SMS card is present.
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		local cards = {}
		for i = 1, #G.playing_cards do
			if SMODS.has_enhancement(G.playing_cards[i], "m_toga_sms") then cards[#cards+1] = G.playing_cards[i] end
		end
		pseudoshuffle(cards, pseudoseed('yougotmail'))
		local dcards = {}
		for i = 1, card.ability.extra.max_cards or 2 do
			if cards[i] then dcards[#dcards+1] = cards[i] end
		end
		if next(dcards) then SMODS.destroy_cards(dcards) end
	end,
	pixel_size = { w = 71, h = 77 },
	perishable_compat = false,
	eternal_compat = false,
	poweritem = true,
	toga_donotreuse = true,
	no_bulkuse = true,
	can_mass_use = false,
}

-- SPB function.
local function toga_spbdeckwreck(card, failedchance)
	if not (G.deck and G.deck.cards and #G.deck.cards > 0) then return end
	if failedchance then card_eval_status_text(G.deck.cards[1], 'extra', nil, nil, nil, {message = localize('toga_spbavoidfail'), colour = G.C.RED}) end
	local temp_hand, destroyed_cards = {}, {}
	for k, v in ipairs(G.deck.cards) do temp_hand[#temp_hand+1] = v end
	table.sort(temp_hand, function (a, b) return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card end)
	pseudoshuffle(temp_hand, pseudoseed('spb'))
	
	for i = 1, math.floor(card.ability.extra.cardlimit) do destroyed_cards[#destroyed_cards+1] = temp_hand[i] end
	
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
		play_sound('tarot1')
		card:juice_up(0.3, 0.5)
		SMODS.destroy_cards(destroyed_cards, nil, true)
	return true end }))
end

local spbdeckpart, spbcardmin = 0.75, 20

SMODS.Consumable{
	key = 'selfpropelledbomb',
	set = 'Spectral',
	atlas = "TOGAConsumables",
	pos = {x = 0, y = 0},
	cost = 4,
	config = {extra = { cardlimit = spbcardmin, odds = 4, activated = false } },
	loc_vars = function(self, info_queue, card)
		card.ability.extra.cardlimit = math.max(G.deck and G.deck.cards and math.floor(#G.deck.cards*spbdeckpart) or 0, spbcardmin)
		local basechance, odds = SMODS.get_probability_vars(card or self, 1, (card.ability or self.config).extra.odds)
		return {vars = { math.floor(card.ability.extra.cardlimit), odds, basechance, spbcardmin, spbdeckpart*100 } }
	end,
	can_use = function(self, card, area, copier)
		return G.deck and G.deck.cards and #G.deck.cards > 0
	end,
	use = function(self, card)
		card.ability.extra.cardlimit = math.max(G.deck and G.deck.cards and math.floor(#G.deck.cards*spbdeckpart) or 0, spbcardmin)
		card.ability.extra.activated = true
		toga_spbdeckwreck(card)
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenAdding and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound('toga_spb')
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if card.ability.extra.activated then return end
		if SMODS.pseudorandom_probability(card, "toga_selfpropelledbomb", 1, card.ability.extra.odds, 'theselfpropelledbomb') then
			toga_spbdeckwreck(card, true)
		else
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_safe_ex'), sound = togabalatro.config.SFXWhenRemoving and 'toga_thundershield'})
		end
	end,
	perishable_compat = false,
	eternal_compat = false,
	can_stack = false,
	toga_donotreuse = true,
	no_bulkuse = true,
	can_mass_use = false,
	can_bulk_use = false
}

SMODS.Consumable {
	key = 'sealingaround',
	set = 'Spectral',
	atlas = "TOGAConsumables",
	pos = {x = 1, y = 0},
	cost = 5,
	config = { max_highlighted = 1, extra = 'toga_sealseal' },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_SEALS[(card.ability or self.config).extra]
		return {vars = {(card.ability or self.config).max_highlighted}}
	end,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	can_use = function(self, card)
		if G.hand and #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.max_highlighted then 
			return true
		end
		return false
	end,
	use = function(self, card, area, copier)
		for i = 1, math.min(#G.hand.highlighted, card.ability.max_highlighted) do
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
				return true end }))
			
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				G.hand.highlighted[i]:set_seal(card.ability.extra, nil, true)
				return true end }))
			
			delay(0.5)
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
	end,
	poweritem = true,
	no_bulkuse = true,
	can_bulk_use = false,
	can_mass_use = false,
}

SMODS.Consumable {
	key = 'filesource',
	set = 'Spectral',
	atlas = "TOGAConsumables",
	pos = {x = 2, y = 0},
	cost = 5,
	config = { extra = { cards = 2 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_toga_notification
		return { vars = { card.ability.extra.cards } }
	end,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	can_use = function(self, card)
		if G.hand and #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then 
			return true
		end
		return false
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
		return true end }))
		delay(0.2)
		for i, v in pairs(G.hand.highlighted) do
			local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() v:flip();play_sound('card1', percent, 1);v:juice_up(0.3, 0.3);return true end }))
			G.E_MANAGER:add_event(Event({trigger = 'after',func = function() v:set_ability(G.P_CENTERS["m_toga_notification"]);return true end }))
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() v:flip();play_sound('tarot2', percent, 0.6);play_sound('toga_winxpballoon', 1, 2.5);v:juice_up(0.3, 0.3);return true end }))
		end
		delay(0.2)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
	end,
	poweritem = true,
	no_bulkuse = true,
	can_bulk_use = false,
	can_mass_use = false,
}

SMODS.Consumable {
	key = 'mobilephone',
	set = 'Spectral',
	atlas = "TOGAConsumables",
	pos = {x = 5, y = 0},
	cost = 5,
	config = { extra = { cards = 2 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_toga_sms
		return { vars = { card.ability.extra.cards } }
	end,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	can_use = function(self, card)
		if G and G.hand and #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then 
			return true
		end
		return false
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
		return true end }))
		delay(0.2)
		for i, v in pairs(G.hand.highlighted) do
			local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() v:flip();play_sound('card1', percent, 1);v:juice_up(0.3, 0.3);return true end }))
			G.E_MANAGER:add_event(Event({trigger = 'after',func = function() v:set_ability(G.P_CENTERS["m_toga_sms"]);return true end }))
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() v:flip();play_sound('tarot2', percent, 0.6);v:juice_up(0.3, 0.3);return true end }))
		end
		delay(0.2)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
	end,
	poweritem = true,
	no_bulkuse = true,
	can_bulk_use = false,
	can_mass_use = false,
}

SMODS.Consumable {
	key = 'hyperlink',
	set = 'Spectral',
	atlas = "TOGAConsumables",
	pos = {x = 6, y = 0},
	cost = 5,
	config = { max_highlighted = 1, extra = 'toga_urlseal' },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_SEALS[(card.ability or self.config).extra]
		return {vars = {(card.ability or self.config).max_highlighted}}
	end,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	can_use = function(self, card)
		if G and G.hand and #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.max_highlighted then 
			return true
		end
		return false
	end,
	use = function(self, card, area, copier)
		for i = 1, math.min(#G.hand.highlighted, card.ability.max_highlighted) do
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
				return true end }))
			
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				G.hand.highlighted[i]:set_seal(card.ability.extra, nil, true)
				return true end }))
			
			delay(0.5)
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
	end,
	poweritem = true,
	no_bulkuse = true,
	can_bulk_use = false,
	can_mass_use = false,
}

SMODS.Consumable {
	key = 'alloyer',
	set = 'Spectral',
	atlas = "TOGAConsumables",
	pos = {x = 7, y = 0},
	cost = 5,
	config = { extra = { max_highlighted = 1, odds = 4 } },
	loc_vars = function(self, info_queue, card)
		return { key = card.togamodarea and self.key..'_modinfo' or card.fake_card and self.key.."_desconly" or self.key, vars = { (card.ability.extra or self.config.extra).max_highlighted, SMODS.get_probability_vars(card or self, 1, (card.ability.extra or self.config.extra).odds) } }
	end,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	can_use = function(self, card)
		if G.hand and #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted then
			return true
		end
		return false
	end,
	use = function(self, card, area, copier)
		if card.ability.extra.deckperk or SMODS.pseudorandom_probability(card, "toga_alloyingmyingots", 1, card.ability.extra.odds, 'alloyer') then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end }))
			delay(0.2)
			for i, v in pairs(G.hand.highlighted) do
				local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
				local alloyenh = SMODS.poll_enhancement({ key = 'thealloying', guaranteed = true, options = togabalatro.oredict.alloys })
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() v:flip();play_sound('card1', percent, 1);v:juice_up(0.3, 0.3);return true end }))
				G.E_MANAGER:add_event(Event({trigger = 'after',func = function() v:set_ability(alloyenh);return true end }))
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() v:flip();play_sound('tarot2', percent, 0.6);v:juice_up(0.3, 0.3);return true end }))
			end
			delay(0.2)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
		else
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				attention_text({
					text = localize('k_nope_ex'),
					scale = 1.3, 
					hold = 1.4,
					major = card,
					backdrop_colour = G.C.SECONDARY_SET.Tarot,
					align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and 'tm' or 'cm',
					offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0},
					silent = true
					})
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
						play_sound('tarot2', 0.76, 0.4);return true end}))
					play_sound('tarot2', 1, 0.4)
					card:juice_up(0.3, 0.5)
			return true end }))
			delay(0.2)
		end
	end,
	set_card_type_badge = function(self, card, badges)
		if not (card and card.togamodarea) then badges[#badges+1] = create_badge(localize('toga_alloyspectral'), G.C.SECONDARY_SET.Spectral, G.C.WHITE, 1.2) end
	end,
	pixel_size = { w = 71, h = 77 },
	shiftinfoclick = "toga_showalloys",
	poweritem = true,
	can_stack = false,
	no_bulkuse = true,
	can_bulk_use = false,
	can_mass_use = false,
}

SMODS.Consumable {
	key = 'glteapot',
	set = 'togaitem',
	atlas = "TOGAJokersBeOS",
	pos = {x = 1, y = 0},
	cost = 1,
	config = { extra = { gsv = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.gsv } }
	end,
	in_pool = function()
		return false
	end,
	can_use = function()
		return false
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra_value = card.ability.extra_value + card.ability.extra.gsv
			card:set_cost()
			return {
				message = localize('k_val_up'),
				colour = G.C.MONEY
			}
		end
	end,
	no_collection = true,
	pixel_size = { w = 56, h = 95 },
	can_stack = false,
	no_bulkuse = true,
	can_bulk_use = false,
	can_mass_use = false,
}