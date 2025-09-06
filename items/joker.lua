sendInfoMessage("Loading Jokers...", "TOGAPack")

-- Check for 2 and King.
togabalatro.y2kcheck = function(context)
	local twopresent, kingpresent = false, false
	local twos, kings = 0, 0
	for i = 1, #context.full_hand do
		if context.full_hand[i]:get_id() == 2 then
			twopresent = true
			twos = twos + 1
		end
		if context.full_hand[i]:get_id() == 13 then
			kingpresent = true
			kings = kings + 1
		end
	end
	return twopresent, kingpresent, twos, kings
end

SMODS.Joker{
	key = 'y2kbug',
	config = { extra = { chips = 25, mult = 4 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
	end,
	unlocked = true,
	discovered = true,
	rarity = 1,
	atlas = 'TOGAJokersMain',
	pos = { x = 1, y = 0 },
	cost = 4,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			local twos, kings = togabalatro.y2kcheck(context)
			if twos and kings then
				return {chips = card.ability.extra.chips, mult = card.ability.extra.mult}
			end
		end
	end
}

SMODS.Joker{
	key = 'controlpanel',
	config = { extra = { money = 0.5, increase = 0.5, totalmoney = 3.5 } },
	loc_vars = function(self, info_queue, card)
		local jokerslotbonus, consslotbonus = 0, 0
		if G.jokers then jokerslotbonus = card.ability.extra.money*G.jokers.config.card_limit end
		if G.consumeables then consslotbonus = card.ability.extra.money*G.consumeables.config.card_limit end
		card.ability.extra.totalmoney = jokerslotbonus+consslotbonus
		return { vars = { card.ability.extra.money, card.ability.extra.increase, math.ceil(card.ability.extra.totalmoney) } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 1, y = 1 },
	cost = 7,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if context.end_of_round and not (context.individual or context.repetition or context.blueprint) and G.GAME.blind.boss then
			-- card.ability.extra.money = card.ability.extra.money + card.ability.extra.increase
			-- card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "money",
				scalar_value = "increase",
			})
		end
	end,
	calc_dollar_bonus = function(self, card)
		if card.ability.extra.money > 0 then
			local jokerslotbonus, consslotbonus = 0, 0
			if G.jokers then jokerslotbonus = card.ability.extra.money*G.jokers.config.card_limit end
			if G.consumeables then consslotbonus = card.ability.extra.money*G.consumeables.config.card_limit end
			card.ability.extra.totalmoney = jokerslotbonus+consslotbonus
			return math.ceil(card.ability.extra.totalmoney)
		end
	end
}

SMODS.Joker{
	key = 'taskmgr',
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersMain',
	pos = { x = 0, y = 1 },
	cost = 8,
	blueprint_compat = true,
	perishable_compat = false,
	calculate = function(self, card, context)
		if G.GAME.current_round.discards_left == 2 then
			local eval = function() return G.GAME.current_round.discards_left == 1 end
			juice_card_until(card, eval, true)
		end
		
		if context.discard and not context.blueprint then
			if G.GAME.current_round.discards_left == 1 then
				return {
					remove = true,
					card = context.other_card
				}
			end
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenAdding and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_infraredbegin")
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenRemoving and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_infraredend")
		end
	end
}

-- Add up our 4 values and divide by 4 for their average.
togabalatro.multaverage = function(card)
	local hleft, dleft, jslots, cslots = G.GAME.current_round.hands_left or 4, G.GAME.current_round.discards_left or 3, G.jokers and G.jokers.config.card_limit or 5, G.consumeables and G.consumeables.config.card_limit or 2
	card.ability.extra.baseXmult = math.max(card.ability.extra.baseXmult, 1)
	local averagecalc = (hleft+dleft+jslots+cslots)/8
	return math.max(card.ability.extra.baseXmult * averagecalc, card.ability.extra.baseXmult, 1)
end

-- Was previously Task Manager.
SMODS.Joker{
	key = 'useraccounts',
	config = { extra = { baseXmult = 1, totalXmult = 1, odds = 4 } },
	loc_vars = function(self, info_queue, card)
		if self.discovered then
			info_queue[#info_queue + 1] = {key = "toga_useraccountsinfo", set = 'Other'}
		end
		card.ability.extra.totalXmult = togabalatro.multaverage(card)
		return { vars = { card.ability.extra.totalXmult, SMODS.get_probability_vars(card or self, 1, (card.ability or self.config).extra.odds) } }
	end,
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersMain',
	pos = { x = 3, y = 1 },
	cost = 8,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before then
			card.ability.extra.totalXmult = togabalatro.multaverage(card)
		end
		
		if context.individual and context.cardarea == G.play then
			if context.other_card and SMODS.pseudorandom_probability(card, "toga_useraccounts", 1, card.ability.extra.odds, 'useraccounts') then
				return { x_mult = card.ability.extra.totalXmult }
			end
		end
	end,
}

SMODS.Joker{
	key = 'virtualmemory',
	config = { extra = { odds = 4 }, bypasswu = true },
	loc_vars = function(self, info_queue, card)
		return { vars = { SMODS.get_probability_vars(card or self, 1, (card.ability or self.config).extra.odds) } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 3, y = 0 },
	cost = 6,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if SMODS.pseudorandom_probability(card, "toga_virtualmemory", 1, card.ability.extra.odds, 'virtualmemory') then
				return {
					swap = true,
					message = localize('toga_pagefileuse'),
					colour = G.C.PURPLE,
					sound = not silent and togabalatro.config.SFXWhenTriggered and "toga_mmeclap",
					pitch = not silent and togabalatro.config.SFXWhenTriggered and togabalatro.randompitch(),
					message_card = context.other_card
				}
			end
		end
	end,
}

SMODS.Joker{
	key = 'recyclebin',
	config = { extra = { xchip_increase = 0.05, xchip_mod = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xchip_increase, card.ability.extra.xchip_mod, card.ability.extra.xchip_increase*3 } }
	end,
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersMain',
	pos = { x = 2, y = 2 },
	cost = 12,
	blueprint_compat = true,
	calculate = function(self, card, context)
		local xchipval = card.ability.extra and card.ability.extra.xchip_mod or 1
		
		if context.individual and context.cardarea == G.play and xchipval > 1 then
			if context.other_card == context.scoring_hand[#context.scoring_hand] then
				return {
					x_chips = card.ability.extra.xchip_mod > 1 and card.ability.extra.xchip_mod or nil,
					xchip_message = card.ability.extra.xchip_mod > 1 and {message = localize{ type = "variable", key = "a_xchips", vars = { card.ability.extra.xchip_mod } }, colour = G.C.CHIPS, sound = "xchips"} or nil,
					card = context.blueprint_card or card
				}
			end
		end
	
		if context.remove_playing_cards then
			for k, v in ipairs(context.removed) do
				if v.config.center ~= G.P_CENTERS.c_base then
					-- Add 3x0.05.
					SMODS.scale_card(card, {
						ref_table = card.ability.extra,
						ref_value = "xchip_mod",
						scalar_value = "xchip_increase",
						no_message = true,
						operation = function(ref_table, ref_value, initial, change)
							ref_table[ref_value] = initial + 3*change
						end,
					})
				else
					-- Add 0.05.
					SMODS.scale_card(card, {
						ref_table = card.ability.extra,
						ref_value = "xchip_mod",
						scalar_value = "xchip_increase",
						no_message = true,
					})
				end
			end
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), sound = not silent and togabalatro.config.SFXWhenTriggered and "toga_recyclebinsfx"})
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenAdding and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_recyclebinsfx")
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenRemoving and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_plus98emptybin")
		end
	end,
	update = function(self, card, context)
		if card.ability.extra.xchip_mod < 1 then card.ability.extra.xchip_mod = 1 end
	end
}

SMODS.Joker{
	key = 'theinternet',
	config = { extra = { curchips = 0, bonuschips = 15 } },
	loc_vars = function(self, info_queue, card)
		card.ability.extra.curchips = (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.all or 0) * card.ability.extra.bonuschips
		return { vars = { card.ability.extra.curchips, card.ability.extra.bonuschips } }
	end,
	unlocked = true,
	rarity = 1,
	atlas = 'TOGAJokersMain',
	pos = { x = 3, y = 2 },
	cost = 3,
	blueprint_compat = true,
	demicolon_compat = true,
	calculate = function(self, card, context)
		if context.using_consumeable and not context.blueprint then
			card.ability.extra.curchips = (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.all or 0) * card.ability.extra.bonuschips
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_chips', vars = { card.ability.extra.curchips } }, colour = G.C.CHIPS })
		end
		
		if (context.joker_main or context.forcetrigger) and card.ability.extra.curchips > 0 then
			return {
				chips = card.ability.extra.curchips,
			}
		end
	end,
}

