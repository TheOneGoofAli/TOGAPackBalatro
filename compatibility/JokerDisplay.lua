if SMODS.Mods["JokerDisplay"] and SMODS.Mods["JokerDisplay"].can_load then
	if JokerDisplay then
		local jd_def = JokerDisplay.Definitions

		jd_def["j_toga_theinternet"] = {
			text = {
				{ text = "+" },
				{ ref_table = "card.ability.extra", ref_value = "curchips", retrigger_type = "mult" }
			},
			text_config = { colour = G.C.CHIPS },
		}

		jd_def["j_toga_speedsneakers"] = {
			text = {
				{
					border_nodes = {
						{ text = "X" },
						{ ref_table = "card.joker_display_values", ref_value = "xmult" },
					}
				}
			},
			calc_function = function(card)
				local total = togabalatro.gethowmuch(card.ability.extra.dollars, card.ability.extra.xmultpart)*card.ability.extra.xmultpart
				card.joker_display_values.xmult = to_big(1)+to_big(total) > to_big(1) and to_big(1)+to_big(total) or to_big(1)
			end,
		}

		jd_def["j_toga_controlpanel"] = {
			text = {
				{ text = "+$" },
				{ ref_table = "card.joker_display_values", ref_value = "totalmoney" },
			},
			text_config = { colour = G.C.GOLD },

			calc_function = function(card)
				card.joker_display_values.totalmoney = math.ceil(card.ability.extra.totalmoney)
			end,
		}

		jd_def["j_toga_useraccounts"] = {
			text = {
				{
					border_nodes = {
						{ text = "X" },
						{ ref_table = "card.ability.extra", ref_value = "totalXmult" },
					}
				}
			},
			extra = {
				{
					{ text = "(" },
					{ ref_table = "card.joker_display_values", ref_value = "odds" },
					{ text = ")" },
				}
			},
			extra_config = { colour = G.C.GREEN, scale = 0.3 },

			calc_function = function(card)
				card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { SMODS.get_probability_vars(card, 1, card.ability.extra.odds), card.ability.extra.odds } }
			end,
		}

		jd_def["j_toga_cpu"] = {
			text = {
				{ text = "+" },
				{ ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
			},
			text_config = { colour = G.C.MULT },
			calc_function = function(card)
				local cores = love.system.getProcessorCount() or 1
				card.joker_display_values.mult = cores * card.ability.extra.coremult
			end,
		}

		jd_def["j_toga_pcmcia"] = {
			text = {
				{
					border_nodes = {
						{ text = "X" },
						{ ref_table = "card.ability.extra", ref_value = "xmult" },
					}
				}
			},
		}

		jd_def["j_toga_jokersrb2kart"] = {
			text = {
				{
					border_nodes = {
						{ text = "X" },
						{ ref_table = "card.ability.extra", ref_value = "Xmult_current" },
					}
				}
			},
		}

		jd_def["j_toga_y2kbug"] = {
			text = {
				{ text = "+",                              colour = G.C.CHIPS },
				{ ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS, retrigger_type = "mult" },
				{ text = " +",                             colour = G.C.MULT },
				{ ref_table = "card.joker_display_values", ref_value = "mult",  colour = G.C.MULT,  retrigger_type = "mult" }
			},
			reminder_text = {
				{ text = "(" },
				{ ref_table = "card.joker_display_values", ref_value = "localized_text_king",  colour = G.C.ORANGE },
				{ text = ", " },
				{ text = "2", colour = G.C.ORANGE },
				{ text = ")" },
			},
			calc_function = function(card)
				local chips, mult = 0, 0
				local text, _, scoring_hand = JokerDisplay.evaluate_hand()
				local hand = JokerDisplay.current_hand
				local twopresent, kingpresent = false, false

				if text ~= "Unknown" then
					for _, current_card in pairs(hand) do
						if current_card:get_id() then
							if current_card:get_id() == 2 then
								twopresent = true
							end
							if current_card:get_id() == 13 then
								kingpresent = true
							end
						end
					end
					
					for _, scoring_card in pairs(scoring_hand) do
						if twopresent and kingpresent then
							local retriggers = JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
							chips = chips + card.ability.extra.chips * retriggers
							mult = mult + card.ability.extra.mult * retriggers
						end
					end
				end
				card.joker_display_values.chips = chips
				card.joker_display_values.mult = mult

				card.joker_display_values.localized_text_king = localize("King", "ranks")
			end
		}

		jd_def["j_toga_taskmgr"] = {
			reminder_text = {
				{ text = "(" },
				{ ref_table = "card.joker_display_values", ref_value = "active" },
				{ text = ")" },
			},
			calc_function = function(card)
				card.joker_display_values.active = (G.GAME and G.GAME.current_round.discards_left == 1 and localize("jdis_active") or localize("jdis_inactive"))
			end
		}

		jd_def["j_toga_recyclebin"] = {
			text = {
				{
					border_nodes = {
						{ text = "X" },
						{ ref_table = "card.ability.extra", ref_value = "xchip_mod" },
					},
					border_colour = G.C.CHIPS
				}
			},
		}

		jd_def["j_toga_virtualpc"] = {
			extra = {
				{
					{ text = "(" },
					{ ref_table = "card.joker_display_values", ref_value = "odds" },
					{ text = ")" },
				}
			},
			extra_config = { colour = G.C.GREEN, scale = 0.3 },

			calc_function = function(card)
				card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { SMODS.get_probability_vars(card, 1, card.ability.extra.odds), card.ability.extra.odds } }
			end,
		}

	end
end