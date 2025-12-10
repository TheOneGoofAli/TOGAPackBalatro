sendInfoMessage("Loading Jokers...", "TOGAPack")

-- Check for 2 and King.
togabalatro.y2kcheck = function(hand)
	local twopresent, kingpresent = false, false
	local twos, kings = 0, 0
	hand = hand or {}
	for i = 1, #hand do
		if hand[i] then
			if hand[i]:get_id() == 2 then
				twopresent = true
				twos = twos + 1
			end
			if hand[i]:get_id() == 13 then
				kingpresent = true
				kings = kings + 1
			end
		end
	end
	return twopresent, kingpresent, twos, kings
end

local jokers = {}

table.insert(jokers, {
	key = 'y2kbug',
	config = { extra = { chips = 10, mult = 2 } },
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
			local twos, kings = togabalatro.y2kcheck(context.full_hand)
			if twos and kings then
				return { chips = card.ability.extra.chips, mult = card.ability.extra.mult }
			end
		end
	end,
})

table.insert(jokers, {
	key = 'controlpanel',
	config = { extra = { money = 1, totalmoney = 5 } },
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
	calc_dollar_bonus = function(self, card)
		if card.ability.extra.money > 0 then
			local jokerslotbonus, consslotbonus = 0, 0
			if G.jokers then jokerslotbonus = card.ability.extra.money*G.jokers.config.card_limit end
			if G.consumeables then consslotbonus = card.ability.extra.money*G.consumeables.config.card_limit end
			card.ability.extra.totalmoney = jokerslotbonus+consslotbonus
			return math.ceil(card.ability.extra.totalmoney)
		end
	end
})

table.insert(jokers, {
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
})

-- Add up our 4 values and divide by 4 for their average.
togabalatro.multaverage = function(card)
	local hleft, dleft, jslots, cslots = G.GAME.current_round.hands_left or 4, G.GAME.current_round.discards_left or 3, G.jokers and G.jokers.config.card_limit or 5, G.consumeables and G.consumeables.config.card_limit or 2
	card.ability.extra.baseXmult = math.max(card.ability.extra.baseXmult, 1)
	local averagecalc = (hleft+dleft+jslots+cslots)/8
	return math.max(card.ability.extra.baseXmult * averagecalc, card.ability.extra.baseXmult, 1)
end

-- Was previously Task Manager.
table.insert(jokers, {
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
})

table.insert(jokers, {
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
})

table.insert(jokers, {
	key = 'recyclebin',
	config = { extra = { xchip_increase = 0.05, xchip_mod = 1 } },
	loc_vars = function(self, info_queue, card)
		if to_number(card.ability.extra.xchip_mod) < 1 then card.ability.extra.xchip_mod = 1 end
		return { vars = { card.ability.extra.xchip_increase, card.ability.extra.xchip_mod, card.ability.extra.xchip_increase*3 } }
	end,
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersMain',
	pos = { x = 2, y = 2 },
	cost = 8,
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
			local removed = 0
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
					removed = removed + 1
				else
					-- Add 0.05.
					SMODS.scale_card(card, {
						ref_table = card.ability.extra,
						ref_value = "xchip_mod",
						scalar_value = "xchip_increase",
						no_message = true,
					})
					removed = removed + 1
				end
			end
			if removed > 0 then card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), sound = not silent and togabalatro.config.SFXWhenTriggered and "toga_recyclebinsfx"}) end
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
})

table.insert(jokers, {
	key = 'theinternet',
	config = { extra = { curchips = 0, bonuschips = 5 } },
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
			return { chips = card.ability.extra.curchips }
		end
	end,
})

table.insert(jokers, {
	key = 'computerlock',
	unlocked = true,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
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
	end,
	poweritem = true
})

table.insert(jokers, {
	key = 'virtualpc',
	config = { extra = { mult = 0, itemmult = 0.2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.itemmult } }
	end,
	unlocked = true,
	rarity = 1,
	atlas = 'TOGAJokersMain',
	pos = { x = 2, y = 3 },
	cost = 4,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.ending_shop and G.shop and not context.blueprint then
			local gain = togabalatro.shopitemcost()
			if gain and to_number(gain) > 0 then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "mult",
					scalar_value = "itemmult",
					operation = function(ref_table, ref_value, initial, change)
						ref_table[ref_value] = initial + change*gain
					end,
				})
				return nil, true
			end
		end
		
		if context.joker_main then return { mult = card.ability.extra.mult } end
	end
})

togabalatro.modifyhandchipsmult = function(card, hand, instant, context, bchips, bmult, lchips, lmult)
	bchips, bmult, lchips, lmult = bchips or 0, bmult or 0, lchips or 0, lmult or 0
	context = context or {}
	local cbase, clevel = (to_number(bchips) ~= 0 or to_number(bmult) ~= 0) and true or false, (to_number(lchips) ~= 0 or to_number(lmult) ~= 0) and true or false
	if not (cbase or clevel) then return end
	local prevals
	if SMODS.displaying_scoring and not (SMODS.displayed_hand == hand) then
		prevals = copy_table(G.GAME.current_round.current_hand)
		prevals.level = (G.GAME.hands[prevals.handname] or {}).level or ''
		prevals.chips = hand_chips
		prevals.mult = mult
	end
	if not (instant or Talisman and Talisman.config_file.disable_anims) then
		if cbase then
			update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize('toga_basecm').." "..localize(hand, 'poker_hands'), chips = G.GAME.hands[hand].s_chips, mult = G.GAME.hands[hand].s_mult, level=''})
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('tarot1')
				if card then card:juice_up(0.8, 0.5) end
				G.TAROT_INTERRUPT_PULSE = true
				return true end }))
			if bmult and to_number(bmult) ~= 0 then
				update_hand_text({delay = 0}, {mult = G.GAME.hands[hand].s_mult + bmult, StatusText = true})
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
					play_sound('tarot1')
					if card then card:juice_up(0.8, 0.5) end
				return true end }))
			end
			if bchips and to_number(bchips) ~= 0 then
				update_hand_text({delay = 0}, {chips = G.GAME.hands[hand].s_chips + bchips, StatusText = true})
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
					play_sound('tarot1')
					if card then card:juice_up(0.8, 0.5) end
				return true end }))
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				G.TAROT_INTERRUPT_PULSE = nil
			return true end }))
			delay(1.3)
		end
		if clevel then
			update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize('toga_perlevel').." "..localize(hand, 'poker_hands'), chips = G.GAME.hands[hand].l_chips, mult = G.GAME.hands[hand].l_mult, level=''})
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('tarot1')
				if card then card:juice_up(0.8, 0.5) end
				G.TAROT_INTERRUPT_PULSE = true
				return true end }))
			if lmult and to_number(lmult) ~= 0 then
				update_hand_text({delay = 0}, {mult = G.GAME.hands[hand].l_mult + lmult, StatusText = true})
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
					play_sound('tarot1')
					if card then card:juice_up(0.8, 0.5) end
				return true end }))
			end
			if lchips and to_number(lchips) ~= 0 then
				update_hand_text({delay = 0}, {chips = G.GAME.hands[hand].l_chips + lchips, StatusText = true})
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
					play_sound('tarot1')
					if card then card:juice_up(0.8, 0.5) end
				return true end }))
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				G.TAROT_INTERRUPT_PULSE = nil
			return true end }))
			delay(1.3)
		end
		update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.5}, prevals or {mult = 0, chips = 0, handname = '', level = ''})
	else
		update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.5}, prevals or {mult = 0, chips = 0, handname = '', level = ''})
	end
	
	if Talisman and Talisman.config_file.disable_anims then
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function()
			play_sound('tarot1')
		return true end }))
	end
	
	if togabalatro.config.DoMoreLogging then sendInfoMessage(localize('toga_perlevel').." "..localize(hand, 'poker_hands'), "TOGAPack") end
	G.GAME.hands[hand].s_chips = to_big(G.GAME.hands[hand].s_chips) + to_big(bchips)
	G.GAME.hands[hand].s_mult = to_big(G.GAME.hands[hand].s_mult) + to_big(bmult)
	G.GAME.hands[hand].l_chips = to_big(G.GAME.hands[hand].l_chips) + to_big(lchips)
	G.GAME.hands[hand].l_mult = to_big(G.GAME.hands[hand].l_mult) + to_big(lmult)
	G.GAME.hands[hand].mult = math.max(to_big(G.GAME.hands[hand].s_mult) + to_big(G.GAME.hands[hand].l_mult)*(to_big(G.GAME.hands[hand].level) - to_big(1)), to_big(1))
	G.GAME.hands[hand].chips = math.max(to_big(G.GAME.hands[hand].s_chips) + to_big(G.GAME.hands[hand].l_chips)*(to_big(G.GAME.hands[hand].level) - to_big(1)), to_big(0))