SMODS.Joker{
	key = 'computerlock',
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersMain',
	pos = { x = 0, y = 0 },
	cost = 10,
	blueprint_compat = false,
	eternal_compat = false,
	demicolon_compat = true,
	calculate = function(self, card, context)
		if card.ability.eternal then card:set_eternal(false); card.ability.eternal = false end
		
		if (context.selling_self or context.forcetrigger) and not context.retrigger_joker and not context.blueprint_card then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					if i > 1 then
						if G.jokers.cards[i-1] and not G.jokers.cards[i-1].ability.eternal and G.jokers.cards[i-1].config.center.key ~= "j_toga_computerlock" then
							G.jokers.cards[i-1]:set_eternal(true)
							G.jokers.cards[i-1].ability.eternal = true
							card_eval_status_text(G.jokers.cards[i-1], 'extra', nil, nil, nil, {message = localize('toga_userlocked'), colour = G.C.RED, sound = not silent and togabalatro.config.SFXWhenTriggered and 'toga_mscmenucmd'})
						elseif G.jokers.cards[i-1] and G.jokers.cards[i-1].ability.eternal then
							G.jokers.cards[i-1]:set_eternal(false)
							G.jokers.cards[i-1].ability.eternal = false
							card_eval_status_text(G.jokers.cards[i-1], 'extra', nil, nil, nil, {message = localize('toga_userunlocked'), colour = G.C.RED, sound = not silent and togabalatro.config.SFXWhenTriggered and 'toga_mscmenucmd'})
						end
					end
					if i < #G.jokers.cards then
						if G.jokers.cards[i+1] and not G.jokers.cards[i+1].ability.eternal and G.jokers.cards[i+1].config.center.key ~= "j_toga_computerlock" then
							G.jokers.cards[i+1]:set_eternal(true)
							G.jokers.cards[i+1].ability.eternal = true
							card_eval_status_text(G.jokers.cards[i+1], 'extra', nil, nil, nil, {message = localize('toga_userlocked'), colour = G.C.RED, sound = not silent and togabalatro.config.SFXWhenTriggered and 'toga_mscmenucmd'})
						elseif G.jokers.cards[i+1] and G.jokers.cards[i+1].ability.eternal then
							G.jokers.cards[i+1]:set_eternal(false)
							G.jokers.cards[i+1].ability.eternal = false
							card_eval_status_text(G.jokers.cards[i+1], 'extra', nil, nil, nil, {message = localize('toga_userunlocked'), colour = G.C.RED, sound = not silent and togabalatro.config.SFXWhenTriggered and 'toga_mscmenucmd'})
						end
					end
				end
			end
		end
	end
}

SMODS.Joker{
	key = 'virtualpc',
	config = { extra = { chips = 0, mult = 0 }, bypasswu = true },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
	end,
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersMain',
	pos = { x = 2, y = 3 },
	cost = 12,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.initial_scoring_step and not context.blueprint then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "chips",
				scalar_value = "hand_chips",
				scalar_table = _G,
				operation = function(ref_table, ref_value, initial, change)
					ref_table[ref_value] = initial + to_big(change)
				end,
				no_message = true
			})
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "mult",
				scalar_value = "mult",
				scalar_table = _G,
				operation = function(ref_table, ref_value, initial, change)
					ref_table[ref_value] = initial + to_big(change)
				end,
				no_message = true
			})
			SMODS.calculate_effect({message = localize('k_upgrade_ex')}, card)
			return nil, true
		end
		if context.joker_main then return { chips = card.ability.extra.chips, mult = card.ability.extra.mult } end
	end,
}

togabalatro.modifylevelchipsmult = function(card, hand, instant, lchips, lmult, context)
	lchips, lmult = lchips or 0, lmult or 0
	local prevals
	if SMODS.displaying_scoring and not (SMODS.displayed_hand == hand) then
		prevals = copy_table(G.GAME.current_round.current_hand)
		prevals.level = (G.GAME.hands[prevals.handname] or {}).level or ''
		prevals.chips = hand_chips
		prevals.mult = mult
	end
	if not (instant or Talisman and Talisman.config_file.disable_anims) then
		update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize('toga_perlevel').." "..localize(hand, 'poker_hands'),chips = to_number(G.GAME.hands[hand].l_chips), mult = to_number(G.GAME.hands[hand].l_mult), level=''})
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('tarot1')
			if card then card:juice_up(0.8, 0.5) end
			G.TAROT_INTERRUPT_PULSE = true
			return true end }))
		if lmult and lmult ~= 0 then
			update_hand_text({delay = 0}, {mult = to_number(to_big(G.GAME.hands[hand].l_mult) + to_big(lmult)), StatusText = true})
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('tarot1')
				if card then card:juice_up(0.8, 0.5) end
			return true end }))
		end
		if lchips and lchips ~= 0 then
			update_hand_text({delay = 0}, {chips = to_number(to_big(G.GAME.hands[hand].l_chips) + to_big(lchips)), StatusText = true})
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('tarot1')
				if card then card:juice_up(0.8, 0.5) end
			return true end }))
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
			G.TAROT_INTERRUPT_PULSE = nil
		return true end }))
		delay(1.3)
		update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.5}, prevals or {mult = 0, chips = 0, handname = '', level = ''})
	else
		update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize('toga_perlevel').." "..localize(hand, 'poker_hands'),chips = to_number(to_big(G.GAME.hands[hand].l_chips) + to_big(lchips)), mult = to_number(to_big(G.GAME.hands[hand].l_mult) + to_big(lmult)), level=''})
		update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.5}, prevals or {mult = 0, chips = 0, handname = '', level = ''})
	end
	
	if Talisman and Talisman.config_file.disable_anims then
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function()
			play_sound('tarot1')
		return true end }))
	end
	
	if togabalatro.config.DoMoreLogging then sendInfoMessage(localize('toga_perlevel').." "..localize(hand, 'poker_hands'), "TOGAPack") end
	G.GAME.hands[hand].l_chips = to_big(G.GAME.hands[hand].l_chips) + to_big(lchips)
	G.GAME.hands[hand].l_mult = to_big(G.GAME.hands[hand].l_mult) + to_big(lmult)
	G.GAME.hands[hand].mult = math.max(to_big(G.GAME.hands[hand].s_mult) + to_big(G.GAME.hands[hand].l_mult)*(to_big(G.GAME.hands[hand].level) - to_big(1)), to_big(1))
	G.GAME.hands[hand].chips = math.max(to_big(G.GAME.hands[hand].s_chips) + to_big(G.GAME.hands[hand].l_chips)*(to_big(G.GAME.hands[hand].level) - to_big(1)), to_big(0))
end

SMODS.Joker{
	key = 'ie',
	config = { extra = { phchips = 5, phmult = 4 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { 100/card.ability.extra.phchips, 100/card.ability.extra.phmult } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 1, y = 3 },
	cost = 7,
	blueprint_compat = true,
	demicolon_compat = true,
	calculate = function(self, card, context)
		if context.ending_shop or context.forcetrigger then
			local curcard = context.blueprint_card or card
			local cxt = context
			return {
				func = function()
					local names = {}
					for k, v in ipairs(G.handlist) do
						if G.GAME.hands[v] and G.GAME.hands[v].visible then names[#names+1] = v end
					end
					local hand = pseudorandom_element(names, pseudoseed('ie'))
					togabalatro.modifylevelchipsmult(curcard, hand, false, G.GAME.hands[hand].s_chips/card.ability.extra.phchips, G.GAME.hands[hand].s_mult/card.ability.extra.phmult, cxt)
				end
			}
		end
	end
}

SMODS.Joker{
	key = 'systemrestore',
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersMain',
	pos = { x = 0, y = 3 },
	cost = 12,
	blueprint_compat = true,
	perishable_compat = false,
	calculate = function(self, card, context)
		if context.remove_playing_cards then
			local addedcards = {}
			for i = 1, #context.removed do
				if togabalatro.config.DoMoreLogging then sendInfoMessage(context.removed[i].base.id, "TOGAPack") end
				local _card = copy_card(context.removed[1], nil, nil, G.playing_card)
				_card:add_to_deck()
				G.deck.config.card_limit = G.deck.config.card_limit + 1
				table.insert(G.playing_cards, _card)
				G.deck:emplace(_card)
				table.insert(addedcards, _card)
			end
			if addedcards[1] then playing_card_joker_effects(addedcards) end
			return { message = localize('toga_systemrestore1') }
		end
	end
}

SMODS.Joker{
	key = 'skype',
	config = { extra = { permodxmult = 2.5 } },
	loc_vars = function(self, info_queue, card)
		card.ability.extra.permodxmult = math.max(card.ability.extra.permodxmult, 1)
		local mods, modcount = {['TOGAPack'] = true}, 1 -- count ourselves.
		if G.jokers and G.consumeables and G.vouchers then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].config.center.original_mod and not mods[G.jokers.cards[i].config.center.original_mod.id] then
					mods[G.jokers.cards[i].config.center.original_mod.id] = true
					modcount = modcount + 1
				end
			end
			for i = 1, #G.consumeables.cards do
				if G.consumeables.cards[i].config.center.original_mod and not mods[G.consumeables.cards[i].config.center.original_mod.id] then
					mods[G.consumeables.cards[i].config.center.original_mod.id] = true
					modcount = modcount + 1
				end
			end
			for i = 1, #G.vouchers.cards do
				if G.vouchers.cards[i].config.center.original_mod and not mods[G.vouchers.cards[i].config.center.original_mod.id] then
					mods[G.vouchers.cards[i].config.center.original_mod.id] = true
					modcount = modcount + 1
				end
			end
		end
		return { key = modcount > 1 and self.key.."_moremod" or self.key, vars = { card.ability.extra.permodxmult, card.ability.extra.permodxmult*modcount, modcount } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 3, y = 3 },
	cost = 6,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.joker_main then
			card.ability.extra.permodxmult = math.max(card.ability.extra.permodxmult, 1)
			local mods, modcount = {['TOGAPack'] = true}, 1 -- count ourselves.
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].config.center.original_mod and not mods[G.jokers.cards[i].config.center.original_mod.id] then
					mods[G.jokers.cards[i].config.center.original_mod.id] = true
					modcount = modcount + 1
				end
			end
			for i = 1, #G.consumeables.cards do
				if G.consumeables.cards[i].config.center.original_mod and not mods[G.consumeables.cards[i].config.center.original_mod.id] then
					mods[G.consumeables.cards[i].config.center.original_mod.id] = true
					modcount = modcount + 1
				end
			end
			for i = 1, #G.vouchers.cards do
				if G.vouchers.cards[i].config.center.original_mod and not mods[G.vouchers.cards[i].config.center.original_mod.id] then
					mods[G.vouchers.cards[i].config.center.original_mod.id] = true
					modcount = modcount + 1
				end
			end
			return { xmult = math.max(1, card.ability.extra.permodxmult*modcount) }
		end
	end
}

local msncount = false

