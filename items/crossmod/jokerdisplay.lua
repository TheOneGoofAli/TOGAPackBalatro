-- Originally from https://github.com/TheOneGoofAli/TOGAPackBalatro/pull/11
sendInfoMessage("Initializing JokerDisplay compatibility...", "TOGAPack")
togabalatro.jd_def = JokerDisplay.Definitions

togabalatro.jd_def["j_toga_y2kbug"] = {
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
		card.joker_display_values.twos = twopresent
		card.joker_display_values.kings = kingpresent

		card.joker_display_values.localized_text_king = localize("King", "ranks")
	end,
	style_function = function(card, text, reminder_text, extra)
		if reminder_text and reminder_text.children[1] and reminder_text.children[2] and reminder_text.children[4] and card.joker_display_values then
			reminder_text.children[2].config.colour = card.joker_display_values.kings and G.C.FILTER or G.C.UI.TEXT_INACTIVE
			reminder_text.children[4].config.colour = card.joker_display_values.twos and G.C.FILTER or G.C.UI.TEXT_INACTIVE
		end
		return false
	end
}

togabalatro.jd_def["j_toga_controlpanel"] = {
	text = {
		{ text = "+$" },
		{ ref_table = "card.joker_display_values", ref_value = "totalmoney" },
	},
	text_config = { colour = G.C.GOLD },
	calc_function = function(card)
		card.joker_display_values.totalmoney = math.ceil(card.ability.extra.totalmoney)
	end,
}

togabalatro.jd_def["j_toga_taskmgr"] = {
	reminder_text = {
		{ text = "(" },
		{ ref_table = "card.joker_display_values", ref_value = "active" },
		{ text = ")" },
	},
	calc_function = function(card)
		card.joker_display_values.active = (G.GAME and G.GAME.current_round.discards_left == 1 and localize("jdis_active") or localize("jdis_inactive"))
	end
}

togabalatro.jd_def["j_toga_useraccounts"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.ability.extra", ref_value = "totalXmult", retrigger_type = "exp" },
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

togabalatro.jd_def["j_toga_virtualmemory"] = {
	text = {
		{ ref_table = "card.joker_display_values", ref_value = "odds" },
	},
	text_config = { colour = G.C.GREEN, scale = 0.4 },
	calc_function = function(card)
		card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { SMODS.get_probability_vars(card, 1, card.ability.extra.odds) } }
	end,
}

togabalatro.jd_def["j_toga_recyclebin"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.ability.extra", ref_value = "xchip_mod", retrigger_type = "exp" },
			},
			border_colour = G.C.CHIPS
		}
	},
}

togabalatro.jd_def["j_toga_theinternet"] = {
	text = {
		{ text = "+" },
		{ ref_table = "card.ability.extra", ref_value = "curchips", retrigger_type = "mult" }
	},
	text_config = { colour = G.C.CHIPS },
}

togabalatro.jd_def["j_toga_virtualpc"] = {
	text = {
		{ text = "+", colour = G.C.MULT },
		{ ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult", colour = G.C.MULT },
	},
	reminder_text = {
		{ text = "(+" },
		{ ref_table = "card.joker_display_values", ref_value = "gainmult" },
		{ text = ")" },
	},
	calc_function = function(card)
		card.joker_display_values.mult = card.ability.extra.mult
		card.joker_display_values.gainmult = togabalatro.shopitemcost()*card.ability.extra.itemmult
	end,
}

togabalatro.jd_def["j_toga_skype"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" },
			},
		},
	},
	reminder_text = {
		{ text = "(" },
		{ ref_table = "card.joker_display_values", ref_value = "modcount" },
		{ text = ")" },
	},
	calc_function = function(card)
		local _, modcount = togabalatro.checkownedmoditems()
		card.joker_display_values.xmult = modcount*card.ability.extra.permodxmult
		card.joker_display_values.modcount = modcount
	end,
}

local msncount = false

togabalatro.jd_def["j_toga_msn"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" },
			},
		},
	},
	reminder_text = {
		{ text = "(" },
		{ ref_table = "card.joker_display_values", ref_value = "enhcount" },
		{ text = ")" },
	},
	calc_function = function(card)
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
		card.joker_display_values.xmult = card.ability.extra.perenhxmult^enhcount
		card.joker_display_values.enhcount = enhcount
	end,
}

togabalatro.jd_def["j_toga_drivespace"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "reduction", retrigger_type = "exp" },
			},
			border_colour = G.C.FILTER
		},
	},
	calc_function = function(card)
		local reduce = 1
		local text, _, scoring_hand = JokerDisplay.evaluate_hand()

		for _, scoring_card in pairs(scoring_hand) do
			local retriggers = JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
			reduce = reduce * (card.ability.extra.reduce ^ retriggers)
		end
		
		card.joker_display_values.reduction = reduce
	end
}

togabalatro.jd_def["j_toga_netscapenavigator"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
			}
		}
	},
	calc_function = function(card)
		local playing_hand, jokers = next(G.hand.cards), G.jokers.cards
		local count = 0
		for _, playing_card in ipairs(G.hand.cards) do
			if playing_hand or not playing_card.highlighted then
				if not (playing_card.facing == 'back') and not playing_card.debuff and playing_card.edition and playing_card.edition.holo then
					count = count + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
				end
			end
		end
		for _, j in ipairs(jokers) do
			if not j.debuff and j.edition and j.edition.holo then
				count = count + 1
			end
		end
		card.joker_display_values.xmult = card.ability.extra.holoxmult ^ count
	end
}

togabalatro.jd_def["j_toga_tempinternetfiles"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.ability.extra", ref_value = "curxmult", retrigger_type = "exp" },
			},
		},
	},
	reminder_text = {
		{ text = "(" },
		{ text = localize('Flush', 'poker_hands'), colour = G.C.RED },
		{ text = ")" },
	},
}

togabalatro.jd_def["j_toga_regedit"] = {
	text = {
		{ ref_table = "card.joker_display_values", ref_value = "suit", colour = G.C.FILTER },
	},
	reminder_text = {
		{ text = "(" .. localize("k_round") .. ")" },
	},
	calc_function = function(card)
		card.joker_display_values.suit = localize(G.GAME.current_round.togabalatro and G.GAME.current_round.togabalatro.regedit and G.GAME.current_round.togabalatro.regedit.suit or "Hearts", 'suits_plural')
	end
}

