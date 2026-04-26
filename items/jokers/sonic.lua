-- the Sonic

local sj = {}

table.insert(sj, {
	key = 'sonicthehedgehog',
	config = { extra = { odds = 7 } },
	loc_vars = function(self, info_queue, card)
		local num, den = SMODS.get_probability_vars(card or self, 1, (card.ability or self.config).extra.odds, 'toga_7chaosemeralds')
		local scoredgold, maxgold = card.ability.extra.rings or 0, 50
		return { key = togabalatro.stjcheck() and self.key.."_stj" or self.key, vars = { num, den, scoredgold, maxgold } }
	end,
	unlocked = true,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	discovered = true,
	rarity = 3,
	atlas = 'TOGASonic',
	pos = { x = 0, y = 0 },
	soul_pos = { x = 0, y = 1 },
	cost = 8,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.repetition and not context.repetition_only and context.other_card and SMODS.has_enhancement(context.other_card, 'm_gold') then
			return {
				message = localize('k_again_ex'),
				repetitions = 1,
				card = context.blueprint_card or card
			}
		end
		
		if (context.blueprint or context.retrigger_joker) then return end
		
		if context.before and context.full_hand and next(context.full_hand) then
			for k, v in ipairs(context.full_hand or {}) do
				if SMODS.has_enhancement(v, 'm_gold') then
					if (tonumber(card.ability.extra.rings) or 0) < 50 then
						card.ability.extra.rings = math.min((card.ability.extra.rings or 0) + 1, 50)
						if card.ability.extra.rings >= 50 then
							SMODS.calculate_effect({ message = "!", message_card = v, juice_card = card, sound = togabalatro.config.SFXWhenTriggered and 'toga_sonictally', pitch = 1}, card)
						else
							SMODS.calculate_effect({ message = "+", message_card = v, juice_card = card, sound = togabalatro.config.SFXWhenTriggered and 'toga_sonicring', pitch = 1}, card)
						end
					end
				end
			end
		end
		
		if context.after then
			if (tonumber(card.ability.extra.rings) or 0) >= 50 and not card.ability.cantransform then
				card.ability.cantransform = true
				SMODS.calculate_effect({ message = "!", sound = togabalatro.config.SFXWhenTriggered and 'toga_soniccheckpoint', pitch = 1}, card)
			end
			
			if card.ability.cantransform then
				if SMODS.pseudorandom_probability(card, 'toga_7chaosemeralds', 1, card.ability.extra.odds, 'toga_7chaosemeralds') then
					card.ability.istransforming = true
					local rings = card.ability.extra.rings
					G.E_MANAGER:add_event(Event({delay = 2, func = function()
						card:flip()
					return true end }))
					delay(1)
					G.E_MANAGER:add_event(Event({delay = 2, func = function()
						card:juice_up()
					return true end }))
					delay(1)
					G.E_MANAGER:add_event(Event({delay = 2, func = function()
						card:juice_up()
					return true end }))
					delay(1)
					G.E_MANAGER:add_event(Event({delay = 5, func = function()
						play_sound('toga_sonictransform')
						card.ability.cantransform = false
						card.ability.istransforming = false
						card:set_ability('j_toga_supersonicthehedgehog')
						card.ability.extra = type(card.ability.extra) == 'table' and card.ability.extra or {}
						card.ability.extra.rings = rings
						check_for_unlock({ type = 'supersoniccheck_toga', card = card })
					return true end }))
					G.E_MANAGER:add_event(Event({delay = 2, func = function()
						card:flip()
					return true end }))
					delay(1)
				end
			end
		end
	end,
	poweritem = true,
	display_size = { w = 71 * 1.056, h = 95 },
	pixel_size = { w = 71, h = 95 },
	remove_from_deck = function(self, card, from_debuff)
		if G.STAGE == G.STAGES.RUN and not G.screenwipe and from_debuff then
			card.ability.extra.rings = 0
			SMODS.calculate_effect({ message = localize('toga_kartouch'), colour = G.C.RED, sound = togabalatro.config.SFXWhenTriggered and 'toga_sonicringloss', pitch = 1}, card)
		end
	end,
	attributes = { 'retrigger', 'enhancements', 'chance' }
})