SMODS.Joker{
	key = 'msn',
	config = { extra = { perenhxmult = 1.5 } },
	loc_vars = function(self, info_queue, card)
		card.ability.extra.perenhxmult = math.max(card.ability.extra.perenhxmult, 1.5)
		local enh, enhcount = {}, 0
		if G.playing_cards then
			for i = 1, #G.playing_cards do
				msncount = true
				local enhget = SMODS.get_enhancements(G.playing_cards[i])
				if next(enhget) ~= nil then
					for k, v in pairs(enhget) do
						if not enh[k] then enh[k] = true; enhcount = enhcount + 1 end
					end
				end
				msncount = false
			end
		end
		return { vars = { card.ability.extra.perenhxmult, card.ability.extra.perenhxmult^enhcount } }
	end,
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersMain',
	pos = { x = 5, y = 0 },
	cost = 10,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.joker_main then
			card.ability.extra.perenhxmult = math.max(card.ability.extra.perenhxmult, 1.5)
			local enh, enhcount = {}, 0
			if G.playing_cards then
				for i = 1, #G.playing_cards do
					local enhget = SMODS.get_enhancements(G.playing_cards[i])
					if next(enhget) ~= nil then
						for k, v in pairs(enhget) do
							if not enh[k] then enh[k] = true; enhcount = enhcount + 1 end
						end
					end
				end
			end
			return { xmult = math.max(1, card.ability.extra.perenhxmult^enhcount) }
		end
	end
}

-- Random SFX.
togabalatro.plus95rndsfx = function()
	return 'toga_win95pluscmd'..math.random(1, 12)
end

SMODS.Joker{
	key = 'drivespace',
	config = { extra = { reduce = 0.97 }, bypasswu = true },
	loc_vars = function(self, info_queue, card)
		if card.ability.extra.reduce > 1 then card.ability.extra.reduce = 0.97 end -- catch.
		return { vars = { card.ability.extra.reduce } }
	end,
	unlocked = true,
	rarity = 4,
	atlas = 'TOGAJokersMain',
	pos = { x = 2, y = 1 },
	cost = 25,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if card.ability.extra.reduce > 1 then card.ability.extra.reduce = 0.97 end -- catch.
		
		if context.cardarea == G.play then
			if context.other_card and not context.before and not context.after and not context.repetition and not context.repetition_only and to_big(G.GAME.blind.chips) > to_big(0) then
				if Talisman and Talisman.config_file.disable_anims then
					G.GAME.blind.chips = math.floor(G.GAME.blind.chips*card.ability.extra.reduce)
					G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
					G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
					G.HUD_blind:recalculate()
					return nil, true
				else
					G.E_MANAGER:add_event(Event({func = function()
						G.GAME.blind.chips = math.floor(G.GAME.blind.chips*card.ability.extra.reduce)
						G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
						G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
						G.HUD_blind:recalculate()
						G.hand_text_area.blind_chips:juice_up()
						card:juice_up()
						
						if not silent and togabalatro.config.SFXWhenTriggered then play_sound(togabalatro.plus95rndsfx()) end
					return true end }))
					return nil, true
				end
			end
		end
	end
}

SMODS.Joker{
	key = 'bonzibuddy',
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 4, y = 0 },
	cost = 6,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.bonzi_modify_rank then return { amount = -1, card = context.blueprint_card or card } end
	end,
}

SMODS.Joker{
	key = 'netscapenavigator',
	config = { extra = { holoxmult = 1.5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.holoxmult } }
	end,
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersMain',
	pos = { x = 4, y = 1 },
	cost = 8,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if ((context.other_joker and context.other_joker.edition and context.other_joker.edition.holo) or (context.individual and context.cardarea == G.hand and context.other_card and context.other_card.edition and context.other_card.edition.holo
		and not context.other_card.debuff and not context.repetition and not context.repetition_only)) and not context.end_of_round then
			return { xmult = card.ability.extra.holoxmult, message_card = context.other_joker or context.other_card }
		end
	end,
}

SMODS.Joker{
	key = 'diskcleanup',
	config = { extra = { destroymoney = 4 } },
	loc_vars = function(self, info_queue, card)
		local togadiskcleanupsuit = G.GAME.current_round.togabalatro and G.GAME.current_round.togabalatro.diskcleanup and G.GAME.current_round.togabalatro.diskcleanup.suit
		return { vars = { card.ability.extra.destroymoney, localize(togadiskcleanupsuit or "Hearts", 'suits_plural') } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 4, y = 2 },
	cost = 6,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.remove_playing_cards and context.removed and context.removed[1] then
			local dmoney = 0
			local togadiskcleanupsuit = G.GAME.current_round.togabalatro and G.GAME.current_round.togabalatro.diskcleanup and G.GAME.current_round.togabalatro.diskcleanup.suit
			for i = 1, #context.removed do
				if context.removed[i] and context.removed[i]:is_suit(togadiskcleanupsuit) then
					dmoney = dmoney + card.ability.extra.destroymoney
				end
			end
			if dmoney > 0 then return { dollars = dmoney } end
		end
		
		if context.end_of_round and not (context.individual or context.repetition or context.blueprint) then
			return { message = localize('k_reset') }
		end
	end,
}

SMODS.Joker{
	key = 'tempinternetfiles',
	config = { extra = { curxmult = 1, percard = 0.01 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.curxmult, card.ability.extra.percard } }
	end,
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersMainW',
	pos = { x = 0, y = 0 },
	cost = 7,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if (context.before or context.pre_discard) and not context.blueprint then
			local phands
			if context.before then phands = context.poker_hands
			elseif context.pre_discard then
				local _, _, dphands = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
				phands = dphands
			end
			if phands and next(phands['Flush']) then
				card.ability.extra.curxmult = 1
				return {
					message = localize('k_reset'),
					colour = G.C.RED
				}
			end
		end
		
		if context.individual_draw and not context.blueprint then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "curxmult",
				scalar_value = "percard",
				scaling_message = {
					delay = 0.05,
					message = localize{ type='variable', key = 'a_xmult', vars = {card.ability.extra.curxmult} },
					colour = G.C.RED
				}
			})
			return nil, true
		end
		
		if context.joker_main then return { xmult = card.ability.extra.curxmult } end
	end,
	display_size = { w = 71 * 1.27, h = 95 },
	pixel_size = { w = 71, h = 95 }
}

SMODS.Joker{
	key = 'regedit',
	loc_vars = function(self, info_queue, card)
		local togaregeditsuit = G.GAME.current_round.togabalatro and G.GAME.current_round.togabalatro.regedit and G.GAME.current_round.togabalatro.regedit.suit
		return { vars = { localize(togaregeditsuit or "Hearts", 'suits_plural') } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 4, y = 3 },
	cost = 7,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if context.end_of_round and not (context.individual or context.repetition or context.blueprint) then
			return { message = localize('k_reset') }
		end
	end,
}

SMODS.Joker{
	key = 'certserver',
	loc_vars = function(self, info_queue, card)
		local togacertserver = G.GAME.current_round.togabalatro and G.GAME.current_round.togabalatro.certserver or {}
		return { vars = { localize(togacertserver.rank or "Ace", 'ranks') } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 4, y = 5 },
	cost = 6,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if context.end_of_round and not (context.individual or context.repetition or context.blueprint) then
			return { message = localize('k_reset') }
		end
	end,
}

SMODS.Joker{
	key = 'msagent',
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersMain',
	pos = { x = 5, y = 1 },
	cost = 8,
	blueprint_compat = true,
	demicolon_compat = true,
	calculate = function(self, card, context)
		if context.initial_scoring_step or context.force_trigger then
			local chipsmulttogether = mult + hand_chips
			local rndperc = pseudorandom(pseudoseed('msagent'), 1, 100)/100
			local pchips, pmult = chipsmulttogether*rndperc, chipsmulttogether*(1-rndperc)
			hand_chips = mod_chips(pchips)
			mult = mod_mult(pmult)
			update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
			G.E_MANAGER:add_event(Event({
				func = (function()
					play_sound('gong', 0.33+math.random(-1,1)/10, 0.4)
					play_sound('gong', 0.66+math.random(-1,1)/10, 0.3)
					play_sound('tarot1', 0.94)
					ease_colour(G.C.UI_CHIPS, {0.8, 0.45, 0.85, 1})
					ease_colour(G.C.UI_MULT, {0.8, 0.45, 0.85, 1})
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						blockable = false,
						blocking = false,
						delay =  0.8,
						func = (function() 
							ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.8)
							ease_colour(G.C.UI_MULT, G.C.RED, 0.8)
							return true
						end)
					}))
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						blockable = false,
						blocking = false,
						no_delete = true,
						delay =  1.3,
						func = (function() 
							G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
							G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
							return true
						end)
					}))
					return true
				end)
			}))
			SMODS.calculate_effect({message = localize('toga_unbalanced'), colour =  {0.8, 0.45, 0.85, 1}}, context.blueprint_card or card)
			delay(0.6)
		end
	end,
}

SMODS.Joker{
	key = 'drwatson',
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersMain',
	pos = { x = 5, y = 2 },
	cost = 8,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if (context.cardarea == G.play or context.cardarea == G.hand) and context.destroy_card and context.destroy_card.playing_card and context.destroy_card.debuff then return { remove = true } end
	end,
}

SMODS.Joker{
	key = 'fontsfolder',
	config = { extra = { perfontxmult = 1.5 } },
	loc_vars = function(self, info_queue, card)
		card.ability.extra.perfontxmult = math.max(card.ability.extra.perfontxmult, 1)
		local fontamount = togabalatro.getexternalfontcount()
		if next(togabalatro.externalfontsloaded) and fontamount > 0 then
			return { vars = { card.ability.extra.perfontxmult, fontamount, card.ability.extra.perfontxmult*fontamount } }
		else return { key = self.key.."_inactive" } end
	end,
	unlocked = true,
	in_pool = function()
		return next(togabalatro.externalfontsloaded) and togabalatro.getexternalfontcount() > 0 -- Should only spawn if fonts are detected.
	end,
	rarity = 3,
	atlas = 'TOGAJokersMain',
	pos = { x = 5, y = 3 },
	cost = 8,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if next(togabalatro.externalfontsloaded) and context.joker_main then
			local fontamount = togabalatro.getexternalfontcount()
			if fontamount > 0 then return { xmult = math.max(card.ability.extra.perfontxmult, 1)*fontamount } end
		end
	end,
}