togabalatro.jd_def["j_toga_certserver"] = {
	text = {
		{ ref_table = "card.joker_display_values", ref_value = "rank", colour = G.C.FILTER },
	},
	reminder_text = {
		{ text = "(" .. localize("k_round") .. ")" },
	},
	calc_function = function(card)
		card.joker_display_values.rank = localize((G.GAME.current_round.togabalatro and G.GAME.current_round.togabalatro.certserver or {}).rank or "Ace", 'ranks')
	end
}

togabalatro.jd_def["j_toga_drwatson"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "curxmult", retrigger_type = "exp" },
			},
		},
		{
			border_nodes = {
				{ text = "+X" },
				{ ref_table = "card.joker_display_values", ref_value = "addxmult", retrigger_type = "mult" },
			},
		},
	},
	reminder_text = {
		{ ref_table = "card.joker_display_values", ref_value = "active_text" },
	},
	calc_function = function(card)
		local addxmult = 0
		local text, poker_hands, scoring_hand = JokerDisplay.evaluate_hand()
		local boss_active = G.GAME and G.GAME.blind and G.GAME.blind.get_type and
			((not G.GAME.blind.disabled) and (G.GAME.blind:get_type() == 'Boss'))
		card.joker_display_values.active = boss_active

		if card.joker_display_values.active then
			local triggers_blind = JokerDisplay.triggers_blind(G.GAME.blind, text, poker_hands, scoring_hand,
				JokerDisplay.current_hand)
			if triggers_blind then
				addxmult = card.ability.extra.trigxmult
			else
				addxmult = 0
			end
		else
			addxmult = 0
		end
		card.joker_display_values.curxmult = 1+card.ability.extra.curxmult
		card.joker_display_values.addxmult = addxmult
		card.joker_display_values.active_text = localize(boss_active and 'k_active' or 'ph_no_boss_active')
	end,
	style_function = function(card, text, reminder_text, extra)
		if reminder_text and reminder_text.children[1] and card.joker_display_values then
			reminder_text.children[1].config.colour = card.joker_display_values.active and G.C.GREEN or
				G.C.RED
			reminder_text.children[1].config.scale = card.joker_display_values.active and 0.35 or 0.3
			return true
		end
		return false
	end
}

togabalatro.jd_def["j_toga_fontsfolder"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" },
			}
		}
	},
	calc_function = function(card)
		local fontamount = togabalatro.getexternalfontcount()
		if next(togabalatro.externalfontsloaded) and fontamount > 0 then
			card.joker_display_values.xmult = card.ability.extra.perfontxmult*fontamount
		else
			card.joker_display_values.xmult = "???"
		end
	end,
}

togabalatro.jd_def["j_toga_pcmcia"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" },
				{ text = "?" },
			},
		},
	},
}

togabalatro.jd_def["j_toga_cpu"] = {
	text = {
		{ text = "+" },
		{ ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
	},
	text_config = { colour = G.C.MULT },
	calc_function = function(card)
		card.joker_display_values.mult = card.ability.extra.coremult * (togabalatro.curcpucount or love.system.getProcessorCount() or 1)
	end,
}

togabalatro.jd_def["j_toga_ups"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" },
			}
		}
	},
	calc_function = function(card)
		card.joker_display_values.xmult = 1+card.ability.extra.bonusxmult
	end,
}

togabalatro.jd_def["j_toga_activesync"] = {
	extra = {
		{
			{ text = "(" },
			{ ref_table = "card.joker_display_values", ref_value = "odds" },
			{ text = ")" },
		}
	},
	extra_config = { colour = G.C.GREEN, scale = 0.3 },
	calc_function = function(card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'space')
		card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
	end,
}

togabalatro.jd_def["j_toga_hammer"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" },
			}
		}
	},
	calc_function = function(card)
		local playing_hand = next(G.play.cards)
		local totalxmult = 1
		for _, playing_card in ipairs(G.hand.cards) do
			if playing_hand or not playing_card.highlighted then
				if not (playing_card.facing == 'back') and not playing_card.debuff and SMODS.has_enhancement(playing_card, "m_glass") then
					totalxmult = totalxmult * ((playing_card.ability or G.P_CENTERS['m_glass'].config).Xmult * JokerDisplay.calculate_card_triggers(playing_card, true))
				end
			end
		end
		card.joker_display_values.xmult = totalxmult
	end,
}

togabalatro.jd_def["j_toga_wscript"] = {
	extra = {
		{
			{ text = "(" },
			{ ref_table = "card.joker_display_values", ref_value = "odds", retrigger_type = "exp" },
			{ text = ")" },
		}
	},
	extra_config = { colour = G.C.GREEN, scale = 0.3 },
	calc_function = function(card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, '8ball')
		card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
	end
}

togabalatro.jd_def["j_toga_notsosmileyface"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" },
			}
		}
	},
}

togabalatro.jd_def["j_toga_gamecontrollers"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" },
			}
		},
		{ text = " (", colour = G.C.UI.TEXT_INACTIVE },
		{ ref_table = "card.joker_display_values", ref_value = "gc", colour = G.C.UI.TEXT_INACTIVE },
		{ text = ")", colour = G.C.UI.TEXT_INACTIVE },
	},
	calc_function = function(card)
		local gc = love.joystick.getJoystickCount()
		card.joker_display_values.xmult = gc > 0 and card.ability.extra.xmult*gc or 1
		card.joker_display_values.gc = gc
	end,
}

togabalatro.jd_def["j_toga_wincatalog"] = {
	mod_function = function(card, mod_joker)
		return { mult = card ~= mod_joker and card.config.center.rarity == 1 and mod_joker.ability.extra.mult*JokerDisplay.calculate_joker_triggers(mod_joker) or nil }
	end
}

