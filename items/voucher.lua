sendInfoMessage("Loading Vouchers...", "TOGAPack")

SMODS.Voucher{
	key = 'fat32',
	pos = { x = 0, y = 1 },
	atlas = 'TOGAConsumables',
	unlocked = true,
	cost = 16,
	rarity = 4,
	config = { rarity = 4, extra = { h_size_scale = 0.5 } },
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.h_size_scale*100}}
	end,
	requires = {'v_paint_brush'},
	redeem = function(self)
		if togabalatro.config.DoMoreLogging then sendInfoMessage("Increased hand size by "..math.ceil(G.hand.config.card_limit*self.config.extra.h_size_scale)..".", "TOGAPack") end
		G.hand:change_size(math.ceil(G.hand.config.card_limit*self.config.extra.h_size_scale))
	end,
}

SMODS.Voucher{
	key = 'diskdefrag',
	pos = { x = 1, y = 1 },
	atlas = 'TOGAConsumables',
	unlocked = true,
	cost = 10,
	rarity = 3,
	config = { rarity = 3, extra = { discards = 1 } },
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.discards}}
	end,
	calculate = function(self, card, context)
		if context.after then
			ease_discard(card.ability.extra.discards)
		end
	end,
	redeem = function(self)
		G.GAME.round_resets.discards = G.GAME.round_resets.discards - self.config.extra.discards
		ease_discard(-self.config.extra.discards)
	end,
}

SMODS.Voucher{
	key = 'hardwarewizard',
	pos = { x = 2, y = 1 },
	atlas = 'TOGAConsumables',
	unlocked = true,
	cost = 15,
	rarity = 3,
	config = { rarity = 3, extra = { probabilitymult = 2 } },
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.probabilitymult}}
	end,
	redeem = function(self)
		for k, v in pairs(G.GAME.probabilities) do 
			G.GAME.probabilities[k] = v*self.config.extra.probabilitymult
		end
	end,
}

SMODS.Voucher{
	key = 'hardwarewizardxp',
	pos = { x = 2, y = 2 },
	atlas = 'TOGAConsumables',
	unlocked = true,
	cost = 15,
	rarity = 4,
	config = { rarity = 4, extra = { probabilitymult = 2 } },
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.probabilitymult}}
	end,
	requires = {'v_toga_hardwarewizard'},
	redeem = function(self)
		for k, v in pairs(G.GAME.probabilities) do 
			G.GAME.probabilities[k] = v*self.config.extra.probabilitymult
		end
	end,
}

SMODS.Voucher{
	key = 'wormsninjarope',
	pos = { x = 0, y = 2 },
	atlas = 'TOGAConsumables',
	unlocked = true,
	cost = 10,
	rarity = 3,
	config = { rarity = 3, extra = { moreselect = 1 } },
	loc_vars = function(self, info_queue, card)
		return {vars = {math.max(1, math.floor(card.ability.extra.moreselect))}}
	end,
	redeem = function(self)
		if togabalatro.config.DoMoreLogging then sendInfoMessage("Increased card selection limit by "..math.max(1, math.floor(self.config.extra.moreselect))..".", "TOGAPack") end
		G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + math.max(1, math.floor(self.config.extra.moreselect))
	end,
}