end

table.insert(jokers, {
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
					togabalatro.modifyhandchipsmult(curcard, hand, false, cxt, nil, nil, G.GAME.hands[hand].s_chips/card.ability.extra.phchips, G.GAME.hands[hand].s_mult/card.ability.extra.phmult )
				end
			}
		end
	end
})

table.insert(jokers, {
	key = 'systemrestore',
	unlocked = true,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	rarity = 3,
	atlas = 'TOGAJokersMain',
	pos = { x = 0, y = 3 },
	cost = 8,
	blueprint_compat = true,
	perishable_compat = false,
	calculate = function(self, card, context)
		if context.remove_playing_cards and context.removed[1] then
			local addedcards = {}
			local rndcard = pseudorandom_element(context.removed, pseudoseed('milleniumchildbrokethepc')) or context.removed[1]
			for i = 1, #context.removed do
				local _card = copy_card(rndcard, nil, nil, G.playing_card)
				if togabalatro.config.DoMoreLogging and _card and _card.base and _card.base.id then sendInfoMessage(_card.base.id, "TOGAPack") end
				_card:add_to_deck()
				G.deck.config.card_limit = G.deck.config.card_limit + 1
				table.insert(G.playing_cards, _card)
				G.deck:emplace(_card)
				table.insert(addedcards, _card)
			end
			if addedcards[1] then playing_card_joker_effects(addedcards) end
			return { message = localize('toga_systemrestore1') }
		end
	end,
	poweritem = true
})

table.insert(jokers, {
	key = 'skype',
	config = { extra = { permodxmult = 2 } },
	loc_vars = function(self, info_queue, card)
		card.ability.extra.permodxmult = math.max(card.ability.extra.permodxmult, 1)
		local mods, modcount = togabalatro.checkownedmoditems()
		return { key = modcount > 1 and self.key.."_moremod" or self.key, vars = { card.ability.extra.permodxmult, card.ability.extra.permodxmult*modcount, modcount } }
	end,
	unlocked = true,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
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
	end,
	poweritem = true
})

local msncount = false

table.insert(jokers, {
	key = 'msn',
	config = { extra = { perenhxmult = 1.25 } },
	loc_vars = function(self, info_queue, card)
		local enh, enhcount = {}, 0
		if G.playing_cards then
			for i = 1, #G.playing_cards do
				if not msncount then
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
		end
		return { vars = { card.ability.extra.perenhxmult, card.ability.extra.perenhxmult^enhcount } }
	end,
	unlocked = true,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	rarity = 3,
	atlas = 'TOGAJokersMain',
	pos = { x = 5, y = 0 },
	cost = 10,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.joker_main then
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
	end,
	poweritem = true
})

-- Random SFX.
togabalatro.plus95rndsfx = function()
	return 'toga_win95pluscmd'..math.random(1, 13)
end

table.insert(jokers, {
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
	perishable_compat = false,
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
					G.E_MANAGER:add_event(Event({delay = 0, func = function()
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
})

table.insert(jokers, {
	key = 'bonzibuddy',
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 4, y = 0 },
	cost = 6,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if context.bonzi_modify_rank and not context.blueprint and not context.retrigger_joker then return { amount = -1, card = card } end
	end,
})

table.insert(jokers, {
	key = 'netscapenavigator',
	config = { extra = { holoxmult = 1.5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.holoxmult } }
	end,
	unlocked = true,
	in_pool = function()
		if G.playing_cards then
			for i = 1, #G.playing_cards do
				if G.playing_cards[i] and G.playing_cards[i].edition and G.playing_cards[i].edition.holo then return true end
			end
		end
	end,
	rarity = 3,
	atlas = 'TOGAJokersMain',
	pos = { x = 4, y = 1 },
	cost = 8,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.hand and context.other_card and context.other_card.edition and context.other_card.edition.holo
		and not context.other_card.debuff and not context.repetition and not context.repetition_only and not context.end_of_round then
			return { xmult = card.ability.extra.holoxmult, message_card = context.other_card }
		end
	end,
})

table.insert(jokers, {
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
})

table.insert(jokers, {
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
})

table.insert(jokers, {
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
})

table.insert(jokers, {
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
})

table.insert(jokers, {
	key = 'msagent',
	config = { extra = { unbalance = 1.25 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { (card.ability.extra.unbalance or 1)*100 } }
	end,
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersMain',
	pos = { x = 5, y = 1 },
	cost = 8,
	blueprint_compat = true,
	demicolon_compat = true,
	calculate = function(self, card, context)
		if context.initial_scoring_step or context.force_trigger then
			local chipsmulttogether = (mult + hand_chips) * (card.ability.extra.unbalance or 1)
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
			SMODS.calculate_effect({message = localize('toga_unbalanced'), colour = {0.8, 0.45, 0.85, 1}}, context.blueprint_card or card)
			delay(0.6)
		end
	end,
})

table.insert(jokers, {
	key = 'drwatson',
	config = { extra = { curxmult = 0, trigxmult = 0.25 } },
	loc_vars = function(self, info_queue, card)
		card.ability.extra.trigxmult = math.max(card.ability.extra.trigxmult, 0.25)
		return { vars = { 1+card.ability.extra.curxmult, card.ability.extra.trigxmult } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 5, y = 2 },
	cost = 5,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.debuffed_hand and not context.blueprint then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "curxmult",
				scalar_value = "trigxmult",
			})
			return nil, true
		end
		
		if context.joker_main then
			if G.GAME.blind.triggered and not context.blueprint then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "curxmult",
					scalar_value = "trigxmult",
				})
			end
			return { xmult = 1+card.ability.extra.curxmult }
		end
	end,
})