togabalatro.jd_def["j_toga_jimbo95"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.ability.extra", ref_value = "x_chips", retrigger_type = "exp" },
			},
			border_colour = G.C.CHIPS
		},
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "exp" },
			}
		}
	},
	calc_function = function(card)
		card.joker_display_values.h_size = (to_number(card.ability.extra.h_size) > 0 and "+"..to_number(card.ability.extra.h_size) or to_number(card.ability.extra.h_size)).." "
	end,
	retrigger_joker_function = function(card, retrigger_joker)
		return card.config.center.key ~= retrigger_joker.config.center.key and math.floor(retrigger_joker.ability.extra.retriggers)
	end
}

togabalatro.jd_def["j_toga_win98"] = {
	text = {
		{ text = "+",	colour = G.C.MULT },
		{ ref_table = "card.joker_display_values", ref_value = "totalmult", colour = G.C.MULT, retrigger_type = "mult" }
	},
	reminder_text = {
		{ text = "(" },
		{ text = "+", colour = G.C.MULT },
		{ ref_table = "card.joker_display_values", ref_value = "basemult", colour = G.C.MULT, retrigger_type = "mult" },
		{ text = ", " },
		{ text = "+", colour = G.C.ORANGE },
		{ ref_table = "card.joker_display_values", ref_value = "totalconsslotbonus", colour = G.C.ORANGE },
		{ text = "%", colour = G.C.ORANGE },
		{ text = ")" },
	},
	calc_function = function(card)
		local jkrval = togabalatro.gettotaljokervalue()*card.ability.extra.percentage
		local consbonus = jkrval*togabalatro.getconscount()*card.ability.extra.consslotbonus or 0
		card.joker_display_values.basemult = jkrval
		card.joker_display_values.totalconsslotbonus = togabalatro.getconscount()*card.ability.extra.consslotbonus*100
		card.joker_display_values.totalmult = (jkrval + consbonus)*JokerDisplay.calculate_joker_triggers(card)
	end
}

togabalatro.jd_def["j_toga_winmillenium"] = {
	text = {
		{ text = "(", colour = G.C.UI.TEXT_INACTIVE },
		{ text = "+", colour = G.C.CHIPS },
		{ ref_table = "card.ability.extra", ref_value = "basechips", colour = G.C.CHIPS },
		{ text = ", ", colour = G.C.UI.TEXT_INACTIVE },
		{ text = "+", colour = G.C.CHIPS },
		{ ref_table = "card.joker_display_values", ref_value = "bonuschips", colour = G.C.CHIPS },
		{ text = "x", colour = G.C.ORANGE },
		{ ref_table = "card.joker_display_values", ref_value = "vouchcount", colour = G.C.ORANGE },
		{ text = ")", colour = G.C.UI.TEXT_INACTIVE },
	},
	calc_function = function(card)
		local nerfy = togabalatro.config.UseNerfed and 0.2 or 1
		local vouchcount = G.vouchers and G.vouchers.cards and #G.vouchers.cards or 0
		card.joker_display_values.vouchcount = vouchcount
		card.joker_display_values.bonuschips = (card.ability.extra.chipbonus*nerfy)
		card.joker_display_values.totalchips = card.ability.extra.basechips + (card.ability.extra.chipbonus*nerfy)*vouchcount
	end,
	mod_function = function(card, mod_joker)
		return { chips = card ~= mod_joker and mod_joker.ability.extra.totalbonus*JokerDisplay.calculate_joker_triggers(mod_joker) or nil }
	end
}

togabalatro.jd_def["j_toga_winnt4"] = {
	retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
		if held_in_hand then return 0 end
		return not playing_card:is_face() and joker_card.ability.extra.repetitions * JokerDisplay.calculate_joker_triggers(joker_card) or 0
	end
}

togabalatro.jd_def["j_toga_winxp"] = {
	text = {
		{
			border_nodes = {
				{ text = "X2" },
			},
			border_colour = G.C.SECONDARY_SET.Planet
		},
		{ text = " "},
		{ text = "(", colour = G.C.GREEN, scale = 0.3 },
		{ ref_table = "card.joker_display_values", ref_value = "odds", colour = G.C.GREEN, scale = 0.3 },
		{ text = ")", colour = G.C.GREEN, scale = 0.3 },
	},
	calc_function = function(card)
		card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { SMODS.get_probability_vars(card, 1, card.ability.extra.odds) } }
	end,
}

togabalatro.jd_def["j_toga_winvista"] = {
	text = {
		{ ref_table = "card.joker_display_values", ref_value = "readytext" }
	},
	reminder_text = {
		{ text = "(6)", scale = 0.35 },
	},
	calc_function = function(card)
		local _, _, scoring_hand = JokerDisplay.evaluate_hand()
		local vista = #scoring_hand == 1 and scoring_hand[1]:get_id() == 6
		card.joker_display_values.active = G.GAME and G.GAME.current_round.hands_played == 0
		
		local editioned = 0
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i].edition and not G.jokers.cards[i].edition.negative then editioned = editioned + 1 end
		end
		card.joker_display_values.ready = card.joker_display_values.active and card.ability.extra.active and editioned > 0 and vista or false
		card.joker_display_values.readytext = card.joker_display_values.ready and "!" or "..."
	end,
	style_function = function(card, text, reminder_text, extra)
		if text and text.children[1] then
			text.children[1].config.colour = card.joker_display_values.active and card.joker_display_values.ready and G.C.DARK_EDITION or G.C.UI.TEXT_INACTIVE
		end
		return false
	end
}

