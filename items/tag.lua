sendInfoMessage("Loading Tags...", "TOGAPack")

SMODS.Tag{
	key = "togajokershop",
	atlas = "TOGATags",
	pos = { x = 0, y = 0 },
	config = { type = "store_joker_create" },
	in_pool = function(self, args)
		return true
	end,
	apply = function(self, tag, context)
		if context.type == "store_joker_create" then
			local card = create_card("TOGAJKR", context.area, nil, nil, nil, nil, nil, "togajokertag")
			create_shop_card_ui(card, "Joker", context.area)
			card.states.visible = false
			tag:yep("+", G.C.RED, function()
				card:start_materialize()
				card.ability.couponed = true
				card:set_cost()
				return true
			end)
			tag.triggered = true
			return card
		end
	end,
	attributes = { 'generation', 'joker' }
}

SMODS.Tag{
	key = "togajokerbooster",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.p_toga_togazipboosterpack
	end,
	atlas = "TOGATags",
	pos = { x = 1, y = 0 },
	config = { type = "new_blind_choice" },
	in_pool = function(self, args)
		return true
	end,
	apply = function(self, tag, context)
		local lock = tag.ID
		if context.type == "new_blind_choice" then
			G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.ORANGE,function() 
				local key = 'p_toga_togazipboosterpack'
				local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
				G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
				card.cost = 0
				card.from_tag = true
				G.FUNCS.use_card({config = {ref_table = card}})
				card:start_materialize()
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
	attributes = { 'booster' }
}

SMODS.Tag{
	key = "togajokerziparchive",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.p_toga_togaziparchivepack
	end,
	atlas = "TOGATags",
	pos = { x = 6, y = 0 },
	config = { type = "new_blind_choice" },
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	poweritem = true,
	apply = function(self, tag, context)
		local lock = tag.ID
		if context.type == "new_blind_choice" then
			G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.ORANGE,function() 
				local key = 'p_toga_togaziparchivepack'
				local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
				G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
				card.cost = 0
				card.from_tag = true
				G.FUNCS.use_card({config = {ref_table = card}})
				card:start_materialize()
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
	attributes = { 'booster' }
}

SMODS.Tag{
	key = "thespbroll",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_toga_selfpropelledbomb
	end,
	atlas = "TOGATags",
	pos = { x = 2, y = 0 },
	config = { type = "immediate" },
	in_pool = function(self, args)
		return true
	end,
	apply = function(self, tag, context)
		local lock = tag.ID
		if context.type == "immediate" then
			G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.ORANGE,function() 
				SMODS.add_card({ key = "c_toga_selfpropelledbomb", key_append = "thespbrun" })
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
	attributes = { 'generation', 'consumable' }
}

SMODS.Tag{
	key = "guaranteedice",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_oops
	end,
	atlas = "TOGATags",
	pos = { x = 3, y = 0 },
	config = { type = "store_joker_create" },
	in_pool = function(self, args)
		if not togabalatro.config.ShowPower then return false end
		if #SMODS.find_card('j_oops', true) > 0 then return false
		else return true end
	end,
	min_ante = 3,
	apply = function(self, tag, context)
		if context.type == "store_joker_create" then
			local card = create_card("Joker", context.area, nil, nil, nil, nil, "j_oops")
			create_shop_card_ui(card, "Joker", context.area)
			card.states.visible = false
			tag:yep("+", G.C.RED, function()
				card:start_materialize()
				card:set_cost()
				return true
			end)
			tag.triggered = true
			return card
		end
	end,
	poweritem = true,
	attributes = { 'generation', 'joker' }
}

SMODS.Tag{
	key = "thenet",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_black_hole
		return { key = next(SMODS.find_mod('Cryptid')) and self.key.."_cryptid" or self.key, vars = { SMODS.get_probability_vars(card or self, 1, card.ability.odds or self.config.odds) } }
	end,
	atlas = "TOGATags",
	pos = { x = 4, y = 0 },
	config = { type = "immediate", odds = 15 },
	in_pool = function(self, args)
		return true
	end,
	apply = function(self, tag, context)
		local lock = tag.ID
		if context.type == "immediate" then
			G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.ORANGE,function() 
				local card = create_card('Spectral', G.consumables, nil, nil, nil, nil, next(SMODS.find_mod('Cryptid')) and SMODS.pseudorandom_probability(self, 'toga_colorinverthole', 1, tag.ability.odds or self.config.odds, 'thenet') and "c_cry_white_hole" or "c_black_hole", "internetexplorer")
				card:add_to_deck()
				G.consumeables:emplace(card)
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
	attributes = { 'generation', 'consumable' }
}