SMODS.Joker{
	key = 'pcmcia',
	config = { extra = { xmult = 3 } },
	loc_vars = function(self, info_queue, card)
		card.ability.extra.xmult = math.max(card.ability.extra.xmult, 1)
		return { vars = { card.ability.extra.xmult } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 4, y = 4 },
	cost = 6,
	blueprint_compat = false,
	eternal_compat = false,
	calculate = function(self, card, context)
		if context.blueprint then return end
		if context.joker_main then return { xmult = math.max(card.ability.extra.xmult, 1) } end
		if context and next(context) and math.random(1, 20) == 5 then togabalatro.performpseudolag() end
	end,
}

SMODS.Joker{
	key = 'scsi',
	config = { extra = { hsize = -1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hsize > 0 and "+"..card.ability.extra.hsize or card.ability.extra.hsize } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 5, y = 4 },
	cost = 6,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.redeem_individual_voucher then
			G.hand:change_size(1)
			card.ability.extra.hsize = (card.ability.extra.hsize or -1) + 1
			return { message = localize('k_upgrade_ex') }
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		G.hand:change_size(card.ability.extra.hsize or -1)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(-(card.ability.extra.hsize or -1))
	end,
}

SMODS.Joker{
	key = 'visualstudio',
	config = { extra = { mrank = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { math.floor(card.ability.extra.mrank) } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 3, y = 5 },
	cost = 6,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.vs_modify_rank then return { amount = math.floor(card.ability.extra.mrank), card = context.blueprint_card or card } end
	end,
}

SMODS.Joker{
	key = 'cpu',
	config = { extra = { coremult = 2 } },
	loc_vars = function(self, info_queue, card)
		local cores = love.system.getProcessorCount() or 1
		return { vars = { card.ability.extra.coremult, cores, cores*card.ability.extra.coremult } }
	end,
	unlocked = true,
	rarity = 1,
	atlas = 'TOGAJokersMain',
	pos = { x = 1, y = 5 },
	cost = 5,
	blueprint_compat = true,
	demicolon_compat = true,
	calculate = function(self, card, context)
		if context.joker_main or context.force_trigger then return { mult = (love.system.getProcessorCount() or 1)*card.ability.extra.coremult } end
	end,
}

SMODS.Joker{
	key = 'ups',
	config = { extra = { debuffxmult = 0.2, bonusxmult = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.debuffxmult, 1+card.ability.extra.bonusxmult } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 2, y = 5 },
	cost = 5,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.joker_main then return { xmult = math.max(1+card.ability.extra.bonusxmult, 1) } end
		if context.debuffed_ups and context.card and not context.blueprint then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "bonusxmult",
				scalar_value = "debuffxmult",
				scaling_message = { message = localize('k_upgrade_ex'), delay = 0.25 }
			})
			return nil, true
		end
	end,
}

SMODS.Joker{
	key = 'tuneupwizard',
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 2, y = 6 },
	cost = 6,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.tuneupwizard then return { flip = true, card = card } end
	end,
}

SMODS.Joker{
	key = 'activesync',
	config = { extra = { odds = 8 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { SMODS.get_probability_vars(card or self, 1, (card.ability or self.config).extra.odds) } }
	end,
	unlocked = true,
	rarity = 4,
	atlas = 'TOGAJokersMain',
	pos = { x = 1, y = 6 },
	cost = 20,
	blueprint_compat = false,
}

SMODS.Joker{
	key = 'hammer',
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersMain',
	pos = { x = 5, y = 5 },
	cost = 8,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if context.hammerscore then return { card = context.blueprint_card or card } end
		if context.destroy_card then
			if context.destroy_card.atomsmashed and SMODS.has_enhancement(context.destroy_card, "m_glass") then return { remove = true }
			else context.destroy_card.atomsmashed = nil end
		end
	end,
}

local function toga_randomruntext()
	local stringtable = { localize('toga_jimbo95txt1'), localize('k_again_ex'), localize('toga_jimbo95txt2'), localize('toga_jimbo95txt3'), localize('toga_jimbo95txt4') }
	return stringtable[math.random(#stringtable)]
end

SMODS.Joker{
	key = 'jimbo95',
	config = { extra = { h_size = 2, retriggers = 1, x_chips = 1.5, x_mult = 1.5} },
	loc_vars = function(self, info_queue, card)
		card.ability.extra.x_chips = math.max(card.ability.extra.x_chips, 1)
		card.ability.extra.x_mult = math.max(card.ability.extra.x_mult, 1)
		card.ability.extra.retriggers = math.max(card.ability.extra.retriggers, 1)
		return { vars = { card.ability.extra.h_size, math.floor(card.ability.extra.retriggers), card.ability.extra.x_chips, card.ability.extra.x_mult } }
	end,
	unlocked = true,
	discovered = true,
	rarity = 4,
	atlas = 'TOGAJokersMain',
	pos = { x = 2, y = 0 },
	soul_pos = { x = 7, y = 0 },
	cost = 20,
	blueprint_compat = true,
	perishable_compat = false,
	add_to_deck = function(self, card, from_debuff)
		G.hand:change_size(card.ability.extra.h_size)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(-card.ability.extra.h_size)
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			if card.ability.extra.x_chips < 1 then card.ability.extra.x_chips = 1 end -- no reduce.
			if card.ability.extra.x_mult < 1 then card.ability.extra.x_mult = 1 end -- only extend.

			return {
				x_chips = card.ability.extra.x_chips > 1 and card.ability.extra.x_chips or nil,
				xchip_message = card.ability.extra.x_chips > 1 and {message = localize{ type = "variable", key = "a_xchips", vars = { card.ability.extra.x_chips } }, colour = G.C.CHIPS, sound = "xchips"} or nil,
				x_mult = card.ability.extra.x_mult > 1 and card.ability.extra.x_mult or nil
			}
		end
		local othcrd = context.other_card
		if context.retrigger_joker_check and not context.retrigger_joker and othcrd and othcrd ~= card and othcrd.config and othcrd.config.center and othcrd.config.center.key and othcrd.config.center.key ~= 'j_toga_jimbo95' then
			if card.ability.extra.retriggers < 1 then card.ability.extra.retriggers = 1 end -- always at least once.
			return {
				message = toga_randomruntext(),
				repetitions = math.floor(card.ability.extra.retriggers),
				card = context.blueprint_card or card,
			}
		end
	end
}

-- Windows OS Jokers moved to separate file...
assert(SMODS.load_file("items/jokers/winos.lua"))()

-- ...with non-Windows OS Jokers also being from their own files.
assert(SMODS.load_file("items/jokers/macos.lua"))()
assert(SMODS.load_file("items/jokers/linuxos.lua"))()

SMODS.Joker{
	key = 'clippit',
	config = { extra = { rescores = 1 } },
	loc_vars = function(self, info_queue, card)
		if self.discovered then
			info_queue[#info_queue + 1] = {key = "toga_clippyorigin", set = 'Other'}
		end
		return { vars = { math.floor(card.ability.extra.rescores) } }
	end,
	unlocked = true,
	rarity = 4,
	atlas = 'TOGAJokersMain',
	pos = { x = 1, y = 2 },
	soul_pos = { x = 7, y = 2 },
	cost = 25,
	blueprint_compat = true,
	perishable_compat = false,
	calculate = function(self, card, context)
		if context.cardarea and context.cardarea == G.hand and (context.clippitscore or context.clippitscore_eor) then
			return { rescores = card.ability.extra.repetitions, card = context.blueprint_card or card }
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenAdding and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_o97doorbell")
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenRemoving and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_o97glide")
		end
	end,
}

SMODS.Joker{
	key = 'rover',
	config = { extra = { odds = 8, curstate = "shop" }, bypasswu = true },
	loc_vars = function(self, info_queue, card)
		return { vars = { SMODS.get_probability_vars(card or self, 1, (card.ability or self.config).extra.odds) } }
	end,
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokerRover',
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	cost = 15,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.roverscore then return { rover = card.ability.extra.odds, card = context.blueprint_card or card } end
		if context.after then card.ability.roverscore = nil end
	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.extra.animated = true
	end,
	remove_from_deck = function(self, card, from_debuff)
		card.ability.extra.animated = nil
	end,
	update = function(self, card)
		if not card.ability.extra.animated then return end
		
		if G.STATE == G.STATES.GAME_OVER then
			card.ability.extra.curstate = "loss"
			card.children.floating_sprite:set_sprite_pos({x = 7, y = 0})
		elseif G.GAME.won and G.OVERLAY_MENU and G.OVERLAY_MENU.config.no_esc then
			card.ability.extra.curstate = "win"
			card.children.floating_sprite:set_sprite_pos({x = 4, y = 0})
		elseif G.shop then
			card.ability.extra.curstate = "shop"
			card.children.floating_sprite:set_sprite_pos({x = 3, y = 0})
		elseif G.round_eval then
			card.ability.extra.curstate = "roundeval"
			card.children.floating_sprite:set_sprite_pos({x = 2, y = 0})
		elseif G.booster_pack then
			card.ability.extra.curstate = "booster"
			card.children.floating_sprite:set_sprite_pos({x = 3, y = 0})
		elseif G.blind_select then
			card.ability.extra.curstate = "blindselect"
			card.children.floating_sprite:set_sprite_pos({x = 5, y = 0})
		elseif G.GAME.blind then
			card.ability.extra.curstate = "inblind"
			if G.GAME.blind.boss then
				card.children.floating_sprite:set_sprite_pos({x = 6, y = 0})
			else
				card.children.floating_sprite:set_sprite_pos({x = 1, y = 0})
			end
		else -- Just so we don't crash.
			card.ability.extra.curstate = "fallback"
			card.children.floating_sprite:set_sprite_pos({x = 1, y = 0})
		end
	end
}

SMODS.Joker{
	key = 'solitairejoker',
	config = { extra = { carddraw = 3 } },
	loc_vars = function(self, info_queue, card)
		local togasolitaire = G.GAME.current_round.togabalatro and G.GAME.current_round.togabalatro.solitaire or {}
		return { vars = { math.floor(card.ability.extra.carddraw), localize(togasolitaire.rank or "Ace", 'ranks') } }
	end,
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersOther',
	pos = { x = 0, y = 0 },
	cost = 8,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if context.end_of_round and not (context.individual or context.repetition or context.blueprint) then
			return { message = localize('k_reset') }
		end
	end,
}

togabalatro.checkxmultsafe = function(card)
	local xmultcheck = card.ability.extra.Xmult_current / card.ability.extra.shortcutfailmult
	if xmultcheck < 1 then return false else return true end
end

SMODS.Joker{
	key = 'jokersrb2kart',
	config = { extra = { Xmult_current = 1, add_shop = 0.05, addshortcut = 0.75, shortcutfailmult = 1.33, maxchance = 3} },
	loc_vars = function(self, info_queue, card)
		if self.discovered then
			info_queue[#info_queue + 1] = {key = "toga_kartjokerlist", set = 'Other', vars = { card.ability.extra.add_shop, card.ability.extra.add_shop*8 } }
			if G.GAME.selected_back.effect.center.key == 'b_toga_srb2kartdeck' then info_queue[#info_queue + 1] = {key = "toga_kartjokershortcutspecial", set = 'Other', vars = { card.ability.extra.addshortcut/2.5 } }
			else
				local num, dem = SMODS.get_probability_vars(card or self, 1, (card.ability or self.config).extra.maxchance)
				info_queue[#info_queue + 1] = {key = "toga_kartjokershortcut", set = 'Other', vars =
					{ num, dem, card.ability.extra.addshortcut, math.abs((1-card.ability.extra.shortcutfailmult)*100) }
				}
			end
		end
		return { vars = { card.ability.extra.Xmult_current } }
	end,
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersOther',
	pos = { x = 1, y = 0 },
	cost = 10,
	blueprint_compat = true,
	perishable_compat = false,
	demicolon_compat = true,
	calculate = function(self, card, context)
		if not card then return end
		if card.ability.extra.eliminated or card.debuff then return end
		
		if card.ability.extra.Xmult_current < 1 and not card.debuff then -- Catch.
			play_sound('tarot1')
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('toga_karteliminated'), colour = G.C.RED, sound = not silent and togabalatro.config.SFXWhenTriggered and 'toga_ssb64crowdohh'})
			card.ability.extra.Xmult_current = 0
			card.ability.extra.eliminated = true
			SMODS.debuff_card(card, true, card)
			return nil, true
		end
		
		if (context.buying_card or context.selling_card or context.playing_card_added or context.ending_shop or context.using_consumeable or context.open_booster or context.reroll_shop or context.ending_shop)
		and not context.individual and not context.blueprint then
			local valmodify = context.ending_shop and 8 or context.playing_card_added and context.cards and #context.cards or 1
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "Xmult_current",
				scalar_value = "add_shop",
				operation = function(ref_table, ref_value, initial, change)
					ref_table[ref_value] = initial + valmodify*change
				end,
			})
		elseif (context.skip_blind or context.skipping_booster) and not context.blueprint then
			if not SMODS.pseudorandom_probability(card, 'j_toga_jokersrb2kart', 1, card.ability.extra.maxchance, 'srb2kart') and G.GAME.selected_back.effect.center.key ~= 'b_toga_srb2kartdeck' then
				if not togabalatro.checkxmultsafe(card) then
					-- Eliminated!
					card.ability.extra.Xmult_current = 0
					card.ability.extra.eliminated = true
					SMODS.debuff_card(card, true, card)
					return {message = localize('toga_karteliminated'), colour = G.C.RED, sound = not silent and togabalatro.config.SFXWhenTriggered and 'toga_ssb64crowdohh'}
				else
					SMODS.scale_card(card, {
						ref_table = card.ability.extra,
						ref_value = "Xmult_current",
						scalar_value = "shortcutfailmult",
						operation = function(ref_table, ref_value, initial, change)
							ref_table[ref_value] = initial / change
						end,
						scaling_message = {message = localize('toga_kartouch'), colour = G.C.RED}
					})
					return nil, true
				end
			else
				local shortcutbonus = G.GAME.selected_back.effect.center.key == 'b_toga_srb2kartdeck' and card.ability.extra.addshortcut/2.5 or card.ability.extra.addshortcut
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "Xmult_current",
					scalar_value = "addshortcut",
					operation = function(ref_table, ref_value, initial, change)
						ref_table[ref_value] = initial + (G.GAME.selected_back.effect.center.key == 'b_toga_srb2kartdeck' and change/2.5 or change)
					end,
				})
				return nil, true
			end
		elseif context.joker_main or context.forcetrigger then
			if card.ability.extra.Xmult_current > 1 then return { x_mult = card.ability.extra.Xmult_current } end
		end
	end,
}