togabalatro.jd_def["j_toga_win7"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "hxmult", retrigger_type = "exp" },
			}
		}
	},
	reminder_text = {
		{
			border_nodes = {
				{ text = "X", colour = G.C.UI.TEXT_LIGHT },
				{ ref_table = "card.ability.extra", ref_value = "x_mult", colour = G.C.UI.TEXT_LIGHT },
			}
		},
		{ text = "x", colour = G.C.UI.TEXT_LIGHT},
		{ ref_table = "card.joker_display_values", ref_value = "constypes", colour = G.C.FILTER},
	},
	calc_function = function(card)
		local constypecount = 0
		local houseofcommons = {}
		if G.consumeables and #G.consumeables.cards > 0 then
			for i = 1, #G.consumeables.cards do
				if G.consumeables.cards[i].ability.consumeable and not houseofcommons[G.consumeables.cards[i].ability.set] then houseofcommons[G.consumeables.cards[i].ability.set] = true end
			end
		end
		if next(houseofcommons) then
			for _, _ in pairs(houseofcommons) do
				constypecount = constypecount + 1
			end
		end
		card.joker_display_values.constypes = constypecount
		local playing_hand = next(G.play.cards)
		local count = 0
		for _, playing_card in ipairs(G.hand.cards) do
			if playing_hand or not playing_card.highlighted then
				if not (playing_card.facing == 'back') and not playing_card.debuff and playing_card:get_id() and playing_card:get_id() == 7 then
					count = count + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
				end
			end
		end
		card.joker_display_values.hxmult = (card.ability.extra.x_mult^constypecount)^count
	end,
}

togabalatro.jd_def["j_toga_mac_os_9"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }
			}
		}
	},
	calc_function = function(card)
		local playing_hand = next(G.play.cards)
		local count = 0
		for _, playing_card in ipairs(G.hand.cards) do
			if playing_hand or not playing_card.highlighted then
				if not (playing_card.facing == 'back') and not playing_card.debuff and playing_card:is_suit('Clubs') then
					count = count + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
				end
			end
		end
		card.joker_display_values.x_mult = card.ability.extra.hxmult ^ count
	end
}

togabalatro.jd_def["j_toga_mac_os_x"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "x_chips", retrigger_type = "exp" }
			},
			border_colour = G.C.CHIPS
		}
	},
	calc_function = function(card)
		local playing_hand = next(G.play.cards)
		local count = 0
		for _, playing_card in ipairs(G.hand.cards) do
			if playing_hand or not playing_card.highlighted then
				if not (playing_card.facing == 'back') and not playing_card.debuff and playing_card:get_id() and playing_card:get_id() == 10 then
					count = count + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
				end
			end
		end
		card.joker_display_values.x_chips = card.ability.extra.hxchips ^ count
	end
}

togabalatro.jd_def["j_toga_linux_ubuntu"] = {
	mod_function = function(card, mod_joker)
		return { x_mult = card ~= mod_joker and 1+card.sell_cost*mod_joker.ability.extra.percentage or nil }
	end
}

togabalatro.jd_def["j_toga_linux_slackware"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }
			}
		},
	},
	reminder_text = {
		{
			border_nodes = {
				{ text = "+X", colour = G.C.UI.TEXT_LIGHT },
				{ ref_table = "card.joker_display_values", ref_value = "percardxm", colour = G.C.UI.TEXT_LIGHT }
			}
		},
		{ text = "x"},
		{ ref_table = "card.joker_display_values", ref_value = "suitbonus", colour = G.C.FILTER},
	},
	calc_function = function(card)
		local text, _, scoring_hand = JokerDisplay.evaluate_hand()
		local hand = JokerDisplay.current_hand
		local totalxmult, percard, suits = 1, card.ability.extra.persuit, 0
		
		if text ~= "Unknown" then
			local usuits, usuitscount = {}, 0
			for _, ccard in pairs(hand) do
				if ccard and not usuits[ccard.base.suit] then usuits[ccard.base.suit] = true; usuitscount = usuitscount + 1 end
			end
			
			if usuitscount >= 2 then
				suits = usuitscount - 1
				local cumuxmult = 1+card.ability.extra.persuit*suits
				for _, scoring_card in pairs(scoring_hand) do
					local retriggers = JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
					totalxmult = totalxmult * (cumuxmult ^ retriggers)
				end
			end
		end
		
		card.joker_display_values.x_mult = totalxmult
		card.joker_display_values.percardxm = percard
		card.joker_display_values.suitbonus = suits
	end
}

togabalatro.jd_def["j_toga_linux_redhat"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }
			}
		},
	},
	reminder_text = {
		{
			border_nodes = {
				{ text = "+X", colour = G.C.UI.TEXT_LIGHT },
				{ ref_table = "card.ability.extra", ref_value = "phandscale", colour = G.C.UI.TEXT_LIGHT }
			}
		},
		{ text = "x"},
		{ ref_table = "card.joker_display_values", ref_value = "phands", colour = G.C.FILTER},
	},
	calc_function = function(card)
		local _, phands, scoring_hand = JokerDisplay.evaluate_hand()
		local phandcount = 0
		
		if text ~= "Unknown" then
			for k, v in pairs(phands) do
				if k ~= 'High Card' and next(v) ~= nil then phandcount = phandcount + 1 end
			end
		end
		
		card.joker_display_values.x_mult = 1+card.ability.extra.xmbonus
		card.joker_display_values.phands = phandcount
	end
}

togabalatro.jd_def["j_toga_rover"] = {
	reminder_text = {
		{ ref_table = "card.joker_display_values", ref_value = "cards", scale = 0.3, colour = G.C.FILTER },
		{ text = "x", scale = 0.3 },
		{ text = "(", scale = 0.3, colour = G.C.GREEN },
		{ ref_table = "card.joker_display_values", ref_value = "odds", scale = 0.3, colour = G.C.GREEN },
		{ text = ")", scale = 0.3, colour = G.C.GREEN },
	},
	calc_function = function(card)
		card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { SMODS.get_probability_vars(card, 1, card.ability.extra.odds), card.ability.extra.odds } }
		card.joker_display_values.cards = G.deck and G.deck.cards and #G.deck.cards or 0
	end,
}