table.insert(jokers, {
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
		return next(togabalatro.externalfontsloaded) and togabalatro.getexternalfontcount() > 0 and togabalatro.config.ShowPower -- Should only spawn if fonts are detected in the first place.
	end,
	rarity = 3,
	atlas = 'TOGAJokersMain',
	pos = { x = 5, y = 3 },
	no_collection = true,
	cost = 8,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if next(togabalatro.externalfontsloaded) and context.joker_main then
			local fontamount = togabalatro.getexternalfontcount()
			if fontamount > 0 then return { xmult = math.max(card.ability.extra.perfontxmult, 1)*fontamount } end
		end
	end,
	poweritem = true,
	remainhidden = true
})

table.insert(jokers, {
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
	blueprint_compat = true,
	eternal_compat = false,
	calculate = function(self, card, context)
		if context.joker_main then return { xmult = math.max(card.ability.extra.xmult, 1) } end
		if context and next(context) and not context.blueprint and math.random(1, 20) == 5 then togabalatro.performpseudolag() end
	end,
	add_to_deck = function(self, card, from_debuff)
		togabalatro.pseudolag = nil
	end,
	remove_from_deck = function(self, card, from_debuff)
		togabalatro.pseudolag = nil
	end,
})

table.insert(jokers, {
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
	perishable_compat = false,
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
})

table.insert(jokers, {
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
		if context.vs_modify_rank and not context.retrigger_joker then return { amount = math.floor(card.ability.extra.mrank), card = context.blueprint_card or card } end
	end,
})

table.insert(jokers, {
	key = 'cpu',
	config = { extra = { coremult = 1 } },
	loc_vars = function(self, info_queue, card)
		local cores = togabalatro.curcpucount or 1
		return { vars = { card.ability.extra.coremult, cores, cores*card.ability.extra.coremult } }
	end,
	unlocked = true,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	rarity = 1,
	atlas = 'TOGAJokersMain',
	pos = { x = 1, y = 5 },
	cost = 5,
	blueprint_compat = true,
	demicolon_compat = true,
	calculate = function(self, card, context)
		if context.joker_main or context.force_trigger then return { mult = (togabalatro.curcpucount or 1)*card.ability.extra.coremult } end
	end,
	poweritem = true
})

table.insert(jokers, {
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
})

table.insert(jokers, {
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
})

table.insert(jokers, {
	key = 'desktop',
	config = { extra = { curxmult = 0, tagxmult = 0.25 } },
	loc_vars = function(self, info_queue, card)
		card.ability.extra.tagxmult = math.max(card.ability.extra.tagxmult, 0.25)
		return { vars = { 1+card.ability.extra.curxmult, card.ability.extra.tagxmult } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 3, y = 6 },
	cost = 6,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.tag_triggered and not context.blueprint then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "curxmult",
				scalar_value = "tagxmult",
			})
			return nil, true
		end
		
		if context.joker_main then return { xmult = 1+card.ability.extra.curxmult } end
	end,
})

table.insert(jokers, {
	key = 'mswallet',
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersMain',
	pos = { x = 4, y = 6 },
	cost = 8,
	poweritem = true,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
})

table.insert(jokers, {
	key = 'nonebattery',
	config = { extra = { xmult = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
	end,
	unlocked = true,
	in_pool = function()
		return togabalatro.config.JokeJokersActive
	end,
	rarity = 1,
	atlas = 'TOGAJokersMain',
	pos = { x = 5, y = 6 },
	cost = 4,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.joker_main then
			local state = love.system.getPowerInfo()
			if state == 'nobattery' then return { xmult = card.ability.extra.xmult } end
		end
	end,
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge("Joke (TOGA)", G.C.SECONDARY_SET.Tarot, G.C.WHITE, 1 )
	end,
	jokeitem = true,
})

table.insert(jokers, {
	key = 'dragndrop',
	config = { extra = { chips = 0, cap = 0, antecaplift = 75 } },
	loc_vars = function(self, info_queue, card)
		local ante, filesize = math.abs(to_number(G.GAME.round_resets.ante)) or 1, togabalatro.lastfilesize()
		card.ability.extra.chips = math.min(filesize/1048576, card.ability.extra.cap+card.ability.extra.antecaplift*ante)
		return { vars = { card.ability.extra.chips, filesize/1048576, card.ability.extra.cap+card.ability.extra.antecaplift*ante, card.ability.extra.antecaplift } } -- 1 MB, up to 500 MB
	end,
	unlocked = true,
	in_pool = function()
		return togabalatro.config.JokeJokersActive
	end,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 0, y = 7 },
	cost = 5,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.joker_main then
			local ante, filesize = math.abs(to_number(G.GAME.round_resets.ante)) or 1, togabalatro.lastfilesize()
			card.ability.extra.chips = math.min(filesize/1048576, card.ability.extra.cap+card.ability.extra.antecaplift*ante)
			return { chips = card.ability.extra.chips }
		end
	end,
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge("Joke (TOGA)", G.C.SECONDARY_SET.Tarot, G.C.WHITE, 1 )
	end,
	jokeitem = true,
})

table.insert(jokers, {
	key = 'repairdisk',
	config = { extra = { curxmult = 0, dxmult = 0.02 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { 1+card.ability.extra.curxmult, card.ability.extra.dxmult } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 1, y = 7 },
	cost = 6,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.money_altered and context.amount and to_number(context.amount) < to_number(0) and not context.blueprint then
			local mchange = math.abs(context.amount)
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "curxmult",
				scalar_value = "dxmult",
				operation = function(ref_table, ref_value, initial, change)
					ref_table[ref_value] = initial + change*mchange
				end,
			})
			return nil, true
		end
		
		if context.joker_main then return { xmult = 1+card.ability.extra.curxmult } end
	end,
})