SMODS.Joker{
	key = 'asterism',
	config = { extra = { curmult = 0, bonusmult = 5 } },
	loc_vars = function(self, info_queue, card)
		card.ability.extra.curmult = (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.planet or 0) * card.ability.extra.bonusmult
		return { vars = { card.ability.extra.curmult > 0 and card.ability.extra.curmult or (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.planet or 0) * card.ability.extra.bonusmult, card.ability.extra.bonusmult } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersOther',
	pos = { x = 0, y = 1 },
	cost = 6,
	blueprint_compat = true,
	demicolon_compat = true,
	calculate = function(self, card, context)
		if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == 'Planet' then
			card.ability.extra.curmult = (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.planet or 0) * card.ability.extra.bonusmult
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_mult', vars = { card.ability.extra.curmult } } })
		end
		
		if (context.joker_main or context.forcetrigger) and card.ability.extra.curmult > 0 then return { mult = card.ability.extra.curmult } end
	end
}

SMODS.Joker{
	key = 'bonusducks',
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_bonushat
	end,
	rarity = 2,
	atlas = 'TOGAJokersOther',
	pos = { x = 1, y = 1 },
	cost = 7,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if context.blueprint then return end
		
		if context.cardarea == G.jokers and context.before then
			local faces = {}
			for k, v in ipairs(context.scoring_hand) do
				if v:is_face() then 
					faces[#faces+1] = v
					v:set_ability(G.P_CENTERS.m_bonus, nil, true)
					G.E_MANAGER:add_event(Event({
						func = function()
							v:juice_up()
							return true
						end
					})) 
				end
			end
			if #faces > 0 then
				return {
					message = localize('toga_bonusapply'),
					colour = G.C.CHIPS,
					card = card,
					sound = not silent and togabalatro.config.SFXWhenTriggered and 'toga_duck',
					pitch = not silent and togabalatro.config.SFXWhenTriggered and togabalatro.randompitch()
				}
			end
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenAdding and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_duck")
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenRemoving and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_kcud")
		end
	end,
}

-- Count steel card amount in full deck and round down the returned result.
-- ...and also prevent recursion. (thanks, nnmrts!)
local steelprocess = false
togabalatro.gettotalsteelcount = function(div)
	if steelprocess or div == 0 or div == nil then return 0 end
	local allsteel = 0
	steelprocess = true
	if G.playing_cards then
		for k, v in pairs(G.playing_cards) do
			if SMODS.has_enhancement(v, "m_steel") then allsteel = allsteel+1 end
		end
	end
	steelprocess = false
	return math.floor(allsteel/math.abs(div))
end

SMODS.Joker{
	key = 'mcanvil',
	config = { extra = { repetitions = 1, totalrepetitions = 0, steelneed = 4 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
		card.ability.extra.totalrepetitions = togabalatro.gettotalsteelcount(card.ability.extra.steelneed)*card.ability.extra.repetitions or 0
		card.ability.extra.steelneed = math.ceil(math.max(card.ability.extra.steelneed, 1))
		return { vars = { math.floor(card.ability.extra.repetitions), togabalatro.gettotalsteelcount(card.ability.extra.steelneed)*card.ability.extra.repetitions, card.ability.extra.steelneed } }
	end,
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersOther',
	pos = { x = 2, y = 1 },
	soul_pos = { x = 4, y = 1 },
	cost = 10,
	blueprint_compat = true,
	calculate = function(self, card, context)
		card.ability.extra.totalrepetitions = togabalatro.gettotalsteelcount(card.ability.extra.steelneed)*card.ability.extra.repetitions or 0
		if context.cardarea == G.play and context.repetition and not context.repetition_only and card.ability.extra.totalrepetitions >= 1 then
			return {
				message = localize('toga_anviltrigger'),
				repetitions = math.floor(card.ability.extra.totalrepetitions),
				card = context.blueprint_card or card,
				sound = not silent and togabalatro.config.SFXWhenTriggered and 'toga_anviluse',
				pitch = not silent and togabalatro.config.SFXWhenTriggered and togabalatro.randompitch()
			}
		end
	end
}

-- Get repeats, up to 65536. Will use Talisman functions if present.
togabalatro.cashpointmulitple = function(cashpoint)
	local getmultiples = to_big(G.GAME.dollars)/to_big(cashpoint)
	if Talisman and type(getmultiples) == 'table' then getmultiples = getmultiples:to_number() end
	return math.min(math.floor(getmultiples), 65535) + 1
end

SMODS.Joker{
	key = 'spacecadetpinball',
	config = { extra = { cashpoint = 20, alltrig = 1 } },
	loc_vars = function(self, info_queue, card)
		card.ability.extra.alltrig = togabalatro.cashpointmulitple(card.ability.extra.cashpoint) or 1
		return { vars = { card.ability.extra.cashpoint, math.max(card.ability.extra.alltrig-1, 1), SMODS.get_probability_vars(card or self, 1, 3) } }
	end,
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersOther',
	pos = { x = 0, y = 2 },
	cost = 15,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.before then card.ability.extra.alltrig = togabalatro.cashpointmulitple(card.ability.extra.cashpoint) end
		if context.spacecadetscore then return { spacecadet = card.ability.extra.alltrig, card = context.blueprint_card or card } end
		if context.after then card.ability.pinballscore = nil end
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenAdding and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_pinballstart")
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenRemoving and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_pinballloseball")
		end
	end
}

SMODS.Joker{
	key = 'heartyspades',
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersOtherDiffSize',
	pos = { x = 0, y = 0 },
	cost = 6,
	blueprint_compat = false,
	pixel_size = { w = 69, h = 74 }
}

SMODS.Joker{
	key = 'binaryjkr',
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersOther',
	pos = { x = 0, y = 3 },
	cost = 8,
	blueprint_compat = false
}

SMODS.Joker{
	key = 'hexadecimaljkr',
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersOther',
	pos = { x = 1, y = 3 },
	cost = 8,
	blueprint_compat = false
}

SMODS.Joker{
	key = 'cavingjkr',
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersOther',
	pos = { x = 1, y = 4 },
	cost = 6,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.after then
			local cardsplayed = context.full_hand or G.play and G.play.cards
			if #cardsplayed > 1 then
				for i = 1, #cardsplayed do
					if cardsplayed[i].config.center.key ~= 'm_stone' and not cardsplayed[i]:is_face() then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
							card:juice_up()
							cardsplayed[i]:set_ability('m_stone')
						return true end }))
						card_eval_status_text(cardsplayed[i], 'extra', nil, nil, nil, {message = localize('toga_stonefound'), sound = togabalatro.config.SFXWhenTriggered and 'toga_xporb'})
					end
				end
			end
		end
	end
}

SMODS.Joker{
	key = 'miningjkr',
	config = { extra = { } },
	loc_vars = function(self, info_queue, card)
		local minpool = togabalatro.oredict.minerals
		if minpool and #minpool > 0 and love.keyboard.isDown("lshift") then
			for k, v in pairs(minpool) do
				info_queue[#info_queue + 1] = G.P_CENTERS[v]
			end
		end
		return { key = love.keyboard.isDown("lshift") and self.key.."_showminerals" or self.key }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersOther',
	pos = { x = 2, y = 4 },
	cost = 4,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if context.first_hand_drawn then card.ability.extra.used = nil end
		if context.after and not context.blueprint and not context.retrigger_joker and not card.ability.extra.used then
			if #context.full_hand > 0 then
				for i = 1, #context.full_hand do
					local v = context.full_hand[i]
					if v.config.center.key == 'c_base' then
						local enhancement = SMODS.poll_enhancement({ guaranteed = true, options = togabalatro.oredict.minerals, type_key = 'modmineral' })
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
							card:juice_up()
							v:set_ability(G.P_CENTERS[enhancement])
						return true end }))
						card_eval_status_text(v, 'extra', nil, nil, nil, {message = localize('toga_stonefound'), sound = togabalatro.config.SFXWhenTriggered and 'toga_xporb'})
					end
				end
			end
			card.ability.extra.used = true
		end
	end
}

