sendInfoMessage("Loading Decks...", "TOGAPack")

SMODS.Back{
	key = "frogdeck",
	pos = { x = 0, y = 0 },
	atlas = "TOGADeckBack",
	unlocked = true,
	discovered = true,
	config = {ante_scaling = 1.25, hands = -1, discards = -1, joker_slot = 1, consumable_slot = 1, hand_size = 3, dollars = 6, spectral_rate = 1},
	loc_vars = function(self, info_queue, center)
		return { vars = { self.config.hands, self.config.discards, self.config.joker_slot, self.config.consumable_slot, self.config.ante_scaling, self.config.hand_size } }
	end
}

SMODS.Back{
	key = "spacedeck",
	pos = { x = 1, y = 0 },
	atlas = "TOGADeckBack",
	unlocked = true,
	config = {vouchers = {'v_planet_merchant', 'v_planet_tycoon'}, spectral_rate = 1.25},
	apply = function(self, back)
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.jokers then
					SMODS.add_card({ key = "j_space" })
					return true
				end
			end,
		}))
	end
}

if not togabalatro.checkbmp() then
	SMODS.Back{
		key = "srb2kartdeck",
		pos = { x = 2, y = 0 },
		atlas = "TOGADeckBack",
		unlocked = true,
		config = {spectral_rate = 1},
		loc_vars = function(self, info_queue, center)
			return { vars = { self.config.ante_scaling or 1 } }
		end,
		apply = function(self, back)
			G.E_MANAGER:add_event(Event({
				func = function()
					if G.jokers then
						local j = SMODS.add_card({ key = "j_toga_jokersrb2kart" })
						j.ability.extra.Xmult_current = 1.25
						return true
					end
				end,
			}))
		end,
		quip_filter = function(quip, type)
			if (quip.mod and quip.mod.id == 'TOGAPack' and togabalatro.config.SpecialDeckMusic) or not togabalatro.config.SpecialDeckMusic then return true else return false end
		end
	}
end

SMODS.Back{
	key = "againdeck",
	pos = { x = 3, y = 0 },
	atlas = "TOGADeckBack",
	unlocked = true,
	config = {joker_slot = -2, ante_scaling = 1.33, repeatamount = 0},
	loc_vars = function(self, info_queue, center)
		return { vars = { self.config.ante_scaling, self.config.joker_slot } }
	end,
	calculate = function(self, back, context)
		if context.before then back.effect.config.repeatamount = G.jokers.cards and #G.jokers.cards or 0 end
		
		if context.cardarea == G.play and context.repetition and not context.repetition_only
		and context.other_card and back.effect.config.repeatamount and back.effect.config.repeatamount > 0 then
			return {
				repetitions = back.effect.config.repeatamount,
				message = localize('k_again_ex'),
			}
		end
		
		if context.after then back.effect.config.repeatamount = 0 end
	end,
}

SMODS.Back{
	key = "311deck",
	pos = { x = 4, y = 0 },
	atlas = "TOGADeckBack",
	unlocked = true,
	config = { extraante = 3, dollars = 7, reducehandsel = -2, hand_size = 3, pokerhandlvlup = 1},
	loc_vars = function(self, info_queue, center)
		return { vars = { self.config.dollars, self.config.hand_size, self.config.reducehandsel, self.config.extraante, self.config.pokerhandlvlup } }
	end,
	apply = function(self, back)
		G.E_MANAGER:add_event(Event({
			func = function()
				for _, v in ipairs(G.handlist) do
					level_up_hand(G.deck.cards[1] or G.deck, v, true)
					if v ~= "High Card" and v ~= "Pair" and v ~= "Three of a Kind" then
						G.GAME.hands[v].visible = false
					end
				end
				G.GAME.win_ante = G.GAME.win_ante + self.config.extraante
				if G.hand then
					togabalatro.handlimitchange(self.config.reducehandsel)
					return true
				end
			end,
		}))
	end,
	calculate = function(self, back, context)
		local iter, iterlimit = 0, 65535 -- Just so we don't freeze the game.
		while G.GAME.round_resets.blind_choices.Boss == 'bl_psychic' do
			G.GAME.round_resets.blind_choices.Boss = get_new_boss()
			iter = iter + 1
			if togabalatro.config.DoMoreLogging then sendInfoMessage("Iteration "..iter.." of "..iterlimit.." rolling for non-Psychic boss blinds.", "TOGAPack") end
			if iter >= iterlimit then break end
		end
	end
}