SMODS.Voucher{
	key = 'wormsscalesofjustice',
	pos = { x = 1, y = 2 },
	atlas = 'TOGAConsumables',
	unlocked = true,
	cost = 15,
	rarity = 3,
	config = { rarity = 3 },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {key = "toga_scales1", set = 'Other'}
		info_queue[#info_queue + 1] = {key = "toga_scales2", set = 'Other'}
		info_queue[#info_queue + 1] = {key = "toga_scales3", set = 'Other'}
	end,
	requires = {'v_toga_ninjarope'},
	redeem = function(self)
		-- do the sound!
		play_sound('toga_scalesofjustice')
		-- Joker slots, Consumable slots, hand size, card selection limit.
		local cardlimitavrg = math.floor(((G.jokers and G.jokers.config.card_limit or 5) + (G.hand and G.hand.config.card_limit or 8) + (G.hand and G.hand.config.highlighted_limit or 5) + (G.consumeables and G.consumeables.config.card_limit or 2))/4)
		if togabalatro.config.DoMoreLogging then sendInfoMessage("Resulted average is "..cardlimitavrg..".", "TOGAPack") end
		G.jokers.config.card_limit = cardlimitavrg
		G.consumeables.config.card_limit = cardlimitavrg
		G.hand.config.card_limit = cardlimitavrg
		G.hand.config.highlighted_limit = cardlimitavrg
		-- poker hand levels.
		local totallevel = 0
		for _, v in ipairs(G.handlist) do
			totallevel = to_big(totallevel) + to_big(G.GAME.hands[v].level)
		end
		local averagelevel = math.ceil(to_big(totallevel) / #G.handlist)
		for _, v in ipairs(G.handlist) do
			G.GAME.hands[v].level = math.max(to_big(0), to_big(averagelevel))
			G.GAME.hands[v].mult = math.max(to_big(G.GAME.hands[v].s_mult) + to_big(G.GAME.hands[v].l_mult)*(to_big(G.GAME.hands[v].level) - to_big(1)), to_big(1))
			G.GAME.hands[v].chips = math.max(to_big(G.GAME.hands[v].s_chips) + to_big(G.GAME.hands[v].l_chips)*(to_big(G.GAME.hands[v].level) - to_big(1)), to_big(0))
		end
		-- hands and discards
		local dishand = math.floor((G.GAME.round_resets.discards + G.GAME.round_resets.hands)/2)
		
		G.GAME.round_resets.hands = dishand
		local handdiff = math.floor(G.GAME.round_resets.hands-dishand)
		local hand_UI = G.HUD:get_UIE_by_ID('hand_UI_count')
		G.GAME.current_round.hands_left = dishand
		hand_UI.config.object:update()
		
		G.GAME.round_resets.discards = dishand
		local disdiff = math.floor(G.GAME.round_resets.discards-dishand)
		local discard_UI = G.HUD:get_UIE_by_ID('discard_UI_count')
		G.GAME.current_round.discards_left = dishand
		discard_UI.config.object:update()
		
		G.HUD:recalculate()
	end,
}

if Talisman then
	SMODS.Voucher{
		key = 'mspaint',
		pos = { x = 3, y = 1 },
		atlas = 'TOGAConsumables',
		unlocked = true,
		cost = 20,
		rarity = 3,
		config = { rarity = 3, extra = { echip = 1.05, jokerslot = -2 } },
		loc_vars = function(self, info_queue, card)
			return {vars = { card.ability.extra.echip, card.ability.extra.jokerslot }}
		end,
		redeem = function(self)
			G.jokers.config.card_limit = G.jokers.config.card_limit + self.config.extra.jokerslot
		end,
		requires = {'v_paint_brush'},
		calculate = function(self, card, context)
			if context.cardarea == G.hand and context.other_card and not context.repetition and not context.repetition_only and not context.end_of_round and not context.other_card.debuff then
				return {
					card = context.other_card,
					echips = card.ability.extra.echip,
					echip_message = {message = localize{ type = "variable", key = "toga_Echip", vars = { card.ability.extra.echip } }, colour = G.C.DARK_EDITION, sound = "talisman_echip"}
				}
			end
		end,
	}
end

SMODS.Voucher{
	key = 'dataflush',
	pos = { x = 4, y = 1 },
	atlas = 'TOGAConsumables',
	unlocked = true,
	cost = 20,
	rarity = 3,
	config = { rarity = 3 },
	calculate = function(self, card, context)
		if context.pre_discard then
			local _, _, pokerhands = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
			if next(pokerhands['Flush']) and G.consumeables.cards[1] then
				G.E_MANAGER:add_event(Event({
					func = function() 
						local card = copy_card(pseudorandom_element(G.consumeables.cards, pseudoseed('dnsflush')), nil)
						card:set_edition({negative = true}, true)
						card:add_to_deck()
						G.consumeables:emplace(card)
						return true
					end})
				)
			end
		end
	end,
}

SMODS.Voucher{
	key = 'sealegg',
	pos = { x = 3, y = 2 },
	atlas = 'TOGAConsumables',
	unlocked = true,
	cost = 10,
	rarity = 3,
	config = { rarity = 3 },
	loc_vars = function(self, info_queue, card)
		return {vars = { G.GAME.probabilities.normal or 1, G.P_SEALS.toga_sealseal.config.odds or 1337 }}
	end,
}

SMODS.Voucher{
	key = 'caniofferyouanegg',
	pos = { x = 4, y = 2 },
	atlas = 'TOGAConsumables',
	unlocked = true,
	in_pool = function()
		return togabalatro.config.JokeJokersActive -- Should only spawn if allowed to via config!
	end,
	cost = 20,
	rarity = 4,
	config = { rarity = 4 },
	requires = {'v_toga_sealegg'},
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge("Joke (TOGA)", G.C.SECONDARY_SET.Tarot, G.C.WHITE, 1 )
	end
}