SMODS.Joker{
	key = 'y2ksticker',
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersOtherDiffSize',
	pos = { x = 2, y = 0 },
	cost = 7,
	blueprint_compat = false,
	pixel_size = { w = 69, h = 38 }
}

SMODS.Joker{
	key = 'pso2ironwill',
	config = { extra = { skillactive = true } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.skillactive, card.ability.extra.skillactive and localize('toga_pso2ironwillready') or localize('toga_pso2ironwillrecharge') } }
	end,
	unlocked = true,
	rarity = 4,
	atlas = 'TOGAJokersOther',
	pos = { x = 4, y = 2 },
	cost = 30,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if card.ability.extra.skillactive and context.end_of_round and context.game_over and not context.repetition and not context.individual and to_big(G.GAME.dollars) > to_big(0) then
			card.ability.extra.skillactive = false
			ease_dollars(to_big(-G.GAME.dollars), true)
			return {
				message = localize('toga_pso2ironwillproc'),
				saved = localize('toga_pso2ironwillsave'),
				colour = G.C.RED
			}
		end
		
		if context.end_of_round and not (context.individual or context.repetition or context.blueprint) and G.GAME.blind.boss and not card.ability.extra.skillactive then
			card.ability.extra.skillactive = true
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('toga_pso2ironwillready')})
		end
	end,
}

SMODS.Joker{
	key = 'jimboplus',
	config = { extra = { leech = 0.05 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.leech } }
	end,
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersOther',
	pos = { x = 1, y = 2 },
	cost = 8,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.before then
			togabalatro.loremipsum = true
			card.ability.extra.chips = card.ability.extra.chips or G.GAME.chips
			SMODS.calculate_effect({message = localize('toga_leech')}, context.blueprint_card or card)
			G.E_MANAGER:add_event(Event({
				trigger = 'ease',
				blockable = true,
				ref_table = G.GAME,
				ref_value = 'chips',
				ease_to = G.GAME.chips + math.floor(G.GAME.blind.chips*card.ability.extra.leech),
				delay = 0.8,
				func = (function(t) return math.floor(t) end)
			}))
			G.GAME.chips = G.GAME.chips + math.floor(G.GAME.blind.chips*card.ability.extra.leech)
		end
		if context.after and togabalatro.loremipsum then
			G.GAME.chips = card.ability.extra.chips
			card.ability.extra.chips = nil
			togabalatro.loremipsum = nil
		end
		if context.end_of_round then card.ability.extra.chips = nil end
	end
}

-- Check for Astronomica being present for setting score sound.
local AstronomicaEQScore = next(SMODS.find_mod('Astronomica')) and AST

SMODS.Joker{
	key = 'joker203',
	config = { extra = { blindred = 0.75 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.blindred } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 0, y = 6 },
	soul_pos = { x = 7, y = 6 },
	cost = 6,
	blueprint_compat = false,
	eternal_compat = false,
	demicolon_compat = true,
	calculate = function(self, card, context)
		if context.blueprint or context.retrigger_joker then return end
		if context.setting_blind or context.force_trigger then
			G.E_MANAGER:add_event(Event({func = function()
				G.GAME.blind.chips = math.floor(G.GAME.blind.chips*card.ability.extra.blindred)
				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
				G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
				G.HUD_blind:recalculate()
				G.hand_text_area.blind_chips:juice_up()
				card:juice_up()
			return true end }))
		end
		if context.before then togabalatro.oneshot = nil end
		if context.after and not togabalatro.oneshot then
			togabalatro.oneshot = true
			G.E_MANAGER:add_event(Event({func = function()
				if to_big(G.GAME.chips) < to_big(G.GAME.blind.chips) then
					if not (Talisman and Talisman.config_file.disable_anims) then
						SMODS.calculate_effect({ message = localize('k_reset'), sound = AstronomicaEQScore and 'ast_eqscore' or nil }, card)
						G.E_MANAGER:add_event(Event({
							trigger = 'ease',
							blockable = true,
							ref_table = G.GAME,
							ref_value = 'chips',
							ease_to = to_big(0),
							delay = 0.8,
							func = (function(t) return math.floor(t) end)
						}))
					end
					G.GAME.chips = to_big(0)
				end
			return true end }))
		end
	end
}

togabalatro.gethowmuch = function(div, inputxmult)
	local dol, dolbuffer = G.GAME.dollars, G.GAME.dollar_buffer and G.GAME.dollar_buffer > 0 and G.GAME.dollar_buffer or 0
	local amount = to_big(dol) + to_big(dolbuffer)
	return math.floor(to_big(amount)/to_big(div))
end

SMODS.Joker{
	key = 'speedsneakers',
	config = { extra = { xmultpart = 0.2, dollars = 5 } },
	loc_vars = function(self, info_queue, card)
		local total = togabalatro.gethowmuch(card.ability.extra.dollars, card.ability.extra.xmultpart)*card.ability.extra.xmultpart
		return { vars = { card.ability.extra.xmultpart, card.ability.extra.dollars, to_big(1)+to_big(total) > to_big(1) and to_big(1)+to_big(total) or to_big(1) } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersOtherDiffSize',
	pos = { x = 1, y = 0 },
	cost = 5,
	blueprint_compat = true,
	demicolon_compat = true,
	pixel_size = { w = 69, h = 74 },
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
			local total = togabalatro.gethowmuch(card.ability.extra.dollars, card.ability.extra.xmultpart)*card.ability.extra.xmultpart
			return { xmult = to_big(1)+to_big(total) > to_big(1) and to_number(to_big(1)+to_big(total)) or 1 }
		end
	end
}

SMODS.Joker{
	key = 'megasxlr',
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersOther',
	pos = { x = 0, y = 4 },
	cost = 8,
	blueprint_compat = false,
}

SMODS.Joker{
	key = 'jarate',
	config = { extra = { minicrit = 0.65, used = false }},
	loc_vars = function(self, info_queue, card)
		return { vars = { 100*card.ability.extra.minicrit - 100, card.ability.extra.used and localize('toga_jaraterecharging') or localize('toga_jarateready') } }
	end,
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersOtherDiffSize',
	pos = { x = 3, y = 0 },
	cost = 5,
	blueprint_compat = false,
	perishable_compat = false,
	eternal_compat = false,
	pixel_size = { w = 69, h = 73 },
	calculate = function(self, card, context)
		if context.blueprint then return end
		
		if context.setting_blind and G.GAME.blind.boss and not G.GAME.blind.jarated and not card.getting_sliced and not card.ability.extra.used then
			G.GAME.blind.jarated, card.ability.extra.used = true, true
			G.E_MANAGER:add_event(Event({func = function()
				G.GAME.blind.chips = math.floor(G.GAME.blind.chips*card.ability.extra.minicrit)
				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
				G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
				G.HUD_blind:recalculate()
				G.hand_text_area.blind_chips:juice_up()
				card:juice_up()
				if not silent and togabalatro.config.SFXWhenTriggered then play_sound('toga_jaratehit',1,0.3) end
			return true end }))
			return nil, true
		end
		
		if context.cardarea == G.jokers and context.before then
			local australia = 0
			for k, v in ipairs(context.scoring_hand) do
				if v.config.center ~= G.P_CENTERS.c_base or v.seal or v.edition then
					australia = australia + 1
					v.jarated = true
					v:set_edition()
					v:set_seal()
					v:set_ability(G.P_CENTERS.c_base, nil, true)
					G.E_MANAGER:add_event(Event({
						func = function()
							v:juice_up()
							v.jarated = nil
							return true
						end
					}))
				end
			end
			if australia > 0 then
				return {
					message = localize('toga_jarated'),
					colour = G.C.RED,
					card = card
				}
			end
		end
		
		if context.starting_shop then
			if card.ability.extra.used then
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('toga_jaraterestocked')})
				local eval = function() return not (G.GAME.blind and G.GAME.blind.boss and G.GAME.blind.jarated) end
				juice_card_until(card, eval, true)
			end
			card.ability.extra.used = false
		end
	end
}