SMODS.Back{
	key = "screamingdeck",
	pos = { x = 5, y = 0 },
	atlas = "TOGADeckBack",
	unlocked = true,
	config = {ante_scaling = 1.5},
	loc_vars = function(self, info_queue, center)
		return { vars = { self.config.ante_scaling } }
	end,
	apply = function(self, back)
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.playing_cards then
					local cardtable = {}
					for k, v in ipairs(G.playing_cards) do cardtable[#cardtable+1] = v end
					for i=#cardtable, 1, -1 do
						if cardtable[i].base.id ~= 14 then
							cardtable[i]:remove()
						end
					end
					G.GAME.starting_deck_size = #G.playing_cards or 4
					add_tag(Tag('tag_coupon'))
					play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
					play_sound('holo1', 0.4, 1)
					return true
				end
			end,
		}))
	end
}

SMODS.Back{
	key = "drunkdeck",
	pos = { x = 6, y = 0 },
	atlas = "TOGADeckBack",
	unlocked = true,
	apply = function(self, back)
		G.GAME.modifiers.toga_reversedscore = true
	end
}

SMODS.Back{
	key = "waitthatsillegaldeck",
	pos = { x = 0, y = 1 },
	atlas = "TOGADeckBack",
	unlocked = true,
	apply = function(self, back)
		G.GAME.modifiers.toga_randomscore = true
	end
}

if togabalatro.config.EnableQE then
	SMODS.Back{
		key = "blissful",
		atlas = "TOGADeckBack",
		pos = { x = 1, y = 1 },
		config = {ante_scaling = 2, hands = -1, discards = -1, joker_slot = -1, consumable_slot = -1, extraante = 2},
		loc_vars = function(self, info_queue, center)
			return { vars = { self.config.hands, self.config.discards, self.config.joker_slot, self.config.consumable_slot, self.config.ante_scaling, self.config.extraante } }
		end,
		apply = function(self, back)
			G.STATE = G.STATES.SHOP
			G.GAME.shop_free = nil
			G.GAME.shop_d6ed = nil
			G.E_MANAGER:add_event(Event({
				func = function()
					if G.GAME and G.GAME.win_ante then
						G.GAME.win_ante = G.GAME.win_ante + self.config.extraante
						return true
					end
				end,
			}))
		end,
		calculate = function(self, back, context)
			if (context.retrigger_joker_check or context.retrigger_joker or context.blueprint) then return end
			if context.check_enhancement and context.other_card and context.no_blueprint then
				local curenh = {}
				for i, pcard in pairs(G.playing_cards or {}) do
					if pcard and pcard.ability.set == 'Enhanced' and pcard.config and not curenh[pcard.config.center.key] then curenh[pcard.config.center.key] = true end
				end
				return curenh
			end
		end
	}
end

SMODS.Back{
	key = "prairie",
	pos = { x = 2, y = 1 },
	atlas = "TOGADeckBack",
	unlocked = true,
	config = {ante_scaling = 0.8},
	loc_vars = function(self, info_queue, center)
		return { vars = { self.config.ante_scaling } }
	end,
	apply = function(self, back)
		G.GAME.modifiers.toga_noplayedscore = true
	end
}