table.insert(jokers, {
	key = 'merlin',
	config = { extra = { curxmult = 0, txmult = 0.08 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { 1+card.ability.extra.curxmult, card.ability.extra.txmult } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 2, y = 7 },
	cost = 6,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.using_consumeable and context.consumeable and context.consumeable.ability.set == 'Tarot' and not context.blueprint then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "curxmult",
				scalar_value = "txmult",
			})
			return nil, true
		end
		
		if context.joker_main then return { xmult = 1+card.ability.extra.curxmult } end
	end,
})

table.insert(jokers, {
	key = 'briefcase',
	config = { extra = { curhchips = 10, ahchips = 5 } },
	loc_vars = function(self, info_queue, card)
		return { key = togabalatro.stjcheck() and self.key.."_stj" or self.key, vars = { card.ability.extra.curhchips, card.ability.extra.ahchips } }
	end,
	unlocked = true,
	rarity = 1,
	atlas = 'TOGAJokersMain',
	pos = { x = 3, y = 7 },
	cost = 4,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.ante_change and not context.blueprint then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "curhchips",
				scalar_value = "ahchips",
			})
			return nil, true
		end
		
		if context.cardarea == G.hand and context.other_card and not context.end_of_round and not context.repetition and not context.repetition_only and not context.other_card.debuff then
			return { chips = card.ability.extra.curhchips }
		end
	end,
})

table.insert(jokers, {
	key = 'vga',
	config = { extra = { xmult = 1.33 } },
	loc_vars = function(self, info_queue, card)
		local width, height = love.window.getMode()
		local is43 = togabalatro.check43(width, height)
		return { vars = { card.ability.extra.xmult, is43, width, height, colours = { is43 and G.C.DARK_EDITION or G.C.UI.TEXT_INACTIVE } } }
	end,
	unlocked = true,
	in_pool = function()
		return togabalatro.config.JokeJokersActive
	end,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 4, y = 7 },
	cost = 6,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.other_consumeable then
			local width, height = love.window.getMode()
			if togabalatro.check43(width, height) then
				local stacked, stackamount = togabalatro.stackingcompat(context.other_consumeable)
				if stacked and stackamount then
					local results = {}
					for i = 1, stackamount do
						table.insert(results, { xmult = card.ability.extra.xmult, card = context.blueprint_card or card, message_card = context.other_consumeable })
					end
					return SMODS.merge_effects(results)
				else return { xmult = card.ability.extra.xmult, card = context.blueprint_card or card, message_card = context.other_consumeable } end
			end
		end
	end,
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge("Joke (TOGA)", G.C.SECONDARY_SET.Tarot, G.C.WHITE, 1 )
	end,
	jokeitem = true,
})

table.insert(jokers, {
	key = 'mshome',
	loc_vars = function(self, info_queue, card)
		local curscale = G.GAME and G.GAME.modifiers.scaling or 1
		return { vars = { curscale, 2*curscale } }
	end,
	unlocked = true,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 5, y = 7 },
	cost = 6,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.joker_main then return { xmult = G.GAME and G.GAME.modifiers.scaling and 2*G.GAME.modifiers.scaling or 2 } end
	end,
	poweritem = true
})

table.insert(jokers, {
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
	perishable_compat = false,
})

table.insert(jokers, {
	key = 'monitor',
	loc_vars = function(self, info_queue, card)
		return { vars = { love.window.getDisplayCount() } }
	end,
	unlocked = true,
	in_pool = function()
		return togabalatro.config.JokeJokersActive
	end,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 2, y = 8 },
	cost = 6,
	blueprint_compat = false,
	perishable_compat = false,
	calculate = function(self, card, context)
		if context.mod_probability and not context.blueprint and love.window.getDisplayCount() > 0 then
			return { numerator = context.numerator + love.window.getDisplayCount() }
		end
	end,
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge("Joke (TOGA)", G.C.SECONDARY_SET.Tarot, G.C.WHITE, 1 )
	end,
	jokeitem = true,
})

table.insert(jokers, {
	key = 'notsosmileyface',
	config = { extra = { xmult = 2 } },
	loc_vars = function(self, info_queue, card)
		return { key = card.ability.thesmile and math.random(1,4) == 1 and not togabalatro.stjcheck() and self.key.."_full" or self.key, vars = { card.ability.extra.xmult } }
	end,
	unlocked = true,
	in_pool = function()
		return togabalatro.config.JokeJokersActive
	end,
	rarity = 1,
	atlas = 'TOGAJokersMain',
	pos = { x = 3, y = 8 },
	cost = 4,
	blueprint_compat = true,
	perishable_compat = false,
	calculate = function(self, card, context)
		if context.joker_main then return { xmult = card.ability.extra.xmult } end
	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.thesmile = true
	end,
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge("Joke (TOGA)", G.C.SECONDARY_SET.Tarot, G.C.WHITE, 1 )
	end,
	jokeitem = true,
})

table.insert(jokers, {
	key = 'wscript',
	config = { extra = { blindred = 0.75, odds = 4 } },
	loc_vars = function(self, info_queue, card)
		card.ability.extra.blindred = math.min(card.ability.extra.blindred, 1)
		return { vars = { card.ability.extra.blindred, SMODS.get_probability_vars(card or self, 1, (card.ability or self.config).extra.odds) } }
	end,
	unlocked = true,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	rarity = 1,
	atlas = 'TOGAJokersMain',
	pos = { x = 4, y = 8 },
	cost = 4,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if context.setting_blind and SMODS.pseudorandom_probability(card, 'toga_wscript', 1, card.ability.extra.odds, 'wscript') and not context.blueprint and not context.retrigger_joker then
			card.ability.extra.blindred = math.min(card.ability.extra.blindred, 1)
			if to_number(card.ability.extra.blindred) < 1 then
				if Talisman and Talisman.config_file.disable_anims then
					G.GAME.blind.chips = math.floor(G.GAME.blind.chips*card.ability.extra.blindred)
					G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
					G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
					G.HUD_blind:recalculate()
					return nil, true
				else
					G.E_MANAGER:add_event(Event({func = function()
						G.GAME.blind.chips = math.floor(G.GAME.blind.chips*card.ability.extra.blindred)
						G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
						G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
						G.HUD_blind:recalculate()
						G.hand_text_area.blind_chips:juice_up()
						card:juice_up()
					return true end }))
					return nil, true
				end
			end
		end
	end,
	poweritem = true
})

