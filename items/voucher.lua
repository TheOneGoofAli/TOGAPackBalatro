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
	redeem = function(self, card)
		if togabalatro.config.DoMoreLogging then sendInfoMessage("Increased hand size by "..math.ceil(G.hand.config.card_limit*(card and card.ability.extra or self.config.extra).h_size_scale)..".", "TOGAPack") end
		G.hand:change_size(math.ceil(G.hand.config.card_limit*(card and card.ability.extra or self.config.extra).h_size_scale))
	end,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	poweritem = true
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
	redeem = function(self, card)
		G.GAME.round_resets.discards = G.GAME.round_resets.discards - (card and card.ability.extra or self.config.extra).discards
		ease_discard(-(card and card.ability.extra or self.config.extra).discards)
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
	redeem = function(self, card)
		if togabalatro.config.DoMoreLogging then sendInfoMessage("Added X"..(card and card.ability.extra or self.config.extra).probabilitymult.." probability multiplier.", "TOGAPack") end
	end,
	calculate = function(self, card, context)
		if context.mod_probability and not context.blueprint then
			return { numerator = context.numerator * (card and card.ability.extra or self.config.extra).probabilitymult }
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
	redeem = function(self, card)
		if togabalatro.config.DoMoreLogging then sendInfoMessage("Added X"..(card and card.ability.extra or self.config.extra).probabilitymult.." probability multiplier.", "TOGAPack") end
	end,
	calculate = function(self, card, context)
		if context.mod_probability and not context.blueprint then
			return { numerator = context.numerator * (card and card.ability.extra or self.config.extra).probabilitymult }
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
	redeem = function(self, card)
		togabalatro.handlimitchange(math.max(1, math.floor((card and card.ability.extra or self.config.extra).moreselect)))
		if togabalatro.config.DoMoreLogging then sendInfoMessage("Increased card selection limit by "..math.max(1, math.floor((card and card.ability.extra or self.config.extra).moreselect))..".", "TOGAPack") end
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
	redeem = function(self, card)
		-- do the sound!
		play_sound('toga_scalesofjustice')
		-- Joker slots, Consumable slots, hand size, card selection limit.
		local cardlimitavrg = math.floor(((G.jokers and G.jokers.config.card_limit or 5) + (G.hand and G.hand.config.card_limit or 8) + (G.hand and G.hand.config.highlighted_limit or 5) + (G.consumeables and G.consumeables.config.card_limit or 2))/4)
		if togabalatro.config.DoMoreLogging then sendInfoMessage("Resulted average is "..cardlimitavrg..".", "TOGAPack") end
		G.jokers.config.card_limit = cardlimitavrg
		G.consumeables.config.card_limit = cardlimitavrg
		G.hand.config.card_limit = cardlimitavrg
		togabalatro.handlimitchange(cardlimitavrg, true)
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