SMODS.Back{
	key = "betafish",
	pos = { x = 3, y = 1 },
	atlas = "TOGADeckBack",
	unlocked = true,
	config = {ante_scaling = 0.8},
	loc_vars = function(self, info_queue, center)
		return { vars = { self.config.ante_scaling } }
	end,
	apply = function(self, back)
		G.GAME.modifiers.toga_nohandscore = true
	end
}

SMODS.Back{
	key = "wharariki",
	pos = { x = 4, y = 1 },
	atlas = "TOGADeckBack",
	unlocked = true,
	config = { ante_scaling = 2, opamtmod = 1.2 },
	loc_vars = function(self, info_queue, center)
		return { vars = { self.config.ante_scaling, self.config.opamtmod } }
	end,
	apply = function(self, back)
		-- G.GAME.modifiers.toga_chipamtmod = (G.GAME.modifiers.toga_chipamtmod or 1) + self.config.opamtmod
		-- G.GAME.modifiers.toga_multamtmod = (G.GAME.modifiers.toga_multamtmod or 1) + self.config.opamtmod
		G.STATE = G.STATES.SHOP
		G.GAME.shop_free = nil
		G.GAME.shop_d6ed = nil
	end,
	calculate = function(self, back, context)
		if context.toga_affectchipmult and context.opamount and tonumber(to_number(back.effect.config.opamtmod)) and not context.retrigger_joker then
			return { amtmult = back.effect.config.opamtmod, card = back }
		end
	end
}

SMODS.Back{
	key = "alloydeck",
	pos = { x = 0, y = 2 },
	atlas = "TOGADeckBack",
	unlocked = true,
	apply = function(self, back)
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.consumeables then
					local alloy = SMODS.add_card({ key = "c_toga_alloyer" })
					alloy.ability.extra.odds = 1
					alloy.ability.extra.deckperk = true
					return true
				end
			end,
		}))
	end,
}

SMODS.Back{
	key = "queresdeck",
	pos = { x = 1, y = 2 },
	atlas = "TOGADeckBack",
	unlocked = true,
	apply = function(self, back)
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.jokers then
					SMODS.add_card({ set = 'TOGAJKR' })
					return true
				end
			end,
		}))
	end,
}

SMODS.Back{
	key = "coffeedeck",
	pos = { x = 2, y = 2 },
	atlas = "TOGADeckBack",
	unlocked = true,
	apply = function(self, back)
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.GAME.hands then
					for _, h in pairs(G.GAME.hands) do
						h.s_chips = to_big(h.s_chips)*0.8
						h.s_mult = to_big(h.s_mult)*0.8
						h.l_chips = to_big(h.l_chips)*1.25
						h.l_mult = to_big(h.l_mult)*1.25
						h.mult = math.max(to_big(h.s_mult) + to_big(h.l_mult)*(to_big(h.level) - to_big(1)), to_big(1))
						h.chips = math.max(to_big(h.s_chips) + to_big(h.l_chips)*(to_big(h.level) - to_big(1)), to_big(0))
					end
					return true
				end
			end,
		}))
	end,
}

SMODS.Back{
	key = "meshdeck",
	pos = { x = 3, y = 2 },
	atlas = "TOGADeckBack",
	unlocked = true,
	apply = function(self, back)
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.GAME.hands then
					for _, h in pairs(G.GAME.hands) do
						h.s_chips = to_big(h.s_chips)*1.25
						h.s_mult = to_big(h.s_mult)*1.25
						h.l_chips = to_big(h.l_chips)*0.8
						h.l_mult = to_big(h.l_mult)*0.8
						h.mult = math.max(to_big(h.s_mult) + to_big(h.l_mult)*(to_big(h.level) - to_big(1)), to_big(1))
						h.chips = math.max(to_big(h.s_chips) + to_big(h.l_chips)*(to_big(h.level) - to_big(1)), to_big(0))
					end
					return true
				end
			end,
		}))
	end,
}