table.insert(jokers, {
	key = 'gamecontrollers',
	config = { extra = { xmult = 1.5 } },
	loc_vars = function(self, info_queue, card)
		local gc = love.joystick.getJoystickCount()
		return { vars = { card.ability.extra.xmult, gc, gc > 0 and card.ability.extra.xmult*gc or 1 } }
	end,
	unlocked = true,
	rarity = 1,
	atlas = 'TOGAJokersMain',
	pos = { x = 0, y = 8 },
	cost = 4,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.joker_main then
			local gc = love.joystick.getJoystickCount()
			return gc > 0 and { xmult = card.ability.extra.xmult*gc }
		end
	end,
})

table.insert(jokers, {
	key = 'wincatalog',
	config = { extra = { mult = 4 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	unlocked = true,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 1, y = 8 },
	cost = 6,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.initial_scoring_step then
			local commons = {}
			for k, v in ipairs((G.jokers or {}).cards) do
				if v.config.center.rarity == 1 then table.insert(commons, { mult = card.ability.extra.mult, card = context.blueprint_card or card, message_card = v }) end
			end
			if next(commons) then return SMODS.merge_effects(commons) end
		end
	end,
	poweritem = true
})

table.insert(jokers, {
	key = 'hammer',
	unlocked = true,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	rarity = 3,
	atlas = 'TOGAJokersMain',
	pos = { x = 5, y = 5 },
	cost = 8,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.hammerscore and not context.retrigger_joker then return { card = context.blueprint_card or card } end
	end,
	poweritem = true
})

function togabalatro.randomruntext()
	local stringtable = { localize('toga_jimbo95txt1'), localize('k_again_ex'), localize('toga_jimbo95txt2'), localize('toga_jimbo95txt3'), localize('toga_jimbo95txt4') }
	return stringtable[math.random(#stringtable)]
end

table.insert(jokers, {
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
				message = togabalatro.randomruntext() or localize('k_again_ex'),
				repetitions = math.floor(card.ability.extra.retriggers),
				card = context.blueprint_card or card,
			}
		end
	end
})

-- Windows OS Jokers moved to separate file...
local winosj = assert(SMODS.load_file("items/jokers/winos.lua"))()

-- ...with non-Windows OS Jokers also being from their own files.
local macosj = assert(SMODS.load_file("items/jokers/macos.lua"))()
local linuxj = assert(SMODS.load_file("items/jokers/linuxos.lua"))()

local extjokers = { winosj, macosj, linuxj }
for i, v in ipairs(extjokers) do
	if type(v) == 'table' then
		for k, j in ipairs(v) do
			table.insert(jokers, j)
		end
	end
end

table.insert(jokers, {
	key = 'clippit',
	config = { extra = { rescores = 1 } },
	loc_vars = function(self, info_queue, card)
		if self.discovered then
			info_queue[#info_queue + 1] = {key = "toga_clippyorigin", set = 'Other'}
		end
		return { key = togabalatro.stjcheck() and self.key.."_stj" or self.key, vars = { math.floor(card.ability.extra.rescores) } }
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
			return { rescores = card.ability.extra.rescores, card = context.blueprint_card or card }
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
})

table.insert(jokers, {
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
})

table.insert(jokers, {
	key = 'solitairejoker',
	loc_vars = function(self, info_queue, card)
		local togasolitaire = G.GAME.current_round.togabalatro and G.GAME.current_round.togabalatro.solitaire or {}
		return { vars = { localize(togasolitaire.rank or "Ace", 'ranks') } }
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
})

togabalatro.checkxmultsafe = function(card)
	local xmultcheck = card.ability.extra.Xmult_current / card.ability.extra.shortcutfailmult
	if xmultcheck < 1 then return false else return true end
end

table.insert(jokers, {
	key = 'jokersrb2kart',
	config = { extra = { Xmult_current = 1, add_shop = 0.05, addshortcut = 0.75, shortcutfailmult = 1.33, maxchance = 3} },
	loc_vars = function(self, info_queue, card)
		if self.discovered then
			if togabalatro.config.UseNerfed then
				if G.GAME.selected_back.effect.center.key == 'b_toga_srb2kartdeck' then info_queue[#info_queue + 1] = {key = "toga_kartjokershortcutspecial", set = 'Other', vars = { card.ability.extra.addshortcut/2.5 } } end
				return { key = self.key.."_lite", vars = { card.ability.extra.Xmult_current, card.ability.extra.add_shop*8 } }
			else
				info_queue[#info_queue + 1] = {key = "toga_kartjokerlist", set = 'Other', vars = { card.ability.extra.add_shop, card.ability.extra.add_shop*8 } }
				if G.GAME.selected_back.effect.center.key == 'b_toga_srb2kartdeck' then info_queue[#info_queue + 1] = {key = "toga_kartjokershortcutspecial", set = 'Other', vars = { card.ability.extra.addshortcut/2.5 } }
				else
					local num, dem = SMODS.get_probability_vars(card or self, 1, (card.ability or self.config).extra.maxchance)
					info_queue[#info_queue + 1] = {key = "toga_kartjokershortcut", set = 'Other', vars =
						{ num, dem, card.ability.extra.addshortcut, math.abs((1-card.ability.extra.shortcutfailmult)*100) }
					}
				end
			end
		end
		return { vars = { card.ability.extra.Xmult_current } }
	end,
	unlocked = true,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
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
		end
		
		if (context.buying_card or context.selling_card or context.playing_card_added or context.ending_shop or context.using_consumeable or context.open_booster or context.reroll_shop)
		and not context.individual and not context.blueprint and not togabalatro.config.UseNerfed then
			local valmodify = context.ending_shop and 8 or context.playing_card_added and context.cards and #context.cards or 1
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "Xmult_current",
				scalar_value = "add_shop",
				operation = function(ref_table, ref_value, initial, change)
					ref_table[ref_value] = initial + valmodify*change
				end,
			})
			return nil, true
		end
		
		if (context.starting_shop or context.ending_shop) and togabalatro.config.UseNerfed then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "Xmult_current",
				scalar_value = "add_shop",
				operation = function(ref_table, ref_value, initial, change)
					ref_table[ref_value] = initial + 8*change
				end,
			})
			return nil, true
		end
		
		if (context.skip_blind or context.skipping_booster) and not context.blueprint then
			if not togabalatro.config.UseNerfed then
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
			else
				if G.GAME.selected_back.effect.center.key == 'b_toga_srb2kartdeck' then
					SMODS.scale_card(card, {
						ref_table = card.ability.extra,
						ref_value = "Xmult_current",
						scalar_value = "addshortcut",
						operation = function(ref_table, ref_value, initial, change)
							ref_table[ref_value] = initial + change/2.5
						end,
					})
					return nil, true
				end
			end
		end
		
		if context.joker_main or context.forcetrigger then
			if card.ability.extra.Xmult_current > 1 then return { x_mult = card.ability.extra.Xmult_current } end
		end
	end,
	set_badges = function(self, card, badges)
		if togabalatro.config.UseNerfed then badges[#badges+1] = create_badge(localize('toga_nerfedver'), G.C.UI.TEXT_DARK, G.C.WHITE, 1 ) end
	end,
	poweritem = true
})

table.insert(jokers, {
	key = 'asterism',
	config = { extra = { curmult = 0, bonusmult = 2 } },
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
})

table.insert(jokers, {
	key = 'bonusducks',
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
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
})

table.insert(jokers, {
	key = 'mcanvil',
	config = { extra = { curxmult = 0, steelxmult = 0.5 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
		info_queue[#info_queue + 1] = G.P_CENTERS.m_toga_iron
		card.ability.extra.steelxmult = math.max(card.ability.extra.steelxmult, 0.5)
		return { key = togabalatro.stjcheck() and self.key.."_stj" or self.key, vars = { 1+card.ability.extra.curxmult, card.ability.extra.steelxmult } }
	end,
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersOther',
	pos = { x = 2, y = 1 },
	soul_pos = { x = 4, y = 1 },
	cost = 8,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			if context.scoring_hand and #context.scoring_hand > 0 then
				local steel = 0
				for i = 1, #context.scoring_hand do
					local v = context.scoring_hand[i]
					if v.config.center.key == 'm_steel' and not v.debuff and not v.anviled then
						steel = steel + 1
						v.anviled = true
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
							card:juice_up()
							v.anviled = nil
							v:set_ability(G.P_CENTERS.m_toga_iron)
						return true end }))
						card_eval_status_text(v, 'extra', nil, nil, nil, {message = localize('toga_anviltrigger'), sound = not silent and togabalatro.config.SFXWhenTriggered and 'toga_anviluse', pitch = not silent and togabalatro.config.SFXWhenTriggered and togabalatro.randompitch()})
					end
				end
				if steel > 0 then
					SMODS.scale_card(card, {
						ref_table = card.ability.extra,
						ref_value = "curxmult",
						scalar_value = "steelxmult",
						operation = function(ref_table, ref_value, initial, change)
							ref_table[ref_value] = initial + steel*change
						end,
						scaling_message = {message = localize('k_upgrade_ex').." x"..steel, sound = togabalatro.config.SFXWhenTriggered and 'toga_xporb'}
					})
				end
			end
		end
		
		if context.joker_main then return { xmult = 1+card.ability.extra.curxmult } end
	end
})

-- Get repeats, up to 65536. Will use Talisman functions if present.
togabalatro.cashpointmulitple = function(cashpoint)
	local getmultiples = to_big(G.GAME.dollars)/to_big(cashpoint)
	if Talisman and type(getmultiples) == 'table' then getmultiples = getmultiples:to_number() end
	return math.min(math.floor(getmultiples), 65535)
end

table.insert(jokers, {
	key = 'spacecadetpinball',
	config = { extra = { cashpoint = 20, alltrig = 1 } },
	loc_vars = function(self, info_queue, card)
		card.ability.extra.alltrig = 1+togabalatro.cashpointmulitple(card.ability.extra.cashpoint)
		return { vars = { card.ability.extra.cashpoint, math.max(card.ability.extra.alltrig, 1), SMODS.get_probability_vars(card or self, 1, 3) } }
	end,
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersOther',
	pos = { x = 0, y = 2 },
	cost = 10,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.before then card.ability.extra.alltrig = 1+togabalatro.cashpointmulitple(card.ability.extra.cashpoint) end
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
})

table.insert(jokers, {
	key = 'heartyspades',
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersOtherDiffSize',
	pos = { x = 0, y = 0 },
	cost = 6,
	blueprint_compat = false,
	pixel_size = { w = 69, h = 74 }
})

table.insert(jokers, {
	key = 'binaryjkr',
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersOther',
	pos = { x = 0, y = 3 },
	cost = 6,
	blueprint_compat = false
})

table.insert(jokers, {
	key = 'hexadecimaljkr',
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersOther',
	pos = { x = 1, y = 3 },
	cost = 6,
	blueprint_compat = false
})

table.insert(jokers, {
	key = 'cavingjkr',
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
		return { key = togabalatro.stjcheck() and self.key.."_stj" or self.key }
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
})

table.insert(jokers, {
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
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
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
	end,
	poweritem = true
})

table.insert(jokers, {
	key = 'y2ksticker',
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersOtherDiffSize',
	pos = { x = 2, y = 0 },
	cost = 7,
	blueprint_compat = false,
	pixel_size = { w = 69, h = 38 }
})

table.insert(jokers, {
	key = 'pso2ironwill',
	config = { extra = { skillactive = true } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.skillactive, card.ability.extra.skillactive and localize('toga_pso2ironwillready') or localize('toga_pso2ironwillrecharge') } }
	end,
	unlocked = true,
	in_pool = function()
		-- return togabalatro.config.ShowPower
		return false -- This Joker will be reworked...
	end,
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
		
		if context.end_of_round and not (context.individual or context.repetition or context.blueprint) and G.GAME.blind.boss and not card.ability.extra.skillactive and not context.game_over then
			card.ability.extra.skillactive = true
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('toga_pso2ironwillready')})
		end
	end,
	poweritem = true,
	no_collection = true,
	remainhidden = true
})

