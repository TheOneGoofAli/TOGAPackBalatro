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
				or self.key, vars = G.GAME.used_vouchers['v_toga_sealegg'] == true and { SMODS.get_probability_vars(card or self, 1, (card.ability or self.config).odds) } }
		end
	end,
	sound = { sound = "gold_seal", per = 1.2, vol = 0.4 },
	calculate = function(self, card, context)
		if context.main_scoring and context.cardarea == G.play and card and card.ability.seal then
			local negativeroll = SMODS.pseudorandom_probability(context.other_card or card or self, "sealseal", 1, card.ability.seal.odds)
			return {
				func = function()
					local createnegative = false
					if G.GAME.used_vouchers['v_toga_caniofferyouanegg'] == true or (negativeroll and G.GAME.used_vouchers['v_toga_sealegg'] == true) then createnegative = true end
					if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit or createnegative then
						G.GAME.joker_buffer = G.GAME.joker_buffer + 1
						G.E_MANAGER:add_event(Event({
							func = function()
								local egg = SMODS.create_card({ set = 'Joker', key = 'j_egg', no_edition = createnegative and true or false }) -- egg.
								if createnegative then egg:set_edition('e_negative', true, true) end
								egg:add_to_deck()
								G.jokers:emplace(egg)
								G.GAME.joker_buffer = math.max(G.GAME.joker_buffer - 1, 0)
								return true
							end
						}))
					end
				end
			}
		end
	end,
}

SMODS.Seal{
	key = 'urlseal',
	badge_colour = HEX("0000ff"),
	atlas = "TOGASeals",
	pos = { x = 1, y = 0 },
	sound = { sound = "gold_seal", per = 1.2, vol = 0.4 }
}