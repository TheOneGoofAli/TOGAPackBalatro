SMODS.Joker{
	key = 'internetspades',
	config = { extra = { xchip = 1.5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xchip } }
	end,
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersOtherDiffSize',
	pos = { x = 5, y = 0 },
	cost = 8,
	pools = { ["TOGAJKR"] = true },
	blueprint_compat = false,
	calculate = function(self, card, context)
		if context.other_consumeable then
			local aheads, onlyspades = {}, true
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i]:is_rarity("payasaka_ahead") then aheads[#aheads+1] = G.jokers.cards[i] end
			end
			if context.full_hand and #context.full_hand > 0 then
				for i = 1, #context.full_hand do
					if not context.full_hand[i]:is_suit('Spades') then onlyspades = false; break end
				end
			end
			if #aheads > 0 and onlyspades then
				local context = context
				return {
					func = function()
						for i = 1, #aheads do
							local effects = {
								x_chips = card.ability.extra.xchip > 1 and card.ability.extra.xchip or nil,
								xchip_message = card.ability.extra.xchip > 1 and {message = localize{ type = "variable", key = "a_xchips", vars = { card.ability.extra.xchip } }, colour = G.C.CHIPS, sound = "xchips"} or nil,
								card = aheads[i]
							}
							local stacked, stackamount = togabalatro.stackingcompat(context)
							if stacked and stackamount then
								for i = 1, stackamount do
									SMODS.calculate_individual_effect(effects, context.other_consumeable, 'xchips', effects.x_chips, false)
								end
							else SMODS.calculate_individual_effect(effects, context.other_consumeable, 'xchips', effects.x_chips, false) end
						end
					end
				}
			end
		end
	end,
	set_badges = function(self, card, badges)
		if self.discovered then SMODS.create_mod_badges({ mod = SMODS.find_mod('pta_saka')[1] }, badges) end
	end,
	pixel_size = { w = 69, h = 74 },
	attributes = { 'ahead', 'suit', 'spades', 'xchips', 'joker' }
}