table.insert(jokers, {
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
})

-- Check for Astronomica being present for setting score sound.
local AstronomicaEQScore = next(SMODS.find_mod('Astronomica')) and AST

table.insert(jokers, {
	key = 'joker203',
	unlocked = true,
	rarity = 1,
	atlas = 'TOGAJokersMain',
	pos = { x = 0, y = 6 },
	soul_pos = { x = 7, y = 6 },
	cost = 3,
	blueprint_compat = false,
	eternal_compat = false,
	demicolon_compat = true,
	calculate = function(self, card, context)
		if context.blueprint or context.retrigger_joker then return end
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
	end,
})

table.insert(jokers, {
	key = 'toiletrock',
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
	end,
	rarity = 2,
	atlas = 'TOGAJokersOther',
	pos = { x = 0, y = 5 },
	cost = 6,
	blueprint_compat = false,
	poweritem = true
})

table.insert(jokers, {
	key = 'wishingstones',
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
	end,
	rarity = 3,
	atlas = 'TOGAJokersOther',
	pos = { x = 1, y = 5 },
	cost = 8,
	blueprint_compat = false,
	poweritem = true
})

table.insert(jokers, {
	key = 'stoneroad',
	config = { extra = { hm = 1, odds = 2 } },
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
		return { vars = { card.ability.extra.hm, SMODS.get_probability_vars(card or self, 1, (card.ability or self.config).extra.odds) } }
	end,
	rarity = 1,
	atlas = 'TOGAJokersOther',
	pos = { x = 2, y = 5 },
	cost = 6,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.cardarea == G.hand and context.other_card and not context.other_card.debuff and SMODS.has_enhancement(context.other_card, 'm_stone') and not context.repetition and not context.repetition_only
		and not context.end_of_round and SMODS.pseudorandom_probability(card, "parkingonroad", 1, card.ability.extra.odds, "stoneroad") then
			return { dollars = card.ability.extra.hm }
		end
	end
})