table.insert(sj, {
	key = 'supersonicthehedgehog',
	config = { extra = { odds = 7, nodds = 8 } },
	loc_vars = function(self, info_queue, card)
		local num, den = SMODS.get_probability_vars(card or self, 1, (card.ability or self.config).extra.odds, 'toga_7superemeralds')
		local num1, den1 = SMODS.get_probability_vars(card or self, 1, (card.ability or self.config).extra.nodds, 'toga_supersonicdestroy')
		local scoredgold, maxgold = card.ability.extra.rings or 0, 150
		return { key = togabalatro.stjcheck() and self.key.."_stj" or self.key, vars = { num, den, num1, den1, scoredgold, maxgold } }
	end,
	unlocked = true,
	in_pool = function()
		return false
	end,
	discovered = true,
	rarity = 4,
	atlas = 'TOGASuperSonic',
	pos = { x = 0, y = 0 },
	soul_pos = { x = 0, y = 1 },
	no_collection = true,
	cost = 20,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.repetition and not context.repetition_only and context.other_card then
			return {
				message = localize('k_again_ex'),
				repetitions = 1,
				card = context.blueprint_card or card
			}
		end
		
		if (context.blueprint or context.retrigger_joker) then return end
		
		if context.individual and context.cardarea == G.play and context.other_card then
			if (tonumber(card.ability.extra.rings) or 0) < 150 then
				card.ability.extra.rings = math.min((card.ability.extra.rings or 0) + 1, 150)
				if card.ability.extra.rings >= 150 then
					SMODS.calculate_effect({ message = "!", message_card = context.other_card, juice_card = card, sound = togabalatro.config.SFXWhenTriggered and 'toga_sonictally', pitch = 1}, card)
				else
					SMODS.calculate_effect({ message = "+", message_card = context.other_card, juice_card = card, sound = togabalatro.config.SFXWhenTriggered and 'toga_sonicring', pitch = 1}, card)
				end
			end
		end
		
		if context.destroy_card and context.cardarea == G.play and not SMODS.has_enhancement(context.destroy_card, 'm_gold') and SMODS.pseudorandom_probability(card, 'toga_supersonicdestroy', 1, card.ability.extra.nodds) then
			context.destroy_card.sonicdestroyed = true
			return { remove = true }
		end
		
		if context.after then
			if (tonumber(card.ability.extra.rings) or 0) >= 150 and not card.ability.cantransform then
				card.ability.cantransform = true
				SMODS.calculate_effect({ message = "!", sound = togabalatro.config.SFXWhenTriggered and 'toga_soniccheckpoint', pitch = 1}, card)
			end
			
			if card.ability.cantransform then
				if SMODS.pseudorandom_probability(card, 'toga_7superemeralds', 1, card.ability.extra.odds, 'toga_7superemeralds') then
					card.ability.istransforming = true
					G.E_MANAGER:add_event(Event({delay = 2, func = function()
						card:flip()
					return true end }))
					delay(1)
					G.E_MANAGER:add_event(Event({delay = 2, func = function()
						card:juice_up()
					return true end }))
					delay(1)
					G.E_MANAGER:add_event(Event({delay = 2, func = function()
						card:juice_up()
					return true end }))
					delay(1)
					G.E_MANAGER:add_event(Event({delay = 5, func = function()
						play_sound('toga_sonictransform')
						card.ability.cantransform = false
						card.ability.istransforming = false
						card:set_ability('j_toga_hypersonicthehedgehog')
						check_for_unlock({ type = 'hypersoniccheck_toga', card = card })
					return true end }))
					G.E_MANAGER:add_event(Event({delay = 2, func = function()
						card:flip()
					return true end }))
					delay(1)
				end
			end
		end
	end,
	poweritem = true,
	remainhidden = true,
	display_size = { w = 71 * 1.056, h = 95 },
	pixel_size = { w = 71, h = 95 },
	attributes = { 'retrigger', 'enhancements', 'prevent_debuff', 'destroy_card', 'chance' }
})

table.insert(sj, {
	key = 'hypersonicthehedgehog',
	config = { extra = { odds = 8 } },
	loc_vars = function(self, info_queue, card)
		local num, den = SMODS.get_probability_vars(card or self, 1, (card.ability or self.config).extra.odds, 'toga_hypersonicdestroy')
		return { key = togabalatro.stjcheck() and self.key.."_stj" or self.key, vars = { num, den } }
	end,
	unlocked = true,
	in_pool = function()
		return false
	end,
	discovered = true,
	rarity = 4,
	atlas = 'TOGAHyperSonic',
	pos = { x = 0, y = 0 },
	soul_pos = { x = 0, y = 1 },
	no_collection = true,
	cost = 40,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.repetition and not context.repetition_only and context.other_card then
			return {
				message = localize('k_again_ex'),
				repetitions = 2,
				card = context.blueprint_card or card
			}
		end
		
		if (context.blueprint or context.retrigger_joker) then return end
		
		if context.destroy_card and context.cardarea == G.play and SMODS.pseudorandom_probability(card, 'toga_hypersonicdestroy', 1, card.ability.extra.odds) then
			context.destroy_card.sonicdestroyed = true
			return { remove = true }
		end
	end,
	poweritem = true,
	remainhidden = true,
	display_size = { w = 71 * 1.056, h = 95 },
	pixel_size = { w = 71, h = 95 },
	attributes = { 'retrigger', 'prevent_debuff', 'destroy_card', 'chance' }
})

return sj