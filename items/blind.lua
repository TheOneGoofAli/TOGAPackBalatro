sendInfoMessage("Loading Blinds...", "TOGAPack")

SMODS.Blind{
	key = 'dialupmodem',
	atlas = 'TOGADialUpBlind',
	boss_colour = HEX('404080'),
	pos = { x = 0, y = 0 },
	vars = { reducedhandsel = 1, activated = false },
	dollars = 6,
	mult = 2.8,
	boss = { min = 4 },
	loc_vars = function(self)
		return { vars = { -self.vars.reducedhandsel } }
	end,
	collection_loc_vars = function(self)
		return { vars = { -self.vars.reducedhandsel  } }
	end,
	set_blind = function(self)
		self.vars.activated = true
		togabalatro.handlimitchange(-self.vars.reducedhandsel)
		--G.hand.config.highlighted_limit = math.max(G.hand.config.highlighted_limit - self.vars.reducedhandsel, 1)
		if togabalatro.config.DoMoreLogging then sendInfoMessage("Decreased card selection limit to "..G.hand.config.highlighted_limit..".", "TOGAPack") end
	end,
	disable = function(self)
		if self.vars.activated then
			self.vars.activated = false
			togabalatro.handlimitchange(self.vars.reducedhandsel)
			--G.hand.config.highlighted_limit = math.max(G.hand.config.highlighted_limit + self.vars.reducedhandsel, 5)
			if togabalatro.config.DoMoreLogging then sendInfoMessage("Disabled, card selection limit is "..G.hand.config.highlighted_limit..".", "TOGAPack") end
		end
	end,
	defeat = function(self)
		if self.vars.activated then
			togabalatro.handlimitchange(self.vars.reducedhandsel)
			--G.hand.config.highlighted_limit = math.max(G.hand.config.highlighted_limit + self.vars.reducedhandsel, 5)
			if togabalatro.config.DoMoreLogging then sendInfoMessage("Defeated, card selection limit is "..G.hand.config.highlighted_limit..".", "TOGAPack") end
		end
	end
}

SMODS.Blind{
	key = 'worldwideweb',
	atlas = 'TOGAWWWBlind',
	boss_colour = HEX('aafdff'),
	pos = { x = 0, y = 0 },
	vars = { increasehandsel = 3, activated = false },
	dollars = 6,
	mult = 14.4,
	boss = { min = 3.11, showdown = true },
	in_pool = function(self)
		return G.GAME.dialupmodem or false
	end,
	loc_vars = function(self)
		return { vars = { self.vars.increasehandsel } }
	end,
	collection_loc_vars = function(self)
		return { key = self.key.."_collection" }
	end,
	set_blind = function(self)
		self.vars.activated = true
		togabalatro.handlimitchange(self.vars.increasehandsel)
		--G.hand.config.highlighted_limit = math.max(G.hand.config.highlighted_limit + self.vars.increasehandsel, 1)
		G.hand:change_size(self.vars.increasehandsel)
		if togabalatro.config.DoMoreLogging then sendInfoMessage("Changed card selection limit to "..G.hand.config.highlighted_limit..".", "TOGAPack") end
		if togabalatro.config.DoMoreLogging then sendInfoMessage("Changed hand size to "..G.hand.config.card_limit..".", "TOGAPack") end
	end,
	disable = function(self)
		if self.vars.activated then
			self.vars.activated = false
			togabalatro.handlimitchange(-self.vars.increasehandsel)
			--G.hand.config.highlighted_limit = math.max(G.hand.config.highlighted_limit - self.vars.increasehandsel, 5)
			G.hand:change_size(-self.vars.increasehandsel)
			if togabalatro.config.DoMoreLogging then sendInfoMessage("Disabled, card selection limit is "..G.hand.config.highlighted_limit..".", "TOGAPack") end
			if togabalatro.config.DoMoreLogging then sendInfoMessage("Disabled, changed hand size to "..G.hand.config.card_limit..".", "TOGAPack") end
		else
			if togabalatro.config.SFXWhenTriggered then play_sound("toga_failsfx", 1, 0.5) end
		end
	end,
	defeat = function(self)
		if self.vars.activated then
			self.vars.activated = false
			togabalatro.handlimitchange(-self.vars.increasehandsel)
			--G.hand.config.highlighted_limit = math.max(G.hand.config.highlighted_limit - self.vars.increasehandsel, 5)
			G.hand:change_size(-self.vars.increasehandsel)
			if togabalatro.config.DoMoreLogging then sendInfoMessage("Defeated, card selection limit is "..G.hand.config.highlighted_limit..".", "TOGAPack") end
			if togabalatro.config.DoMoreLogging then sendInfoMessage("Defeated, changed hand size to "..G.hand.config.card_limit..".", "TOGAPack") end
		end
		ease_dollars(50)
	end
}