togabalatro.gethowmuch = function(div, inputxmult)
	local dol, dolbuffer = G.GAME.dollars, G.GAME.dollar_buffer and G.GAME.dollar_buffer > 0 and G.GAME.dollar_buffer or 0
	local amount = to_big(dol) + to_big(dolbuffer)
	return math.floor(to_big(amount)/to_big(div))
end

table.insert(jokers, {
	key = 'speedsneakers',
	config = { extra = { xmultpart = 0.2, dollars = 5 } },
	loc_vars = function(self, info_queue, card)
		local xmultnerfval = card.ability.extra.xmultpart*(togabalatro.config.UseNerfed and 0.5 or 1)
		local total = togabalatro.gethowmuch(card.ability.extra.dollars, xmultnerfval)*xmultnerfval
		return { vars = { xmultnerfval, card.ability.extra.dollars, to_big(1)+to_big(total) > to_big(1) and to_big(1)+to_big(total) or to_big(1) } }
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
			local xmultnerfval = card.ability.extra.xmultpart*(togabalatro.config.UseNerfed and 0.5 or 1)
			local total = togabalatro.gethowmuch(card.ability.extra.dollars, xmultnerfval)*xmultnerfval
			return { xmult = to_big(1)+to_big(total) > to_big(1) and to_big(1)+to_big(total) or 1 }
		end
	end,
	set_badges = function(self, card, badges)
		if togabalatro.config.UseNerfed then badges[#badges+1] = create_badge(localize('toga_nerfedver'), G.C.UI.TEXT_DARK, G.C.WHITE, 1 ) end
	end,
})

table.insert(jokers, {
	key = 'megasxlr',
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersOther',
	pos = { x = 0, y = 4 },
	cost = 6,
	blueprint_compat = false,
})

table.insert(jokers, {
	key = 'jarate',
	config = { extra = { minicrit = 1.35, odds = 15 }},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {key = "toga_chipmultmodinfo", set = 'Other'}
		return { key = togabalatro.stjcheck() and self.key.."_stj" or self.key, vars = { card.ability.extra.minicrit, SMODS.get_probability_vars(card or self, 1, (card.ability or self.config).extra.odds, 'tf2jarate') } }
	end,
	unlocked = true,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	rarity = 3,
	atlas = 'TOGAJokersOtherDiffSize',
	pos = { x = 3, y = 0 },
	cost = 5,
	blueprint_compat = false,
	perishable_compat = false,
	eternal_compat = false,
	pixel_size = { w = 69, h = 73 },
	poweritem = true
})

table.insert(jokers, {
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
})

table.insert(jokers, {
	key = 'rloctane',
	config = { extra = { mult = 15 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	unlocked = true,
	rarity = 1,
	atlas = 'TOGAJokersOtherDiffSize',
	pos = { x = 10, y = 0 },
	cost = 4,
	blueprint_compat = true,
	pixel_size = { w = 69, h = 74 },
	calculate = function(self, card, context)
		if context.joker_main then return { mult = card.ability.extra.mult } end
		if context.after and G.GAME.current_round.hands_left == 0 and not SMODS.is_eternal(card) then
			G.E_MANAGER:add_event(Event({delay = 1, func = function()
				SMODS.calculate_effect({ message = localize('toga_rlwas'), card = card })
				return true
			end}))
			G.E_MANAGER:add_event(Event({func = function()
				SMODS.destroy_cards(card)
				return true
			end}))
		end
	end,
})

table.insert(jokers, {
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
					local pcard = SMODS.add_card({ set = 'Playing Card', rank = '6', area = G.play })
					pcard:start_materialize({G.C.SECONDARY_SET.Enhanced})
					SMODS.calculate_effect({message = localize('toga_pluscard'), colour = G.C.SECONDARY_SET.Enhanced}, ecard)
					G.E_MANAGER:add_event(Event({
						func = function()
							draw_card(G.play, G.deck, 90, 'up', nil)
							return true
					end}))
					playing_card_joker_effects({pcard})
					return true
				end}))
			return nil, true
		end
	end,
	pixel_size = { w = 69, h = 69 }
})

table.insert(jokers, {
	key = 'chrome',
	config = { extra = { xmult = 1.5, process = 'Chrome', totalxmult = 0 } },
	loc_vars = function(self, info_queue, card)
		local count = togabalatro.processcounts.chrome
		local bonus, totalbonus = card.ability.extra.xmult, 0
		for i = 1, count do
			totalbonus = totalbonus + bonus
			bonus = bonus * 0.8
		end
		card.ability.extra.totalxmult = 1+totalbonus
		return { key = card.edition and card.edition.polychrome and self.key.."_poly" or self.key, vars = { card.ability.extra.xmult, card.ability.extra.totalxmult, count, card.ability.extra.process } }
	end,
	unlocked = true,
	in_pool = function()
		return togabalatro.config.JokeJokersActive -- Should only spawn if allowed to via config!
	end,
	rarity = 2,
	atlas = 'TOGAJokersOtherDiffSize',
	pos = { x = 8, y = 0 },
	cost = 5,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.before then
			local count = togabalatro.processcounts.chrome
			local bonus, totalbonus = card.ability.extra.xmult, 0
			for i = 1, count do
				totalbonus = totalbonus + bonus
				bonus = bonus * 0.8
			end
			card.ability.extra.totalxmult = 1+totalbonus
		end
		if context.joker_main then return { xmult = math.max(card.ability.extra.totalxmult, 1) } end
	end,
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge("Joke (TOGA)", G.C.SECONDARY_SET.Tarot, G.C.WHITE, 1 )
	end,
	pixel_size = { w = 69, h = 69 },
	poweritem = true,
	jokeitem = true
})