SMODS.Voucher{
	key = 'mspaint',
	pos = { x = 3, y = 1 },
	atlas = 'TOGAConsumables',
	unlocked = true,
	cost = 20,
	rarity = 3,
	config = { rarity = 3, extra = { opamtincr = 1.1 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {key = "toga_chipmultmodinfo", set = 'Other'}
		return { vars = { card.ability.extra.opamtincr } }
	end,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	calculate = function(self, card, context)
		if context.toga_affectchipmult and context.opamount and not context.retrigger_joker then
			return { amtmult = card.ability.extra.opamtincr, card = card }
		end
	end,
	poweritem = true
}

SMODS.Voucher{
	key = 'dataflush',
	pos = { x = 4, y = 1 },
	atlas = 'TOGAConsumables',
	unlocked = true,
	cost = 20,
	rarity = 3,
	config = { rarity = 3, extra = { copies = 1 } },
	loc_vars = function(self, info_queue, card)
		local actualcopies = math.floor(card.ability.extra.copies)
		return { key = actualcopies > 1 and self.key..'_multiple' or self.key, vars = { actualcopies > 1 and actualcopies or 1, localize('Flush', "poker_hands") } }
	end,
	calculate = function(self, card, context)
		if card.ability.extra.copies < 1 then card.ability.extra.copies = 1 end -- at least one.
		
		if context.pre_discard then
			local _, _, pokerhands = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
			if next(pokerhands['Flush']) and G.consumeables.cards[1] then
				return { func = function()
					for i = 1, math.floor(card.ability.extra.copies) do
						local card = copy_card(pseudorandom_element(G.consumeables.cards, pseudoseed('dnsflush')), nil)
						card:set_edition({negative = true}, true)
						card:add_to_deck()
						G.consumeables:emplace(card)
					end
				end }
			end
		end
	end,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	poweritem = true
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
		if self.discovered then info_queue[#info_queue + 1] = G.P_CENTERS.j_egg end
		return {vars = { SMODS.get_probability_vars(card or self, 1, G.P_SEALS.toga_sealseal.config.odds or 1337) }}
	end,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	poweritem = true
}

SMODS.Voucher{
	key = 'caniofferyouanegg',
	pos = { x = 4, y = 2 },
	atlas = 'TOGAConsumables',
	unlocked = true,
	cost = 20,
	rarity = 4,
	config = { rarity = 4, extra = { xmult = 1.75 } },
	loc_vars = function(self, info_queue, card)
		if self.discovered then info_queue[#info_queue + 1] = G.P_CENTERS.j_egg end
		return { vars = { card.ability.extra.xmult } }
	end,
	requires = {'v_toga_sealegg'},
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge("Joke (TOGA)", G.C.SECONDARY_SET.Tarot, G.C.WHITE, 1 )
	end,
	calculate = function(self, card, context)
		local othjkr = context.other_joker or context.other_consumeable or nil
		if othjkr and othjkr.config and othjkr.config.center and othjkr.config.center.key and othjkr.config.center.key == 'j_egg' then
			return { xmult = card.ability.extra.xmult, message_card = othjkr }
		end
	end,
	in_pool = function()
		return togabalatro.config.ShowPower and togabalatro.config.JokeJokersActive
	end,
	jokeitem = true,
	poweritem = true
}

SMODS.Voucher{
	key = 'auroramatter',
	pos = { x = 5, y = 1 },
	atlas = 'TOGAConsumables',
	unlocked = true,
	cost = 15,
	rarity = 3,
	config = { rarity = 3, extra = { negchance = 4 } },
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.negchance}}
	end,
	redeem = function(self, card)
		if togabalatro.config.DoMoreLogging then sendInfoMessage("Negative edition chance multiplied by "..math.ceil((card and card.ability.extra or self.config.extra).negchance).."X.", "TOGAPack") end
		G.GAME.toga_negchance = (G.GAME.toga_negchance or 1)*(card and card.ability.extra or self.config.extra).negchance
	end,
}

SMODS.Voucher{
	key = 'quantummatter',
	pos = { x = 5, y = 2 },
	atlas = 'TOGAConsumables',
	unlocked = true,
	cost = 20,
	rarity = 4,
	config = { rarity = 4, extra = { negchance = 4 } },
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.negchance}}
	end,
	requires = {'v_auroramatter'},
	redeem = function(self, card)
		if togabalatro.config.DoMoreLogging then sendInfoMessage("Negative edition chance multiplied by "..math.ceil((card and card.ability.extra or self.config.extra).negchance).."X.", "TOGAPack") end
		G.GAME.toga_negchance = (G.GAME.toga_negchance or 1)*(card and card.ability.extra or self.config.extra).negchance
	end,
}

SMODS.Voucher{
	key = 'spectralzipper',
	pos = { x = 6, y = 1 },
	atlas = 'TOGAConsumables',
	unlocked = true,
	cost = 20,
	rarity = 4,
	config = { rarity = 4, extra = { odds = 500 } },
	requires = {'v_omen_globe'},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.p_toga_togaziparchivepack
		info_queue[#info_queue + 1] = G.P_CENTERS.p_toga_togararpack
		return {vars = { SMODS.get_probability_vars(card or self, 1, card.ability.extra.odds or 500) } }
	end,
	redeem = function(self, card)
		G.GAME.spectralzipper_chance = (card and card.ability.extra or self.config.extra).odds or 500
		if togabalatro.config.DoMoreLogging then sendInfoMessage("Spectral Zipper chance set to "..G.GAME.spectralzipper_chance..".", "TOGAPack") end
	end,
}

SMODS.Voucher{
	key = 'bigbonk',
	pos = { x = 6, y = 2 },
	atlas = 'TOGAConsumables',
	unlocked = true,
	cost = 20,
	rarity = 4,
	config = { rarity = 4, extra = { odds = 100, cmopamt = 20 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cmopamt, SMODS.get_probability_vars(card or self, 2, card.ability.extra.odds or 100, "bigbonk", nil, true) } }
	end,
	calculate = function(self, card, context)
		if context.toga_affectchipmult and context.opamount and not context.retrigger_joker and SMODS.pseudorandom_probability(card, "bigbonk", 2, card.ability.extra.odds, "bigbonk", true) then
			SMODS.calculate_effect({ message = '!', sound = not silent and togabalatro.config.SFXWhenTriggered and "toga_bonk", pitch = not silent and togabalatro.config.SFXWhenTriggered and togabalatro.randompitch() }, card)
			return { amtmult = card.ability.extra.cmopamt, card = card }
		end
	end,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	pixel_size = { w = 71, h = 79 },
	poweritem = true
}