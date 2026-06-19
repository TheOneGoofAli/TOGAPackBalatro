sendInfoMessage("Loading Jokers - Windows OS...", "TOGAPack")

local winj = {}

table.insert(winj, {
	key = 'win101',
	config = { extra = { ths = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { SMODS.signed(math.floor(card.ability.extra.ths)), localize('Pair', "poker_hands"), localize('Ace', "ranks") } }
	end,
	unlocked = true,
	in_pool = function()
		for k, v in ipairs(G.playing_cards or {}) do
			if v and not SMODS.has_no_rank(v) and v:get_id() == 14 then return true end
		end
		return false
	end,
	rarity = 2,
	atlas = 'TOGAJokersWindows',
	pos = { x = 0, y = 0 },
	cost = 6,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if context.before and context.poker_hands and context.poker_hands['Pair'] then
			local add
			for _, v in pairs(context.poker_hands['Pair'] or {}) do
				local c1, c2 = not SMODS.has_no_rank(v[1]) and v[1]:get_id() or 0, not SMODS.has_no_rank(v[2]) and v[2]:get_id() or 0
				if c1 == 14 and c1 == c2 then add = math.floor(card.ability.extra.ths); break end
			end
			if add then
				return {
					message = "!",
					juice_card = G.hand,
					func = function()
						G.hand:change_size(add)
						G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + add
					end
				}
			end
		end
	end,
	pixel_size = { w = 71, h = 80 },
	attributes = { 'rank', 'ace', 'hand_type', 'hand_size' }
})

table.insert(winj, {
	key = 'win386',
	config = { extra = { xmult = 3.86 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
	end,
	unlocked = true,
	in_pool = function()
		local three, eight, six = false, false, false
		for k, v in ipairs(G.playing_cards or {}) do
			if v and not SMODS.has_no_rank(v) then
				local id = v:get_id()
				if id then
					if id == 3 then three = true end
					if id == 8 then eight = true end
					if id == 6 then six = true end
				end
			end
		end
		return (three and eight and six)
	end,
	rarity = 3,
	atlas = 'TOGAJokersWindows',
	pos = { x = 1, y = 0 },
	cost = 8,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.joker_main and context.full_hand then
			local three, eight, six = false, false, false
			for k, v in pairs(context.full_hand or {}) do
				local id = not SMODS.has_no_rank(v) and v:get_id() or 0
				if id then
					if id == 3 then three = true end
					if id == 8 then eight = true end
					if id == 6 then six = true end
				end
			end
			if three and eight and six then return { xmult = card.ability.extra.xmult } end
		end
	end,
	pixel_size = { w = 71, h = 90 },
	attributes = { 'xmult', 'rank', 'three', 'six', 'eight' }
})

table.insert(winj, {
	key = 'winforworkgroups311',
	config = { extra = { chips = 11, mult = 3 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
	end,
	unlocked = true,
	in_pool = function()
		for k, v in ipairs(G.playing_cards or {}) do
			if v and not SMODS.has_no_rank(v) then
				local id = v:get_id()
				if (id == 3 or id == 14) then return true end
			end
		end
		return false
	end,
	rarity = 1,
	atlas = 'TOGAJokersWindows',
	pos = { x = 2, y = 0 },
	cost = 4,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card then
			local cid = context.other_card:get_id()
			if (cid == 14 or cid == 3) then return { chips = card.ability.extra.chips, mult = card.ability.extra.mult } end
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			if togabalatro.config.SFXWhenAdding then play_sound("toga_chimesold") end
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if togabalatro.config.SFXWhenRemoving and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			if not from_debuff then play_sound("toga_chimesold")
			else play_sound("toga_dingyold") end
		end
	end,
	pixel_size = { w = 71, h = 87 },
	attributes = { 'chips', 'mult', 'rank', 'ace', 'three' }
})

table.insert(winj, {
	key = 'win95',
	config = { extra = { hands = 1, discards = 1 } },
	loc_vars = function(self, info_queue, card)
		return { key = togabalatro.stjcheck() and self.key.."_stj" or self.key, vars = { card.ability.extra.hands, card.ability.extra.discards } }
	end,
	unlocked = true,
	discovered = true,
	rarity = 2,
	atlas = 'TOGAJokersWindows',
	pos = { x = 0, y = 1 },
	cost = 6,
	blueprint_compat = true,
	demicolon_compat = true,
	calculate = function(self, card, context)
		if (context.setting_blind or context.forcetrigger) and not (context.blueprint_card or card).getting_sliced then
			if context.blind and context.blind.boss then ease_hands_played(card.ability.extra.hands) end
			ease_discard(card.ability.extra.discards)
			return { message = localize('toga_32bits') }
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			if togabalatro.config.SFXWhenAdding then play_sound("toga_win95start") end
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if togabalatro.config.SFXWhenRemoving and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			if not from_debuff then play_sound("toga_win95tada")
			else play_sound("toga_chordold") end
		end
	end,
	attributes = { 'discard', 'hands' }
})

togabalatro.gettotaljokervalue = function()
	local value = 0
	if G.jokers then
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i].ability.set == 'Joker' then
				value = value + G.jokers.cards[i].sell_cost
			end
		end
	end
	return value
end

table.insert(winj, {
	key = 'win98',
	config = { extra = { consslotbonus = 0.1, totalconsslotbonus = 0, percentage = 0.2 } },
	loc_vars = function(self, info_queue, card)
		card.ability.extra.totalconsslotbonus = togabalatro.getconscount()*card.ability.extra.consslotbonus or 0
		return { vars = { card.ability.extra.consslotbonus*100, card.ability.extra.totalconsslotbonus*100, card.ability.extra.percentage*100, togabalatro.gettotaljokervalue()*card.ability.extra.percentage } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersWindows',
	pos = { x = 1, y = 1 },
	cost = 5,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			local sellvalues = togabalatro.gettotaljokervalue()*card.ability.extra.percentage
			local slotbonus = sellvalues*togabalatro.getconscount()*card.ability.extra.consslotbonus or 0
			return {
				mult = sellvalues + slotbonus
			}
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			if togabalatro.config.SFXWhenAdding then play_sound("toga_win98start") end
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if togabalatro.config.SFXWhenRemoving and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			if not from_debuff then play_sound("toga_win98tada")
			else play_sound("toga_chord") end
		end
	end,
	attributes = { 'joker', 'consumeable', 'mult', 'sell_value' }
})

local function toga_vouchcount()
	return G.vouchers and G.vouchers.cards and #G.vouchers.cards or 0
end

table.insert(winj, {
	key = 'winmillenium',
	config = { extra = { basechips = 10, chipbonus = 10, totalbonus = 20 } },
	loc_vars = function(self, info_queue, card)
		card.ability.extra.totalbonus = card.ability.extra.basechips + card.ability.extra.chipbonus * toga_vouchcount()
		return { vars = { card.ability.extra.basechips, card.ability.extra.chipbonus, card.ability.extra.totalbonus } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersWindows',
	pos = { x = 2, y = 1 },
	cost = 6,
	blueprint_compat = true,
	calculate = function(self, card, context)
		card.ability.extra.totalbonus = card.ability.extra.basechips + card.ability.extra.chipbonus * toga_vouchcount()
		
		if context.other_joker or context.other_consumeable then
			return { chips = card.ability.extra.totalbonus, message_card = context.other_joker or context.other_consumeable }
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			if togabalatro.config.SFXWhenAdding then play_sound("toga_winme2000start") end
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if togabalatro.config.SFXWhenRemoving and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			if not from_debuff then play_sound("toga_winme2000shutdown")
			else play_sound("toga_chord"); check_for_unlock({ type = 'winmedebuff' }) end
		end
	end,
	attributes = { 'joker', 'consumeable', 'voucher', 'chips' }
})

table.insert(winj, {
	key = 'winnt4',
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersWindows',
	pos = { x = 0, y = 2 },
	cost = 6,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition and not context.repetition_only then
			if not context.other_card:is_face() then
				-- This is basically the inverse of Sock and Buskin...
				return {
					message = localize('k_again_ex'),
					repetitions = 1,
					card = context.blueprint_card or card
				}
			end
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenAdding and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_winnt4start")
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if togabalatro.config.SFXWhenRemoving and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			if not from_debuff then play_sound("toga_winnt4shutdown")
			else play_sound("toga_chordold") end
		end
	end,
	attributes = { 'retrigger', 'non_face' }
})

table.insert(winj, {
	key = 'win2000',
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersWindows',
	pos = { x = 1, y = 2 },
	cost = 8,
	blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = false,
	demicolon_compat = true,
	calculate = function(self, card, context)
		if (context.end_of_round or context.forcetrigger) and context.main_eval then
			return { func = function()
				G.E_MANAGER:add_event(Event({
					func = (function()
						add_tag({ key = SMODS.poll_object({ type = 'Tag', seed = 'toga_win2000' }) })
						card:juice_up(0.3, 0.4)
						play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
						play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
						return true
					end)
				}))
			end }
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenAdding and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_winme2000start")
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if togabalatro.config.SFXWhenRemoving and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			if not from_debuff then play_sound("toga_winme2000shutdown")
			else play_sound("toga_chord") end
		end
	end,
	attributes = { 'tag', 'generation' }
})

table.insert(winj, {
	key = 'winxp',
	config = { extra = { odds = 5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { SMODS.get_probability_vars(card or self, 1, (card.ability or self.config).extra.odds) } }
	end,
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersWindows',
	pos = { x = 2, y = 2 },
	cost = 8,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.toga_levelup and SMODS.pseudorandom_probability(card, "experiencethebest", 1, card.ability.extra.odds, 'yesyoucan') then
			return { xplvlup = true, card = context.blueprint_card or card }
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenAdding and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_winxplogon")
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if togabalatro.config.SFXWhenRemoving and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			if not from_debuff then play_sound("toga_winxplogoff")
			else play_sound("toga_winxpcritstop") end
		end
	end,
	attributes = { 'chance', 'level_up' }
})

table.insert(winj, {
	key = 'winvista',
	config = { extra = { active = true } },
	loc_vars = function(self, info_queue, card)
		return { key = togabalatro.stjcheck() and self.key.."_stj" or self.key, vars = { localize(card.ability.extra.active and 'toga_active' or 'toga_inactive') } }
	end,
	unlocked = true,
	in_pool = function()
		if togabalatro.config.ShowPower then
			for k, v in ipairs(G.playing_cards or {}) do
				if v and not SMODS.has_no_rank(v) and v:get_id() == 6 then return true end
			end
		end
		return false
	end,
	rarity = 3,
	atlas = 'TOGAJokersWindows',
	pos = { x = 0, y = 3 },
	cost = 10,
	blueprint_compat = false,
	demicolon_compat = false,
	calculate = function(self, card, context)
		if context.blueprint or context.retrigger_joker then return end
		if card.ability.extra.active and context.destroy_card and context.cardarea == G.play and context.scoring_hand and #context.scoring_hand == 1 and #context.full_hand == 1 and context.destroy_card:get_id() == 6 then
			return {
				remove = true,
				func = function()
					if #G.jokers.cards > 0 then
						local iter, iterlimit, seljoker = 0, 10*#G.jokers.cards, nil
						repeat
							iter = iter + 1
							seljoker = pseudorandom_element(G.jokers.cards, pseudoseed('notverywow'))
							if seljoker and seljoker.edition and not seljoker.edition.negative then break end
						until seljoker and seljoker.edition and not seljoker.edition.negative or iter >= iterlimit
						if seljoker and seljoker.edition and not seljoker.edition.negative then
							G.E_MANAGER:add_event(Event({func = function()
								if seljoker and seljoker.edition and not seljoker.edition.negative then
									card:juice_up()
									seljoker:set_edition('e_negative')
									card.ability.extra.active = false
									SMODS.calculate_effect({message = localize('toga_inactive')}, card)
								end
							return true end }))
						end
					end
					return true
				end
			}
		end
		if context.end_of_round and context.beat_boss and not card.ability.extra.active then
			card.ability.extra.active = true
			return { message = localize('k_active_ex') }
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenAdding and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_winvista78logon")
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if togabalatro.config.SFXWhenRemoving and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			if not from_debuff then play_sound("toga_winvista78logoff")
			else play_sound("toga_winvista7critstop") end
		end
	end,
	poweritem = true,
	attributes = { 'rank', 'six', 'modify_joker', 'editions' }
})

table.insert(winj, {
	key = 'win7',
	config = { extra = { xscale = 0.04 } },
	loc_vars = function(self, info_queue, card)
		local s = 0
		for k, v in ipairs(G.playing_cards or {}) do
			if v and not SMODS.has_no_rank(v) and v:get_id() == 7 then s = s + 1 end
		end
		return { vars = { card.ability.extra.xscale, 1+s*card.ability.extra.xscale } }
	end,
	unlocked = true,
	in_pool = function()
		if togabalatro.config.ShowPower then
			local s = 0
			for k, v in ipairs(G.playing_cards or {}) do
				if v and not SMODS.has_no_rank(v) and v:get_id() == 7 then return true end
			end
		end
		return false
	end,
	rarity = 3,
	atlas = 'TOGAJokersWindows',
	pos = { x = 1, y = 3 },
	cost = 8,
	blueprint_compat = false,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenAdding and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_winvista78logon")
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if togabalatro.config.SFXWhenRemoving and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			if not from_debuff then play_sound("toga_winvista78logoff")
			else play_sound("toga_winvista7critstop") end
		end
	end,
	calc_scaling = function(self, card, other_card, initial_value, scalar_value, args)
		if card == other_card then return end
		if to_big(scalar_value) > to_big(0) then
			local s = 0
			for k, v in ipairs(G.playing_cards or {}) do
				if v and not SMODS.has_no_rank(v) and v:get_id() == 7 then s = s + 1 end
			end
			if s > 0 then
				return {
					message = '!',
					delay = 0.2,
					override_scalar_value = {
						value = scalar_value * (1+s*card.ability.extra.xscale)
					}
				}
			end
		end
	end,
	poweritem = true,
	attributes = { 'rank', 'seven', 'scaling' }
})

table.insert(winj, {
	key = 'win8',
	config = { extra = { add_prt = 1, rounds = 0, rtarget = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.add_prt, card.ability.extra.rounds, card.ability.extra.rtarget } }
	end,
	unlocked = true,
	in_pool = function()
		if togabalatro.config.ShowPower then
			local s = 0
			for k, v in pairs(G.playing_cards or {}) do
				if v and not SMODS.has_no_rank(v) and v:get_id() == 8 then return true end
			end
		end
		return false
	end,
	rarity = 3,
	atlas = 'TOGAJokersWindows',
	pos = { x = 2, y = 3 },
	cost = 8,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.end_of_round and not (context.individual or context.repetition or context.blueprint) then
			if to_number(card.ability.extra.rounds) >= to_number(card.ability.extra.rtarget) then
				if not card.ability.extra.ready then
					card.ability.extra.ready = true
					local eval = function() return not card.ability.extra.active end
					juice_card_until(card, eval, true)
					return { message = localize('k_active_ex') }
				end
			else
				card.ability.extra.rounds = (card.ability.extra.rounds or 0) + 1
				return { message = to_number(card.ability.extra.rounds).."/"..to_number(card.ability.extra.rtarget), juice_card = context.blueprint_card or card }
			end
		end
		if context.selling_self and card.ability.extra.ready then
			card.ability.extra.ready = false
			if to_number(card.ability.extra.rounds) >= to_number(card.ability.extra.rtarget) then
				local metro = {}
				for k, v in pairs(G.playing_cards or {}) do
					if v and not SMODS.has_no_rank(v) and v:get_id() == 8 then table.insert(metro, v) end
				end
				if next(metro) then
					local chosen = pseudorandom_element(metro, pseudoseed('whostolemystartbutton'))
					if chosen then
						chosen.ability.perma_repetitions = (chosen.ability.perma_repetitions or 0) + 1
						return { message = localize('k_upgrade_ex'), message_card = chosen, juice_card = context.blueprint_card or card }
					end
				else
					return { message = localize('k_nope_ex'), juice_card = context.blueprint_card or card }
				end
			end
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff and togabalatro.config.SFXWhenAdding and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			play_sound("toga_winvista78logon")
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if togabalatro.config.SFXWhenRemoving and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			if not from_debuff then play_sound("toga_winvista78logoff")
			else play_sound("toga_win8error") end
		end
	end,
	pixel_size = { w = 70, h = 84 },
	poweritem = true,
	attributes = { 'rank', 'eight', 'on_sell', 'modify_card', 'perma_bonus' }
})

return winj