SMODS.Tag{
	key = "controlexe",
	atlas = "TOGATags",
	pos = { x = 5, y = 0 },
	config = { type = "immediate" },
	in_pool = function(self, args)
		return G.jokers and next(G.jokers.cards)
	end,
	apply = function(self, tag, context)
		local lock = tag.ID
		if context.type == "immediate" then
			if next(G.jokers.cards) then
				local jks, noed, seljoker = {}, {}, nil
				for k, v in pairs(G.jokers.cards) do
					if not v.edition then table.insert(noed, v) end
					table.insert(jks, v)
				end
				if next(noed) then
					seljoker = pseudorandom_element(noed, pseudoseed('controlpanel'))
				else
					seljoker = pseudorandom_element(jks, pseudoseed('controlpanel'))
				end
				if seljoker then
					local seledition = SMODS.poll_edition({ key = '98se', no_negative = false, guaranteed = true })
					if seledition then
						G.CONTROLLER.locks[lock] = true
						tag:yep('+', G.C.ORANGE,function() 
							seljoker:set_edition(seledition, true)
							G.CONTROLLER.locks[lock] = nil
							return true
						end)
					else
						tag:nope()
					end
				else
					tag:nope()
				end
			else
				tag:nope()
			end
			tag.triggered = true
			return true
		end
	end,
	attributes = { 'joker', 'editions' }
}

SMODS.Tag{
	key = "thelegend",
	atlas = "TOGATags",
	pos = { x = 7, y = 0 },
	config = { type = "store_joker_create" },
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	min_ante = 2,
	apply = function(self, tag, context)
		if context.type == "store_joker_create" then
			local card = create_card("Joker", context.area, true)
			create_shop_card_ui(card, "Joker", context.area)
			card.states.visible = false
			tag:yep("+", G.C.ORANGE, function()
				card:start_materialize()
				card:set_cost()
				return true
			end)
			tag.triggered = true
			return card
		end
	end,
	poweritem = true,
	attributes = { 'generation', 'joker', 'rarity' }
}

SMODS.Tag{
	key = "togarararchive",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.p_toga_togararpack
	end,
	atlas = "TOGATags",
	pos = { x = 8, y = 0 },
	config = { type = "new_blind_choice" },
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	poweritem = true,
	apply = function(self, tag, context)
		local lock = tag.ID
		if context.type == "new_blind_choice" then
			G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.ORANGE,function() 
				local key = 'p_toga_togararpack'
				local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
				G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
				card.cost = 0
				card.from_tag = true
				G.FUNCS.use_card({config = {ref_table = card}})
				card:start_materialize()
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
	attributes = { 'booster' }
}

SMODS.Tag{
	key = "togacardcabarchive",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.p_toga_togacardcabpack
	end,
	atlas = "TOGATags",
	pos = { x = 9, y = 0 },
	config = { type = "new_blind_choice" },
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	poweritem = true,
	apply = function(self, tag, context)
		local lock = tag.ID
		if context.type == "new_blind_choice" then
			G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.ORANGE,function() 
				local key = 'p_toga_togacardcabpack'
				local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
				G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
				card.cost = 0
				card.from_tag = true
				G.FUNCS.use_card({config = {ref_table = card}})
				card:start_materialize()
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
	attributes = { 'booster' }
}

SMODS.Tag{
	key = "togaxcopydnaarchive",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.p_toga_togaxcopydnapack
	end,
	atlas = "TOGATags",
	pos = { x = 10, y = 0 },
	config = { type = "new_blind_choice" },
	in_pool = function(self, args)
		return true
	end,
	apply = function(self, tag, context)
		local lock = tag.ID
		if context.type == "new_blind_choice" then
			G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.ORANGE,function() 
				local key = 'p_toga_togaxcopydnapack'
				local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
				G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
				card.cost = 0
				card.from_tag = true
				G.FUNCS.use_card({config = {ref_table = card}})
				card:start_materialize()
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
	attributes = { 'booster' }
}