togabalatro.jd_def["j_toga_solitairejoker"] = {
	extra = {
		{
			{ ref_table = "card.joker_display_values", ref_value = "cards", scale = 0.3, colour = G.C.UI.TEXT_INACTIVE },
			{ text = "x", scale = 0.3, colour = G.C.UI.TEXT_INACTIVE },
		}
	},
	text = {
		{ ref_table = "card.joker_display_values", ref_value = "rank" }
	},
	reminder_text = {
		{ text = "(" },
		{ text = localize("Straight", "poker_hands") },
		{ text = ")" },
	},
	calc_function = function(card)
		local _, phands, _ = JokerDisplay.evaluate_hand()
		local rankcard = 0
		for _, v in pairs(G.deck.cards) do
			if v:get_id() == (G.GAME.current_round.togabalatro and G.GAME.current_round.togabalatro.solitaire or {}).id then rankcard = rankcard + 1 end
		end
		card.joker_display_values.active = next(phands) and next(phands['Straight']) and true or false
		card.joker_display_values.cards = rankcard
		card.joker_display_values.rank = localize((G.GAME.current_round.togabalatro and G.GAME.current_round.togabalatro.solitaire or {}).rank or "Ace", 'ranks')
	end,
	style_function = function(card, text, reminder_text, extra)
		if reminder_text and reminder_text.children[1] and reminder_text.children[2] and card.joker_display_values then
			reminder_text.children[2].config.colour = card.joker_display_values.active and G.C.FILTER or G.C.UI.TEXT_INACTIVE
		end
		return false
	end
}

togabalatro.jd_def["j_toga_jokersrb2kart"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.ability.extra", ref_value = "Xmult_current", retrigger_type = "exp" },
			}
		}
	},
}

togabalatro.jd_def["j_toga_asterism"] = {
	text = {
		{ text = "+",	colour = G.C.MULT },
		{ ref_table = "card.joker_display_values", ref_value = "curmult", colour = G.C.MULT, retrigger_type = "mult" }
	},
	reminder_text = {
		{ text = "+", colour = G.C.MULT },
		{ ref_table = "card.joker_display_values", ref_value = "basemult", colour = G.C.MULT },
		{ text = "x" },
		{ ref_table = "card.joker_display_values", ref_value = "planetsused", colour = G.C.SECONDARY_SET.Planet },
	},
	calc_function = function(card)
		card.joker_display_values.curmult = card.ability.extra.curmult
		card.joker_display_values.basemult = card.ability.extra.bonusmult
		card.joker_display_values.planetsused = G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.planet or 0
	end
}

togabalatro.jd_def["j_toga_mcanvil"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
			}
		},
	},
	reminder_text = {
		{
			border_nodes = {
				{ text = "+X", colour = G.C.UI.TEXT_LIGHT },
				{ ref_table = "card.joker_display_values", ref_value = "steelxmult", colour = G.C.UI.TEXT_LIGHT }
			}
		},
		{ text = " (" },
		{ ref_table = "card.joker_display_values", ref_value = "steels" },
		{ text = ")" },
	},
	calc_function = function(card)
		local _, _, hand = JokerDisplay.evaluate_hand()
		local steels, isleftmost = 0, false
		if G.jokers then
			local anvils = {}
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].config.center.key == "j_toga_mcanvil" then table.insert(anvils, G.jokers.cards[i]); break end
			end
			if anvils[1] and anvils[1] == card then isleftmost = true end
		end
		if isleftmost then
			for _, v in pairs(hand) do
				if v.config.center.key == 'm_steel' and not v.debuff then steels = steels + 1 end
			end
		end
		card.joker_display_values.steels = steels
		card.joker_display_values.steelxmult = steels*card.ability.extra.steelxmult
		card.joker_display_values.xmult = 1+card.ability.extra.curxmult
	end
}

togabalatro.jd_def["j_toga_spacecadetpinball"] = {
	text = {
		{ text = "1", colour = G.C.FILTER },
		{ text = "+" },
		{ text = "$", colour = G.C.MONEY },
		{ ref_table = "card.joker_display_values", ref_value = "threshold", colour = G.C.MONEY },
		{ text = "x" },
		{ ref_table = "card.joker_display_values", ref_value = "rescores" },
	},
	reminder_text = {
		{ text = "(", scale = 0.3, colour = G.C.GREEN },
		{ ref_table = "card.joker_display_values", ref_value = "odds", scale = 0.3, colour = G.C.GREEN },
		{ text = ")", scale = 0.3, colour = G.C.GREEN },
	},
	calc_function = function(card)
		card.joker_display_values.threshold = card.ability.extra.cashpoint
		card.joker_display_values.rescores = togabalatro.cashpointmulitple(card.ability.extra.cashpoint)
		card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { SMODS.get_probability_vars(card, 1, 3) } }
	end,
	style_function = function(card, text, reminder_text, extra)
		if text and text.children[1] and text.children[6] and card.joker_display_values then
			text.children[6].config.colour = to_number(card.joker_display_values.rescores) >= 1000 and to_number(card.joker_display_values.rescores) < 65535 and G.C.DARK_EDITION
											 or to_number(card.joker_display_values.rescores) == 65535 and G.C.EDITION or G.C.UI.TEXT_LIGHT
		end
		return false
	end
}

togabalatro.jd_def["j_toga_pso2ironwill"] = {
	text = {
		{ ref_table = "card.joker_display_values", ref_value = "active" },
	},
	calc_function = function(card)
		card.joker_display_values.active = card.ability.extra.skillactive and (to_big(G.GAME.dollars) > to_big(0) and localize('toga_pso2ironwillready') or localize('toga_pso2ironwillinactive')) or localize('toga_pso2ironwillrecharge')
	end,
	style_function = function(card, text, reminder_text, extra)
		if text and text.children[1] and text.children[1] and card.joker_display_values then
			text.children[1].config.colour = card.ability.extra.skillactive and to_big(G.GAME.dollars) > to_big(0) and G.C.FILTER or G.C.UI.TEXT_INACTIVE
		end
		return false
	end
}

togabalatro.jd_def["j_toga_jimboplus"] = {
	text = {
		{ text = "+", colour = G.C.PURPLE },
		{ ref_table = "card.joker_display_values", ref_value = "score", colour = G.C.PURPLE }
	},
	calc_function = function(card)
		card.joker_display_values.score = (G.GAME and G.GAME.blind and G.GAME.blind.chips or to_big(0))*card.ability.extra.leech or 0
	end,
}

togabalatro.jd_def["j_toga_speedsneakers"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" },
			}
		}
	},
	calc_function = function(card)
		local total = togabalatro.gethowmuch(card.ability.extra.dollars, card.ability.extra.xmultpart)*card.ability.extra.xmultpart
		card.joker_display_values.xmult = to_big(1)+to_big(total) > to_big(1) and to_big(1)+to_big(total) or to_big(1)
	end,
}

