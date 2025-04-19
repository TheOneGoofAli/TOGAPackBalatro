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

SMODS.Back{
	key = "srb2kartdeck",
	pos = { x = 2, y = 0 },
	atlas = "TOGADeckBack",
	unlocked = true,
	config = {spectral_rate = 1, joker_slot = -2},
	loc_vars = function(self, info_queue, center)
		return { vars = { self.config.ante_scaling or 1, self.config.joker_slot } }
	end,
	apply = function(self, back)
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.jokers then
					SMODS.add_card({ key = "j_toga_jokersrb2kart", stickers = { "eternal" } })
					return true
				end
			end,
		}))
	end
}

SMODS.Back{
	key = "againdeck",
	pos = { x = 3, y = 0 },
	atlas = "TOGADeckBack",
	unlocked = true,
	config = {joker_slot = -2, ante_scaling = 1.33},
	loc_vars = function(self, info_queue, center)
		return { vars = { self.config.ante_scaling, self.config.joker_slot } }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition and not context.repetition_only
		and context.other_card and G.jokers.cards and #G.jokers.cards >= 1 then
			return {
				repetitions = #G.jokers.cards,
				message = localize('k_again_ex'),
				card = context.other_card
			}
		end
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
					G.GAME.hands[v].level = G.GAME.hands[v].level + self.config.pokerhandlvlup
					G.GAME.hands[v].mult = math.max(G.GAME.hands[v].s_mult + G.GAME.hands[v].l_mult*(G.GAME.hands[v].level - 1), 1)
					G.GAME.hands[v].chips = math.max(G.GAME.hands[v].s_chips + G.GAME.hands[v].l_chips*(G.GAME.hands[v].level - 1), 0)
					if v ~= "High Card" and v ~= "Pair" and v ~= "Three of a Kind" then
						G.GAME.hands[v].visible = false
					end
				end
				G.GAME.win_ante = G.GAME.win_ante + self.config.extraante
				if G.hand then
					G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + self.config.reducehandsel
					return true
				end
			end,
		}))
	end,
	calculate = function(self, card, context)
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
	config = {ante_scaling = 1.25, extraante = 3},
	loc_vars = function(self, info_queue, center)
		return { vars = { self.config.ante_scaling, self.config.extraante } }
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
					add_tag(Tag('tag_coupon'))
					play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
					play_sound('holo1', 0.4, 1)
					return true
				end
			end,
		}))
	end
}