SMODS.Joker{
	key = 'goldenwrench',
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersOtherDiffSize',
	pos = { x = 4, y = 0 },
	cost = 2,
	blueprint_compat = false,
	perishable_compat = false,
	eternal_compat = false,
	demicolon_compat = true,
	pixel_size = { w = 69, h = 87 },
	calculate = function(self, card, context)
		if context.blueprint or context.retrigger_joker then return end
		if (context.selling_self or context.selling_card) and context.card == card then card.ability.sold = true elseif context.forcetrigger then togabalatro.goldenwrench(card) end
	end,
}

SMODS.Joker{
	key = 'google',
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersOtherDiffSize',
	pos = { x = 7, y = 0 },
	cost = 6,
	blueprint_compat = true,
	perishable_compat = false,
	calculate = function(self, card, context)
		if context.setting_blind and not card.getting_sliced then
			local ecard = context.blueprint_card or card
			G.E_MANAGER:add_event(Event({
				func = function()
					local pcard = SMODS.create_card({ set = 'Playing Card', rank = '6' })
					pcard:start_materialize({G.C.SECONDARY_SET.Enhanced})
					G.play:emplace(pcard)
					SMODS.calculate_effect({message = localize('toga_pluscard'), colour = G.C.SECONDARY_SET.Enhanced}, ecard)
					G.E_MANAGER:add_event(Event({
						func = function()
							draw_card(G.play, G.deck, 90, 'up', nil)
							return true
					end}))
					table.insert(G.playing_cards, card)
					playing_card_joker_effects({pcard})
					return true
				end}))
			return nil, true
		end
	end,
	pixel_size = { w = 69, h = 69 }
}