-- You have given me how many hours of trouble?
SMODS.Blind{
	key = 'joystick',
	atlas = 'TOGAOtherBlind',
	boss_colour = HEX('76992b'),
	pos = { x = 0, y = 0 },
	dollars = 8,
	mult = 2.5,
	boss = { min = 3 },
	calculate = function(self, card, context)
		if not G.GAME.blind.disabled then
			if context.first_hand_drawn then
				for i, v in ipairs(G.hand.cards) do
					if not v.highlighted then
						G.hand.highlighted[#G.hand.highlighted+1] = v
						v:highlight(true)
					end
				end
				G.FUNCS.play_cards_from_highlighted()
			end
		end
	end,
}

SMODS.Blind{
	key = 'tasks',
	atlas = 'TOGAOtherBlind',
	boss_colour = HEX('008080'),
	pos = { x = 0, y = 1 },
	vars = { multamtred = 0.2, activated = false },
	dollars = 6,
	mult = 2,
	boss = { min = 3 },
	loc_vars = function(self)
		return { vars = { self.vars.multamtred } }
	end,
	collection_loc_vars = function(self)
		return { vars = { self.vars.multamtred } }
	end,
	set_blind = function(self)
		self.vars.activated = true
		G.GAME.modifiers.toga_multamtmod = (G.GAME.modifiers.toga_multamtmod or 1) - self.vars.multamtred
	end,
	disable = function(self)
		if self.vars.activated then
			self.vars.activated = false
			G.GAME.modifiers.toga_multamtmod = (G.GAME.modifiers.toga_multamtmod or 1) + self.vars.multamtred
		end
	end,
	defeat = function(self)
		if self.vars.activated then
			G.GAME.modifiers.toga_multamtmod = (G.GAME.modifiers.toga_multamtmod or 1) + self.vars.multamtred
		end
	end
}

SMODS.Blind{
	key = 'accountant',
	atlas = 'TOGAOtherBlind',
	boss_colour = HEX('808080'),
	pos = { x = 0, y = 2 },
	vars = { chipamtred = 0.25, activated = false },
	dollars = 6,
	mult = 2,
	boss = { min = 3 },
	loc_vars = function(self)
		return { vars = { self.vars.chipamtred } }
	end,
	collection_loc_vars = function(self)
		return { vars = { self.vars.chipamtred } }
	end,
	set_blind = function(self)
		self.vars.activated = true
		G.GAME.modifiers.toga_chipamtmod = (G.GAME.modifiers.toga_chipamtmod or 1) - self.vars.chipamtred
	end,
	disable = function(self)
		if self.vars.activated then
			self.vars.activated = false
			G.GAME.modifiers.toga_chipamtmod = (G.GAME.modifiers.toga_chipamtmod or 1) + self.vars.chipamtred
		end
	end,
	defeat = function(self)
		if self.vars.activated then
			G.GAME.modifiers.toga_chipamtmod = (G.GAME.modifiers.toga_chipamtmod or 1) + self.vars.chipamtred
		end
	end
}

SMODS.Blind{
	key = 'bag',
	atlas = 'TOGAOtherBlind',
	boss_colour = HEX('a80054'),
	pos = { x = 0, y = 3 },
	dollars = 5,
	mult = 2,
	boss = { min = 3 },
	press_play = function(self)
		if G.hand.cards then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			for i = 1, #G.hand.cards do
				G.E_MANAGER:add_event(Event({func = function() G.hand.cards[i]:juice_up(); return true end })) 
				ease_dollars(-1)
				delay(0.23)
			end
			return true end })) 
        end
	end
}

SMODS.Blind{
	key = 'filmreel',
	atlas = 'TOGAOtherBlind',
	boss_colour = HEX('54a8a8'),
	pos = { x = 0, y = 4 },
	dollars = 5,
	mult = 2,
	boss = { min = 4 },
	in_pool = function(self)
		if G.GAME and G.GAME.round_resets and G.GAME.round_resets.ante and (tonumber(to_number(G.GAME.round_resets.ante)) or 0) >= 4 then
			for k, v in pairs(G.playing_cards) do
				if SMODS.has_no_rank(v) then return true end
			end
		end
		return false
	end,
	debuff_hand = function(self, cards, hand, handname, check)
		for k, v in ipairs(cards or {}) do
			if SMODS.has_no_rank(v) then return false end
		end
		return true
	end
}

SMODS.Blind{
	key = 'stamp',
	atlas = 'TOGAOtherBlind',
	boss_colour = HEX('000000'),
	pos = { x = 0, y = 5 },
	dollars = 6,
	mult = 2,
	boss = { min = 5 },
	debuff_hand = function(self, cards, hand, handname, check)
		local ranks = {}
		for k, v in ipairs(cards or {}) do
			if not SMODS.has_no_rank(v) then
				local rank = v:get_id()
				if not (ranks[1] and ranks[1] == rank) then table.insert(ranks, rank) end
			end
		end
		if #ranks ~= 1 then return true end
	end
}

SMODS.Blind{
	key = 'login',
	atlas = 'TOGAOtherBlind',
	boss_colour = HEX('808000'),
	pos = { x = 0, y = 6 },
	dollars = 6,
	mult = 2,
	boss = { min = 2 },
	debuff_hand = function(self, cards, hand, handname, check)
		if cards and #cards == 3 then return false end
		for k, v in ipairs(cards or {}) do
			if v:get_id() == 3 then return false end
		end
		return true
	end
}