if togabalatro.config.KingCDIDeck then
	SMODS.Back{
		key = "kingharkinian",
		pos = { x = 5, y = 1 },
		atlas = "TOGADeckBack",
		unlocked = true,
		config = { ante_scaling = 2 },
		apply = function(self, back)
			G.E_MANAGER:add_event(Event({
				func = function()
					if G.jokers then
						local leg = SMODS.add_card({ set = 'Joker', legendary = true, stickers = { "eternal" }, force_stickers = true })
						if leg.config.center.key == 'j_toga_michaelrosen' then leg.ability.extra.odds = 15 end
						return true
					end
				end,
			}))
		end
	}
end

if togabalatro.config.WTFDeck then
	SMODS.Back{
		key = "wtfdeck",
		pos = { x = 6, y = 1 },
		atlas = "TOGADeckBack",
		unlocked = true,
		config = { ante_scaling = 66.6666666666, dollars = -4, hand_size = 18 },
		loc_vars = function(self, info_queue, center)
			return { vars = { self.config.ante_scaling, self.config.dollars } }
		end,
		apply = function(self, back)
			for i = 1, math.random(2, 34) do
				math.random()
			end
			
			back.effect.config.chipmultamt = (back.effect.config.chipamtmult or 1) + math.random(1, 1000)/100
			G.GAME.modifiers.toga_randomscore = true
			G.GAME.modifiers.toga_norentperish = true
			
			G.GAME.toga_negchance = (G.GAME.toga_negchance or 1)*16
			
			for _, v in ipairs(G.handlist) do
				G.GAME.hands[v].s_mult = G.GAME.hands[v].s_mult * (math.random(1, 2000)/100)
				G.GAME.hands[v].l_mult = G.GAME.hands[v].l_mult * (math.random(1, 2000)/100)
				G.GAME.hands[v].s_chips = G.GAME.hands[v].s_chips * (math.random(1, 400)/100)
				G.GAME.hands[v].l_chips = G.GAME.hands[v].l_chips * (math.random(1, 400)/100)
				G.GAME.hands[v].mult = math.max(G.GAME.hands[v].s_mult + G.GAME.hands[v].l_mult*(G.GAME.hands[v].level - 1), 1)
				G.GAME.hands[v].chips = math.max(G.GAME.hands[v].s_chips + G.GAME.hands[v].l_chips*(G.GAME.hands[v].level - 1), 0)
				G.GAME.hands[v].visible = true
			end
			
			change_shop_size(1)
			
			G.STATE = G.STATES.SHOP
			G.GAME.shop_free = nil
			G.GAME.shop_d6ed = nil
			
			G.E_MANAGER:add_event(Event({
				func = function()
					if G.jokers then
						local leg = SMODS.add_card({ set = 'Joker', legendary = true })
						return true
					end
				end,
			}))
			
			G.E_MANAGER:add_event(Event({
				func = function()
					if G.playing_cards then
						add_tag(Tag('tag_coupon'))
						play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
						play_sound('holo1', 0.4, 1)
						return true
					end
				end,
			}))
		end,
		calculate = function(self, back, context)
			if context.before then back.effect.config.repeatamount = G.jokers and G.jokers.cards and #G.jokers.cards or 0 end
			
			if context.cardarea == G.play and context.repetition and not context.repetition_only
			and context.other_card and back.effect.config.repeatamount and back.effect.config.repeatamount > 0 then
				return {
					repetitions = back.effect.config.repeatamount,
					message = localize('k_again_ex'),
				}
			end
			
			if context.after then back.effect.config.repeatamount = 0 end
			
			if context.mod_probability then return { denominator = context.denominator / 2 } end
			
			if context.toga_affectchipmult and context.opamount and not context.retrigger_joker then
				if back.effect and back.effect.config and back.effect.config.chipmultamt and tonumber(to_number(back.effect.config.chipmultamt)) then return { amtmult = back.effect.config.chipmultamt, card = back } end
			end
		end,
	}
end