SMODS.Joker{
	key = 'chrome',
	config = { extra = { xmult = 1.5, process = 'Chrome', totalxmult = 0 } },
	loc_vars = function(self, info_queue, card)
		local count = togabalatro.getprocessamount(card.ability.extra.process)
		local bonus, totalbonus = card.ability.extra.xmult, 0
		for i = 1, count do
			totalbonus = totalbonus + bonus
			bonus = bonus * 0.8
		end
		card.ability.extra.totalxmult = 1+totalbonus
		return { vars = { card.ability.extra.xmult, card.ability.extra.totalxmult, count, card.ability.extra.process } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersOtherDiffSize',
	pos = { x = 8, y = 0 },
	cost = 5,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.before then
			local count = togabalatro.getprocessamount(card.ability.extra.process)
			local bonus, totalbonus = card.ability.extra.xmult, 0
			for i = 1, count do
				totalbonus = totalbonus + bonus
				bonus = bonus * 0.8
			end
			card.ability.extra.totalxmult = 1+totalbonus
		end
		if context.joker_main then return { xmult = math.max(card.ability.extra.totalxmult, 1) } end
	end,
	pixel_size = { w = 69, h = 69 }
}

SMODS.Joker{
	key = 'firefox',
	config = { extra = { xchips = 1.5, process = 'Firefox', totalxchips = 0 } },
	loc_vars = function(self, info_queue, card)
		local count = togabalatro.getprocessamount(card.ability.extra.process)
		local bonus, totalbonus = card.ability.extra.xchips, 0
		for i = 1, count do
			totalbonus = totalbonus + bonus
			bonus = bonus * 0.8
		end
		card.ability.extra.totalxchips = 1+totalbonus
		return { vars = { card.ability.extra.xchips, card.ability.extra.totalxchips, count, card.ability.extra.process } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersOtherDiffSize',
	pos = { x = 9, y = 0 },
	cost = 5,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.before then
			local count = togabalatro.getprocessamount(card.ability.extra.process)
			local bonus, totalbonus = card.ability.extra.xchips, 0
			for i = 1, count do
				totalbonus = totalbonus + bonus
				bonus = bonus * 0.8
			end
			card.ability.extra.totalxchips = 1+totalbonus
		end
		if context.joker_main then return { xchips = math.max(card.ability.extra.totalxchips, 1) } end
	end,
	pixel_size = { w = 69, h = 67 }
}

local winupdateframes = {0, 1, 2, 3, 4, 5, 5, 4, 3, 2, 1}
SMODS.Joker{
	key = 'winupdate',
	unlocked = true,
	rarity = 4,
	atlas = 'TOGAJokersUpdate',
	pos = { x = 0, y = 0 },
	cost = 15,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.starting_shop then
			SMODS.calculate_effect({message = localize('toga_updated')}, context.blueprint_card or card)
			G.E_MANAGER:add_event(Event({
				func = function()
					SMODS.add_voucher_to_shop()
					SMODS.add_booster_to_shop()
					return true
				end
			}))
			return nil, true
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.toga_animated = true
	end,
	remove_from_deck = function(self, card, from_debuff)
		card.ability.toga_animated = nil
	end,
	update = function(self, card, context)
		if not (card.ability.toga_animated) then return end
		local timer = (G.TIMERS.REAL * 4)
		local frame_amount = #winupdateframes
		local wrapped_value = (math.floor(timer) - 1) % frame_amount + 1
		card.children.center:set_sprite_pos({x = winupdateframes[wrapped_value], y = 0})
	end,
}

togabalatro.calccopiesofself = function(jkey)
	local count = #SMODS.find_card(jkey)
	return count or 0
end

-- I am currently in a video game where I give XMult for every copy of me held.
SMODS.Joker{
	key = 'tomscott',
	config = { extra = { basexmult = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.basexmult, card.ability.extra.basexmult ^ togabalatro.calccopiesofself(card.config.center.key) } }
	end,
	unlocked = true,
	in_pool = function()
		return togabalatro.config.JokeJokersActive, { allow_duplicates = true } -- Should only spawn if allowed to via config!
	end,
	rarity = 2,
	atlas = 'TOGAJokersOther',
	pos = { x = 2, y = 2 },
	cost = 5,
	blueprint_compat = true,
	demicolon_compat = true,
	calculate = function(self, card, context)
		local curxmult = card.ability.extra.basexmult ^ togabalatro.calccopiesofself(card.config.center.key)
		if context.joker_main or context.forcetrigger then
			return { xmult = curxmult }
		end
	end,
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge("Joke (TOGA)", G.C.SECONDARY_SET.Tarot, G.C.WHITE, 1 )
	end
}

togabalatro.rosencheck = function(card)
	card.ability.extra.heldmoney = math.max(card.ability.extra.heldmoney, 10)
	card.ability.extra.heldxchip = math.max(card.ability.extra.heldxchip, 1.75)
	card.ability.extra.heldxmult = math.max(card.ability.extra.heldxmult, 2)
	card.ability.extra.heldechip = math.max(card.ability.extra.heldechip, 1.3)
	card.ability.extra.heldeechip = math.max(card.ability.extra.heldeechip, 1.1)
	card.ability.extra.heldeeechip = math.max(card.ability.extra.heldeeechip, 1.05)
	card.ability.extra.heldemult = math.max(card.ability.extra.heldemult, 1.2)
	card.ability.extra.heldeemult = math.max(card.ability.extra.heldeemult, 1.08)
	card.ability.extra.heldeeemult = math.max(card.ability.extra.heldeeemult, 1.04)
end

-- The plumtastic man himself. Joke Joker.
SMODS.Joker{
	key = 'michaelrosen',
	config = { extra = { heldmoney = 10, heldxchip = 1.75, heldxmult = 2, heldechip = 1.3, heldeechip = 1.1, heldeeechip = 1.05, heldemult = 1.2, heldeemult = 1.08, heldeeemult = 1.04, odds = 25 } },
	loc_vars = function(self, info_queue, card)
		togabalatro.rosencheck(card)
		if not card.debuff then
			info_queue[#info_queue + 1] = {key = "toga_roseneffects", set = 'Other', vars = { card.ability.extra.heldmoney, card.ability.extra.heldxchip, card.ability.extra.heldxmult }}
			if Talisman then
				info_queue[#info_queue + 1] = {key = "toga_rosentalismanextra", set = 'Other', vars = {
					card.ability.extra.heldechip, card.ability.extra.heldeechip, card.ability.extra.heldeeechip, card.ability.extra.heldemult, card.ability.extra.heldeemult, card.ability.extra.heldeeemult
				}}
			end
		end
		return { vars = { SMODS.get_probability_vars(card or self, 1, (card.ability or self.config).extra.odds) } }
	end,
	unlocked = true,
	in_pool = function()
		return togabalatro.config.JokeJokersActive -- Should only spawn if allowed to via config!
	end,
	rarity = 4,
	atlas = 'TOGAJokersOther',
	pos = { x = 2, y = 3 },
	soul_pos = { x = 4, y = 3 },
	cost = 33,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.cardarea == G.hand and context.other_card and not context.other_card.debuff and not context.repetition and not context.repetition_only and not context.end_of_round then
			-- Making sure we don't give less than default should we be Glitched or something else changes our values...
			togabalatro.rosencheck(card)
			-- Still, dear god...
			return {
				dollars = SMODS.pseudorandom_probability(card, "michaelrosen_money", 1, card.ability.extra.odds, "michaelrosen_money") and card.ability.extra.heldmoney or nil,
				x_chips = SMODS.pseudorandom_probability(card, "michaelrosen_xchips", 1, card.ability.extra.odds, "michaelrosen_xchips") and card.ability.extra.heldxchip > 1 and card.ability.extra.heldxchip or nil,
				xchip_message = {message = localize{ type = "variable", key = "a_xchips", vars = { card.ability.extra.heldxchip } }, colour = G.C.CHIPS, sound = "xchips"} or nil,
				x_mult = SMODS.pseudorandom_probability(card, "michaelrosen_xmult", 1, card.ability.extra.odds, "michaelrosen_xmult") and card.ability.extra.heldxmult > 1 and card.ability.extra.heldxmult or nil,
				e_chips = Talisman and SMODS.pseudorandom_probability(card, "michaelrosen_echips", 1, card.ability.extra.odds*10, "michaelrosen_echips") and card.ability.extra.heldechip > 1 and card.ability.extra.heldechip or nil,
				echip_message = Talisman and {message = localize{ type = "variable", key = "toga_Echip", vars = { card.ability.extra.heldechip } }, colour = G.C.DARK_EDITION, sound = "talisman_echip"} or nil,
				ee_chips = Talisman and SMODS.pseudorandom_probability(card, "michaelrosen_eechips", 1, card.ability.extra.odds*20, "michaelrosen_eechips") and card.ability.extra.heldeechip > 1 and card.ability.extra.heldeechip or nil,
				eechip_message = Talisman and {message = localize{ type = "variable", key = "toga_EEchip", vars = { card.ability.extra.heldeechip } }, colour = G.C.DARK_EDITION, sound = "talisman_eechip"} or nil,
				eee_chips = Talisman and SMODS.pseudorandom_probability(card, "michaelrosen_eeechips", 1, card.ability.extra.odds*40, "michaelrosen_eeechips") and card.ability.extra.heldeeechip > 1 and card.ability.extra.heldeeechip or nil,
				eeechip_message = Talisman and {message = localize{ type = "variable", key = "toga_EEEchip", vars = { card.ability.extra.heldeeechip } }, colour = G.C.DARK_EDITION, sound = "talisman_eeechip"} or nil,
				e_mult = Talisman and SMODS.pseudorandom_probability(card, "michaelrosen_emult", 1, card.ability.extra.odds*10, "michaelrosen_emult") and card.ability.extra.heldemult > 1 and card.ability.extra.heldemult or nil,
				emult_message = Talisman and {message = localize{ type = "variable", key = "toga_Emult", vars = { card.ability.extra.heldemult } }, colour = G.C.DARK_EDITION, sound = "talisman_echip"} or nil,
				ee_mult = Talisman and SMODS.pseudorandom_probability(card, "michaelrosen_eemult", 1, card.ability.extra.odds*20, "michaelrosen_eemult") and card.ability.extra.heldeemult > 1 and card.ability.extra.heldeemult or nil,
				eemult_message = Talisman and {message = localize{ type = "variable", key = "toga_EEmult", vars = { card.ability.extra.heldeemult } }, colour = G.C.DARK_EDITION, sound = "talisman_eemult"} or nil,
				eee_mult = Talisman and SMODS.pseudorandom_probability(card, "michaelrosen_eeemult", 1, card.ability.extra.odds*40, "michaelrosen_eeemult") and card.ability.extra.heldeeemult > 1 and card.ability.extra.heldeeemult or nil,
				eeemult_message = Talisman and {message = localize{ type = "variable", key = "toga_EEEmult", vars = { card.ability.extra.heldeeemult } }, colour = G.C.DARK_EDITION, sound = "talisman_eeemult"} or nil,
			}
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenAdding and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_rosenhello")
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if togabalatro.config.SFXWhenRemoving and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound(from_debuff and "toga_rosenah" or "toga_rosenbye")
		end
	end,
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge("Joke (TOGA)", G.C.SECONDARY_SET.Tarot, G.C.WHITE, 1 )
	end
}

SMODS.Joker{
	key = 'albanianvirus',
	loc_vars = function(self, info_queue, card)
		if card.ability.albavirusactive then
			info_queue[#info_queue + 1] = {key = "toga_albavirusinfo", set = 'Other'}
		end
	end,
	unlocked = true,
	rarity = 1,
	atlas = 'TOGAJokersMain',
	pos = { x = 7, y = 4 },
	soul_pos = { x = 7, y = 3 },
	no_collection = true,
	cost = 1,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if (context.selling_card and not context.selling_self) or context.remove_playing_cards then
			card.ability.albavirusactive = nil
		elseif context.selling_self and card.ability.albavirusactive then
			G.STATE = G.STATES.GAME_OVER
			if not G.GAME.won and not G.GAME.seeded and not G.GAME.challenge then 
				G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt = 0
			end
			G:save_settings()
			G.FILE_HANDLER.force = true
			G.STATE_COMPLETE = false
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.albavirusactive = true
	end,
	remove_from_deck = function(self, card, from_debuff)
		if card.ability.albavirusactive then
			G.STATE = G.STATES.GAME_OVER
			if not G.GAME.won and not G.GAME.seeded and not G.GAME.challenge then 
				G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt = 0
			end
			G:save_settings()
			G.FILE_HANDLER.force = true
			G.STATE_COMPLETE = false
		end
	end,
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge("Joke (TOGA)", G.C.SECONDARY_SET.Tarot, G.C.WHITE, 1 )
	end
}

-- Joke Joker. Originally had 'whatthefuck' as key.
if Talisman then
	SMODS.Joker{
		key = 'whatisthis',
		config = { extra = { part = 1.05 } },
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.extra.part } }
		end,
		unlocked = true,
		in_pool = function()
			return togabalatro.config.JokeJokersActive -- Should only spawn if allowed to via config!
		end,
		rarity = 4,
		atlas = 'TOGAJokersMain',
		pos = { x = 0, y = 2 },
		soul_pos = { x = 7, y = 1 },
		cost = 30,
		blueprint_compat = true,
		perishable_compat = false,
		calculate = function(self, card, context)
			if context.other_consumeable then
				local effects = {
					ee_mult = card.ability.extra.part > 1 and card.ability.extra.part or nil,
					eemult_message = card.ability.extra.part > 1 and {message = localize{ type = "variable", key = "toga_EEmult", vars = { card.ability.extra.part } }, colour = G.C.DARK_EDITION, sound = "talisman_eemult"} or nil,
				}
				local stacked, stackamount = togabalatro.stackingcompat(context.other_consumeable)
				if stacked and stackamount then
					return {
						func = function()
							for i = 1, stackamount do
								SMODS.calculate_individual_effect(effects, context.other_consumeable, 'ee_mult', effects.ee_mult, false)
							end
						end
					}
				else return effects end
			end
		end,
		add_to_deck = function(self, card, from_debuff)
			if G.STAGE == G.STAGES.RUN and not G.screenwipe then card.sell_cost = 0 end
			if not from_debuff and togabalatro.config.SFXWhenAdding and G.STAGE == G.STAGES.RUN and not G.screenwipe then
				play_sound("toga_ie31")
			end
		end,
		remove_from_deck = function(self, card, from_debuff)
			if G.STAGE == G.STAGES.RUN and not G.screenwipe then card.sell_cost = 0 end
			if not from_debuff and togabalatro.config.SFXWhenRemoving and G.STAGE == G.STAGES.RUN and not G.screenwipe then
				play_sound("toga_access97")
			end
		end,
		set_badges = function(self, card, badges)
			badges[#badges+1] = create_badge("Joke (TOGA)", G.C.SECONDARY_SET.Tarot, G.C.WHITE, 1 )
		end
	}
end

-- Joke Joker. Bit of an inside funny.
if Talisman then
	SMODS.Joker{
		key = 'quacksoft',
		config = { extra = { cardechip = 0.02 } },
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.extra.cardechip, G.playing_cards and 1 + (card.ability.extra.cardechip*#G.playing_cards) or 1 } }
		end,
		unlocked = true,
		in_pool = function()
			return togabalatro.config.JokeJokersActive -- Should only spawn if allowed to via config!
		end,
		rarity = 4,
		atlas = 'TOGAJokersOther',
		pos = { x = 2, y = 0 },
		soul_pos = { x = 4, y = 0 },
		cost = 32,
		blueprint_compat = true,
		perishable_compat = false,
		calculate = function(self, card, context)
			if context.joker_main then
				local echipcalc = (1 + (card.ability.extra.cardechip*#G.playing_cards))
				return {
					e_chips = echipcalc > 1 and echipcalc or nil,
					echip_message = echipcalc > 1 and {message = localize{ type = "variable", key = "toga_Echip", vars = { echipcalc } }, colour = G.C.DARK_EDITION, sound = "talisman_echip"} or nil
				}
			end
		end,
		add_to_deck = function(self, card, from_debuff)
			if G.STAGE == G.STAGES.RUN and not G.screenwipe then card.sell_cost = 0 end
			if not from_debuff and togabalatro.config.SFXWhenAdding and G.STAGE == G.STAGES.RUN and not G.screenwipe then
				play_sound("toga_duck")
			end
		end,
		remove_from_deck = function(self, card, from_debuff)
			if G.STAGE == G.STAGES.RUN and not G.screenwipe then card.sell_cost = 0 end
			if not from_debuff and togabalatro.config.SFXWhenRemoving and G.STAGE == G.STAGES.RUN and not G.screenwipe then
				play_sound("toga_kcud")
			end
		end,
		set_badges = function(self, card, badges)
			badges[#badges+1] = create_badge("Joke (TOGA)", G.C.SECONDARY_SET.Tarot, G.C.WHITE, 1 )
		end
	}
end