sendInfoMessage("Loading Seals...", "TOGAPack")

-- Of all things to first do... this?
SMODS.Seal{
	key = 'sealseal',
	badge_colour = HEX("61666D"),
	atlas = "TOGASeals",
	pos = { x = 0, y = 0 },
	config = { odds = 25 },
	loc_vars = function(self, info_queue, card)
		if G and G.GAME and G.GAME.used_vouchers then
			return { key = G.GAME.used_vouchers['v_toga_caniofferyouanegg'] == true and self.key..'_alt2' or G.GAME.used_vouchers['v_toga_sealegg'] == true and self.key..'_alt1'
				or self.key, vars = G.GAME.used_vouchers['v_toga_sealegg'] == true and { G.GAME.probabilities.normal or 1, self.config.odds or 1337 } }
		end
	end,
	sound = { sound = "gold_seal", per = 1.2, vol = 0.4 },
	calculate = function(self, card, context)
		if context.main_scoring and context.cardarea == G.play and card and card.ability.seal then
			local negativeroll = pseudorandom("sealseal") < G.GAME.probabilities.normal/card.ability.seal.odds
			return {
				func = function()
					local createnegative = false
					if (negativeroll and G.GAME.used_vouchers['v_toga_sealegg'] == true) or G.GAME.used_vouchers['v_toga_caniofferyouanegg'] == true then createnegative = true end
					G.E_MANAGER:add_event(Event({
						func = function()
							if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit or createnegative then
								local card = SMODS.add_card({ set = 'Joker', key = 'j_egg', edition = createnegative and 'e_negative' }) -- egg.
								G.GAME.joker_buffer = 0
							end
							return true
						end}))
					return true
				end
			}
		end
	end,
}