table.insert(jokers, {
	key = 'firefox',
	config = { extra = { xchips = 1.5, process = 'Firefox', totalxchips = 0 } },
	loc_vars = function(self, info_queue, card)
		local count = togabalatro.processcounts.firefox
		local bonus, totalbonus = card.ability.extra.xchips, 0
		for i = 1, count do
			totalbonus = totalbonus + bonus
			bonus = bonus * 0.8
		end
		card.ability.extra.totalxchips = 1+totalbonus
		return { vars = { card.ability.extra.xchips, card.ability.extra.totalxchips, count, card.ability.extra.process } }
	end,
	unlocked = true,
	in_pool = function()
		return togabalatro.config.JokeJokersActive -- Should only spawn if allowed to via config!
	end,
	rarity = 2,
	atlas = 'TOGAJokersOtherDiffSize',
	pos = { x = 9, y = 0 },
	cost = 5,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.before then
			local count = togabalatro.processcounts.firefox
			local bonus, totalbonus = card.ability.extra.xchips, 0
			for i = 1, count do
				totalbonus = totalbonus + bonus
				bonus = bonus * 0.8
			end
			card.ability.extra.totalxchips = 1+totalbonus
		end
		if context.joker_main then return { xchips = math.max(card.ability.extra.totalxchips, 1) } end
	end,
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge("Joke (TOGA)", G.C.SECONDARY_SET.Tarot, G.C.WHITE, 1 )
	end,
	pixel_size = { w = 69, h = 67 },
	poweritem = true,
	jokeitem = true
})

local winupdateframes = {0, 1, 2, 3, 4, 5, 5, 4, 3, 2, 1}
table.insert(jokers, {
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
})

togabalatro.calccopiesofself = function(jkey)
	local count = #SMODS.find_card(jkey)
	return count or 0
end

-- I am currently in a video game where I give XMult for every copy of me held.
table.insert(jokers, {
	key = 'tomscott',
	config = { extra = { basexmult = 2 } },
	loc_vars = function(self, info_queue, card)
		return { key = togabalatro.stjcheck() and self.key.."_stj" or self.key, vars = { card.ability.extra.basexmult, card.ability.extra.basexmult ^ togabalatro.calccopiesofself(card.config.center.key) } }
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
	end,
	jokeitem = true
})

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
table.insert(jokers, {
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
		return togabalatro.config.JokeJokersActive and togabalatro.config.ShowPower -- Should only spawn if allowed to via config!
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
	end,
	jokeitem = true,
	poweritem = true
})

table.insert(jokers, {
	key = 'albanianvirus',
	loc_vars = function(self, info_queue, card)
		if card.ability.albavirusactive then
			info_queue[#info_queue + 1] = {key = "toga_albavirusinfo", set = 'Other'}
		end
	end,
	unlocked = true,
	in_pool = function()
		return togabalatro.config.JokeJokersActive -- Should only spawn if allowed to via config!
	end,
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
		if G.STAGE == G.STAGES.RUN and not G.screenwipe and not from_debuff then
			card.ability.albavirusactive = true
			togabalatro.albavirusnoted()
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if card.ability.albavirusactive and not from_debuff then
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
	end,
	jokeitem = true,
	remainhidden = true
})

-- Joke Joker. Originally had 'whatthefuck' as key.
if Talisman then
	table.insert(jokers, {
		key = 'whatisthis',
		config = { extra = { part = 1.05 } },
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.extra.part } }
		end,
		unlocked = true,
		in_pool = function()
			return togabalatro.config.JokeJokersActive and togabalatro.config.ShowPower -- Should only spawn if allowed to via config!
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
				local stacked, stackamount = togabalatro.stackingcompat(context.other_consumeable)
				if stacked and stackamount then
					local results = {}
					for i = 1, stackamount do
						table.insert(results, {
							ee_mult = card.ability.extra.part > 1 and card.ability.extra.part or nil,
							eemult_message = card.ability.extra.part > 1 and {message = localize{ type = "variable", key = "toga_EEmult", vars = { card.ability.extra.part } }, colour = G.C.DARK_EDITION, sound = "talisman_eemult"} or nil,
						})
					end
					return SMODS.merge_effects(results)
				else
					return {
						ee_mult = card.ability.extra.part > 1 and card.ability.extra.part or nil,
						eemult_message = card.ability.extra.part > 1 and {message = localize{ type = "variable", key = "toga_EEmult", vars = { card.ability.extra.part } }, colour = G.C.DARK_EDITION, sound = "talisman_eemult"} or nil,
					}
				end
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
		end,
		jokeitem = true,
		poweritem = true
	})
end

-- Joke Joker. Bit of an inside funny.
if Talisman then
	table.insert(jokers, {
		key = 'quacksoft',
		config = { extra = { cardechip = 0.02 } },
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.extra.cardechip, G.playing_cards and 1 + (card.ability.extra.cardechip*#G.playing_cards) or 1 } }
		end,
		unlocked = true,
		in_pool = function()
			return togabalatro.config.JokeJokersActive and togabalatro.config.ShowPower -- Should only spawn if allowed to via config!
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
		end,
		jokeitem = true,
		poweritem = true
	})
end

-- Balatro Multiplayer exclusions.
togabalatro.bmpexclude = {
	['monitor'] = true, ['chrome'] = true, ['firefox'] = true, ['jimboplus'] = true, ['gamecontrollers'] = true,
	['notsosmileyface'] = true, ['dragndrop'] = true, ['nonebattery'] = true, ['cpu'] = true, ['pcmcia'] = true,
	['pso2ironwill'] = true, ['drivespace'] = true, ['wscript'] = true, ['joker203'] = true, ['vga'] = true,
}

-- Absolute exclusions.
togabalatro.bmpbreakingitems = {
	['drivespace'] = true, ['wscript'] = true, ['joker203'] = true, ['albanianvirus'] = true
}

-- Actually go through the initialization of Jokers.
local intjkrname = "j_toga_"
togabalatro.canjokerload = function(key)
	if type(key) ~= 'string' then return false end
	if togabalatro.checkbmp() and (togabalatro.bmpexclude[key] or togabalatro.bmpbreakingitems[key]) and not togabalatro.config.BMPAllItems then
		if togabalatro.config.DoMoreLogging then sendInfoMessage("Skipping loading of "..intjkrname..key.." due to presence of Balatro Multiplayer.", "TOGAPack") end
		return false
	end
	return true
end

for i, j in ipairs(jokers) do
	if togabalatro.canjokerload(j.key) then
		if togabalatro.config.DoMoreLogging then sendInfoMessage("Initializing "..intjkrname..j.key, "TOGAPack") end
		SMODS.Joker(j)
	end
end