togabalatro.jd_def["j_toga_jarate"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.ability.extra", ref_value = "minicrit", retrigger_type = "exp" },
			},
			border_colour = G.C.FILTER
		}
	},
	reminder_text = {
		{ text = "(", scale = 0.3, colour = G.C.GREEN },
		{ ref_table = "card.joker_display_values", ref_value = "odds", scale = 0.3, colour = G.C.GREEN },
		{ text = ")", scale = 0.3, colour = G.C.GREEN },
	},
	calc_function = function(card)
		card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { SMODS.get_probability_vars(card, 1, card.ability.extra.odds) } }
	end,
}

togabalatro.jd_def["j_toga_tomscott"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" },
			},
		},
	},
	reminder_text = {
		{ text = "(" },
		{ ref_table = "card.joker_display_values", ref_value = "selfs" },
		{ text = ")" },
	},
	calc_function = function(card)
		card.joker_display_values.xmult = card.ability.extra.basexmult ^ togabalatro.calccopiesofself(card.config.center.key)
		card.joker_display_values.selfs = #SMODS.find_card(card.config.center.key)
	end,
}

togabalatro.jd_def["j_toga_michaelrosen"] = {
	text = {
		{ text = "(", scale = 0.3, colour = G.C.GREEN },
		{ ref_table = "card.joker_display_values", ref_value = "odds", scale = 0.3, colour = G.C.GREEN },
		{ text = ")", scale = 0.3, colour = G.C.GREEN },
	},
	calc_function = function(card)
		card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { SMODS.get_probability_vars(card, 1, card.ability.extra.odds) } }
	end,
}

togabalatro.jd_def["j_toga_whatisthis"] = {
	text = {
		{
			border_nodes = {
				{ text = "^^" },
				{ ref_table = "card.ability.extra", ref_value = "part" },
			},
			border_colour = G.C.MULT
		},
		{ text = "x" },
		{ ref_table = "card.joker_display_values", ref_value = "conss" },
	},
	calc_function = function(card)
		local cons = 0
		if G.consumeables and G.consumeables.cards and G.consumeables.cards[1] then
			for i = 1, #G.consumeables.cards do
				local stacked, stackamount = togabalatro.stackingcompat(G.consumeables.cards[i])
				if stacked then
					for i = 1, stackamount do cons = cons + 1 end
				else
					cons = cons + 1
				end
			end
		end
		card.joker_display_values.conss = cons or 0
	end,
}

togabalatro.jd_def["j_toga_quacksoft"] = {
	text = {
		{
			border_nodes = {
				{ text = "^" },
				{ ref_table = "card.joker_display_values", ref_value = "totalechips" },
			},
			border_colour = G.C.CHIPS
		},
	},
	reminder_text = {
		{ text = "(" },
		{ ref_table = "card.joker_display_values", ref_value = "fulldeckcards" },
		{ text = ")" },
	},
	calc_function = function(card)
		card.joker_display_values.totalechips = G.playing_cards and 1 + (card.ability.extra.cardechip*#G.playing_cards) or 1
		card.joker_display_values.fulldeckcards = G.playing_cards and #G.playing_cards or 0
	end,
}

togabalatro.jd_def["j_toga_rloctane"] = {
	text = {
		{ text = "+" },
		{ ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" }
	},
	text_config = { colour = G.C.MULT },
}

togabalatro.jd_def["j_toga_chrome"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" },
			},
		},
	},
	reminder_text = {
		{ text = "(" },
		{ ref_table = "card.joker_display_values", ref_value = "processes" },
		{ text = ")" },
	},
	calc_function = function(card)
		card.joker_display_values.xmult = card.ability.extra.totalxmult
		card.joker_display_values.processes = (togabalatro.processcounts or {}).chrome or '???'
	end,
}

togabalatro.jd_def["j_toga_firefox"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "xchips", retrigger_type = "exp" },
			},
			border_colour = G.C.CHIPS
		},
	},
	reminder_text = {
		{ text = "(" },
		{ ref_table = "card.joker_display_values", ref_value = "processes" },
		{ text = ")" },
	},
	calc_function = function(card)
		card.joker_display_values.xchips = card.ability.extra.totalxchips
		card.joker_display_values.processes = (togabalatro.processcounts or {}).firefox or '???'
	end,
}

togabalatro.jd_def["j_toga_desktop"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "curxmult", retrigger_type = "exp" },
			},
		},
	},
	calc_function = function(card)
		card.joker_display_values.curxmult = 1+card.ability.extra.curxmult
	end,
}

togabalatro.jd_def["j_toga_nonebattery"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp" },
			},
		},
	},
	reminder_text = {
		{ text = "(" },
		{ ref_table = "card.joker_display_values", ref_value = "battery" },
		{ text = ")" },
	},
	calc_function = function(card)
		card.joker_display_values.battery = love.system.getPowerInfo()
	end,
	style_function = function(card, text, reminder_text, extra)
		if reminder_text and reminder_text.children[1] and reminder_text.children[2] and card.joker_display_values then
			reminder_text.children[2].config.colour = card.joker_display_values.battery == 'nobattery' and G.C.FILTER or G.C.UI.TEXT_INACTIVE
		end
		return false
	end
}

togabalatro.jd_def["j_toga_dragndrop"] = {
	text = {
		{ text = "+",	colour = G.C.CHIPS },
		{ ref_table = "card.joker_display_values", ref_value = "curchips", colour = G.C.CHIPS, retrigger_type = "mult" },
		{ text = "/" },
		{ ref_table = "card.joker_display_values", ref_value = "cap", colour = G.C.CHIPS },
	},
	reminder_text = {
		{ text = "(" },
		{ ref_table = "card.joker_display_values", ref_value = "mbsize" },
		{ text = ")" },
	},
	calc_function = function(card)
		local ante, filesize = math.abs(to_number(G.GAME.round_resets.ante)) or 1, togabalatro.lastfilesize()
		card.joker_display_values.curchips = math.min(filesize/1048576, card.ability.extra.cap+card.ability.extra.antecaplift*ante)
		card.joker_display_values.cap = card.ability.extra.cap+card.ability.extra.antecaplift*ante
		card.joker_display_values.mbsize = togabalatro.round(filesize/1048576, 2) .. " " .. localize('toga_megabyte')
	end,
}

togabalatro.jd_def["j_toga_repairdisk"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
			}
		},
	},
	reminder_text = {
		{
			border_nodes = {
				{ text = "+X", colour = G.C.UI.TEXT_LIGHT },
				{ ref_table = "card.ability.extra", ref_value = "dxmult", colour = G.C.UI.TEXT_LIGHT }
			}
		},
		{ text = "/" },
		{ text = "$", colour = G.C.RED },
	},
	calc_function = function(card)
		card.joker_display_values.xmult = 1+card.ability.extra.curxmult
	end
}

togabalatro.jd_def["j_toga_merlin"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "curxmult", retrigger_type = "exp" },
			},
		},
	},
	calc_function = function(card)
		card.joker_display_values.curxmult = 1+card.ability.extra.curxmult
	end,
}

togabalatro.jd_def["j_toga_briefcase"] = {
	text = {
		{ text = "+", colour = G.C.CHIPS },
		{ ref_table = "card.joker_display_values", ref_value = "curchips", colour = G.C.CHIPS, retrigger_type = "mult" },
	},
	calc_function = function(card)
		local playing_hand = next(G.play.cards)
		local count = 0
		for _, playing_card in ipairs(G.hand.cards) do
			if playing_hand or not playing_card.highlighted then
				if not (playing_card.facing == 'back') and not playing_card.debuff then
					count = count + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
				end
			end
		end
		card.joker_display_values.curchips = card.ability.extra.curhchips*count
	end,
}

togabalatro.jd_def["j_toga_vga"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "curxmult", retrigger_type = "exp" },
			},
		},
	},
	reminder_text = {
		{ text = "(" },
		{ ref_table = "card.joker_display_values", ref_value = "res" },
		{ text = ")" },
	},
	calc_function = function(card)
		local cons = 0
		if G.consumeables and G.consumeables.cards and G.consumeables.cards[1] then
			for i = 1, #G.consumeables.cards do
				local stacked, stackamount = togabalatro.stackingcompat(G.consumeables.cards[i])
				if stacked then
					for i = 1, stackamount do cons = cons + 1 end
				else
					cons = cons + 1
				end
			end
		end
		local width, height = love.window.getMode()
		local is43 = togabalatro.check43(width, height)
		card.joker_display_values.active = is43
		card.joker_display_values.curxmult = is43 and card.ability.extra.xmult^cons or 1
		card.joker_display_values.res = width .. "x" .. height
	end,
	style_function = function(card, text, reminder_text, extra)
		if reminder_text and reminder_text.children[1] and reminder_text.children[2] and card.joker_display_values then
			reminder_text.children[2].config.colour = card.joker_display_values.active and G.C.DARK_EDITION or G.C.UI.TEXT_INACTIVE
		end
		return false
	end
}

togabalatro.jd_def["j_toga_mshome"] = {
	text = {
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "curxmult", retrigger_type = "exp" },
			},
		},
	},
	reminder_text = {
		{
			border_nodes = {
				{ text = "X", colour = G.C.UI.TEXT_LIGHT },
				{ ref_table = "card.joker_display_values", ref_value = "curscale", colour = G.C.UI.TEXT_LIGHT }
			},
			border_colour = G.C.FILTER
		},
	},
	calc_function = function(card)
		card.joker_display_values.curxmult = G.GAME and G.GAME.modifiers.scaling and 2*G.GAME.modifiers.scaling or 2
		card.joker_display_values.curscale = G.GAME and G.GAME.modifiers.scaling or 1
	end,
}

togabalatro.jd_def["j_toga_stoneroad"] = {
	text = {
		{ ref_table = "card.joker_display_values", ref_value = "count",   retrigger_type = "mult" },
		{ text = "x",                              scale = 0.35 },
		{ text = "$",                              colour = G.C.GOLD },
		{ ref_table = "card.ability.extra",        ref_value = "hm", colour = G.C.GOLD },
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
		local playing_hand = next(G.play.cards)
		local count = 0
		for _, playing_card in ipairs(G.hand.cards) do
			if playing_hand or not playing_card.highlighted then
				if playing_card.facing and not (playing_card.facing == 'back') and SMODS.has_enhancement(playing_card, 'm_stone') then
					count = count + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
				end
			end
		end
		card.joker_display_values.count = count
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
		card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
	end
}

-- MoreFluff crossmod
if next(SMODS.find_mod('MoreFluff')) and SMODS.Mods['MoreFluff'].config['Colour Cards'] then
	togabalatro.jd_def["j_toga_penwheel"] = {
		text = {
			{ text = "+$", colour = G.C.MONEY },
			{ ref_table = "card.joker_display_values", ref_value = "totalmoney", colour = G.C.MONEY }
		},
		reminder_text = {
			{ text = "(" .. localize("k_round") .. ")" },
		},
		calc_function = function(card)
			local money, totalmoney = card.ability.extra.percolormoney, 0
			if G.consumeables and G.consumeables.cards and G.consumeables.cards[1] then
				for i = 1, #G.consumeables.cards do
					if G.consumeables.cards[i].config.center.set == 'Colour' then
						local stacked, stackamount = togabalatro.stackingcompat(G.consumeables.cards[i])
						if stacked then
							for i = 1, stackamount do totalmoney = totalmoney + money end
						else
							totalmoney = totalmoney + money
						end
					end
				end
			end
			card.joker_display_values.totalmoney = totalmoney
		end,
	}
end

-- Balatro Goes Kino crossmod
if next(SMODS.find_mod('kino')) then
	togabalatro.jd_def["j_toga_netshow"] = {
		text = {
			{
				border_nodes = {
					{ text = "X" },
					{ ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }
				}
			},
		},
		reminder_text = {
			{
				border_nodes = {
					{ text = "+X", colour = G.C.UI.TEXT_LIGHT },
					{ ref_table = "card.joker_display_values", ref_value = "bonusxmult", colour = G.C.UI.TEXT_LIGHT }
				}
			},
			{ text = " (" },
			{ ref_table = "card.joker_display_values", ref_value = "count" },
			{ text = ")" },
		},
		calc_function = function(card)
			local curxmult, bonusxmult, count = card.ability.extra.bonusxmult, card.ability.extra.moviexmult, 0
			local uniquegenrest = {}
			if G.jokers then
				for i = 1, #G.jokers.cards do
					for k, v in pairs(kino_genres) do
						if is_genre(G.jokers.cards[i], v) and not uniquegenrest[v] then
							uniquegenrest[v] = true
							count = count + 1
						end
					end
				end
			end
			card.joker_display_values.x_mult = 1+curxmult
			card.joker_display_values.bonusxmult = card.ability.extra.moviexmult*count
			card.joker_display_values.count = count
		end,
	}
end

-- Revo's Vault crossmod
if next(SMODS.find_mod('RevosVault')) then
	togabalatro.jd_def["j_toga_printershare"] = {
		text = {
			{ text = "(", scale = 0.3, colour = G.C.GREEN },
			{ ref_table = "card.joker_display_values", ref_value = "odds", scale = 0.3, colour = G.C.GREEN },
			{ text = ")", scale = 0.3, colour = G.C.GREEN },
		},
		calc_function = function(card)
			card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { SMODS.get_probability_vars(card, 1, card.ability.extra.odds) } }
		end,
		mod_function = function(card, mod_joker)
			return { x_mult = card.config.center.rarity == "crv_p" and mod_joker.ability.extra.printxmult ^ JokerDisplay.calculate_joker_triggers(mod_joker) or nil }
		end
	}
end

-- Paya's Terrible Additions crossmod
if next(SMODS.find_mod('pta_saka')) then
	togabalatro.jd_def["j_toga_internetspades"] = {
		text = {
			{
				border_nodes = {
					{ text = "X" },
					{ ref_table = "card.joker_display_values", ref_value = "xchips", retrigger_type = "exp" }
				},
				border_colour = G.C.CHIPS
			},
			{ text = "x" },
			{ ref_table = "card.joker_display_values", ref_value = "conss", colour = G.C.FILTER },
			{ text = "x" },
			{ ref_table = "card.joker_display_values", ref_value = "aheads", colour = G.C.DARK_EDITION },
		},
		reminder_text = {
			{ text = "(" },
			{ text = localize("Spades", 'suits_plural') },
			{ text = ")" },
		},
		calc_function = function(card)
			local hand, allspades = JokerDisplay.current_hand, true
			if text ~= "Unknown" and #JokerDisplay.current_hand > 0 then
				for _, current_card in pairs(hand) do
					if not current_card:is_suit('Spades') then allspades = false; break end
				end
			else
				allspades = false
			end
			local aheads = 0
			if G.jokers then
				for i = 1, #G.jokers.cards do
					if G.jokers.cards[i].config.center.rarity == "payasaka_ahead" then aheads = aheads + 1 end
				end
			end
			local conscount = G.consumeables and G.consumeables.cards and G.consumeables.cards[1] and #G.consumeables.cards or 0
			local aheadready = allspades and aheads > 0
			card.joker_display_values.active = aheadready
			card.joker_display_values.xchips = aheadready and card.ability.extra.xchip or 1
			card.joker_display_values.conss = conscount
			card.joker_display_values.aheads = aheads
		end,
		style_function = function(card, text, reminder_text, extra)
			if reminder_text and reminder_text.children[1] and reminder_text.children[2] and card.joker_display_values then
				reminder_text.children[2].config.colour = card.joker_display_values.active and G.C.FILTER or G.C.UI.TEXT_INACTIVE
			end
			return false
		end
	}
end

if next(SMODS.find_mod('sdm0sstuff')) then
	togabalatro.jd_def["j_toga_spiceoflife"] = {
		text = {
			{ text = "(", scale = 0.3, colour = G.C.UI.TEXT_INACTIVE },
			{ ref_table = "card.joker_display_values", ref_value = "uniquebakery", scale = 0.3, colour = G.C.UI.TEXT_INACTIVE },
			{ text = ")", scale = 0.3, colour = G.C.UI.TEXT_INACTIVE },
		},
		calc_function = function(card)
			local bakedgoods, count = {}, 0
			if G.consumeables then
				for i = 1, #G.consumeables.cards do
					if G.consumeables.cards[i].ability.set == 'Bakery' and not bakedgoods[G.consumeables.cards[i].config.center.key] then
						bakedgoods[G.consumeables.cards[i].config.center.key] = true
					end
				end
				for k, v in pairs(bakedgoods) do
					count = count + 1
				end
			end
			card.joker_display_values.uniquebakery = count
		end,
	}
end

if next(SMODS.find_mod('Yahimod')) then
	togabalatro.jd_def["j_toga_horseconch"] = {
		text = {
            {
                border_nodes = {
                    { text = "X" },
                    { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }
                }
            },
			{ text = " +$", colour = G.C.MONEY },
			{ ref_table = "card.joker_display_values", ref_value = "h_money", colour = G.C.MONEY, retrigger_type = "mult" }
        },
        calc_function = function(card)
            local playing_hand = next(G.play.cards)
            local count = 0
            for _, playing_card in ipairs(G.hand.cards) do
                if playing_hand or not playing_card.highlighted then
                    if not (playing_card.facing == 'back') and not playing_card.debuff and playing_card.seal and playing_card.seal == "yahimod_horse_seal" then
                        count = count + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
                    end
                end
            end
            card.joker_display_values.x_mult = card.ability.extra.hxmult ^ count
            card.joker_display_values.h_money = card.ability.extra.hdollars * count
        end
	}
	
	togabalatro.jd_def["j_toga_gatosorrindo"] = {
        mod_function = function(card, mod_joker)
            return { x_chips = card.config.center and card.config.center.pools and card.config.center.pools.Cat and mod_joker.config.center.key ~= card.config.center.key and mod_joker.ability.extra.xchips or nil }
        end
	}
end