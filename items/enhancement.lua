sendInfoMessage("Loading Enhancements...", "TOGAPack")

SMODS.Enhancement{
	key = 'notification',
	atlas = "TOGAEnhancements",
	pos = { x = 0, y = 0 },
	weight = 3,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	poweritem = true
}

SMODS.Enhancement{
	key = 'sms',
	atlas = "TOGAEnhancements",
	pos = { x = 9, y = 0 },
	weight = 2,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	poweritem = true
}

SMODS.Enhancement{
	key = 'chocolate',
	atlas = "TOGAEnhancements",
	pos = { x = 7, y = 1 },
	config = { bonus = 50, extra = { chodds = 4 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { SMODS.signed(card.ability.bonus), SMODS.get_probability_vars(card, 1, (card.ability or self.config).extra.chodds) } }
	end,
	replace_base_card = true,
	no_rank = true,
	no_suit = true,
	always_scores = true,
	calculate = function(self, card, context)
		if context.destroy_card and context.cardarea == G.play and context.destroy_card == card and SMODS.pseudorandom_probability(card, 'toga_chocolate', 1, card.ability.extra.chodds) then
			card.choccy_trigger = true
			return { remove = true }
		end
	end
}

SMODS.Enhancement{
	key = 'coalcoke',
	atlas = "TOGAEnhancements",
	pos = { x = 1, y = 0 },
	config = { h_chips = 40 },
	replace_base_card = true,
	no_rank = true,
	no_suit = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.h_chips } }
	end,
	weight = 7
}

SMODS.Enhancement{
	key = 'iron',
	atlas = "TOGAEnhancements",
	pos = { x = 2, y = 0 },
	config = { h_x_mult = 1.25 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.h_x_mult } }
	end,
	weight = 8
}

SMODS.Enhancement{
	key = 'silver',
	atlas = "TOGAEnhancements",
	pos = { x = 3, y = 0 },
	config = { x_mult = 1.25 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.x_mult } }
	end,
}

SMODS.Enhancement{
	key = 'copper',
	atlas = "TOGAEnhancements",
	pos = { x = 5, y = 0 },
	config = { h_x_chips = 1.5 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.h_x_chips } }
	end,
	weight = 8
}

SMODS.Enhancement{
	key = 'tin',
	atlas = "TOGAEnhancements",
	pos = { x = 6, y = 0 },
	always_scores = true,
	weight = 8
}

SMODS.Enhancement{
	key = 'osmium',
	atlas = "TOGAEnhancements",
	pos = { x = 8, y = 0 },
	config = { x_chips = 1.25 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.x_chips } }
	end,
}

SMODS.Enhancement{
	key = 'redstone',
	atlas = "TOGAEnhancements",
	pos = { x = 0, y = 1 },
	weight = 3
}

SMODS.Enhancement{
	key = 'nickel',
	atlas = "TOGAEnhancements",
	pos = { x = 2, y = 1 },
}

SMODS.Enhancement{
	key = 'glowstone',
	atlas = "TOGAEnhancements",
	pos = { x = 4, y = 1 },
	no_rank = true,
	replace_base_card = false,
	shatters = true,
	weight = 3
}

SMODS.Enhancement{
	key = 'lead',
	atlas = "TOGAEnhancements",
	pos = { x = 9, y = 1 },
	config = { toga_blindredamt = 0.99 },
	loc_vars = function(self, info_queue, card)
		if not (card.debuff or card.fake_card) then
			info_queue[#info_queue + 1] = {key = "toga_heavycard", set = 'Other', vars = { card.ability.toga_blindredamt } }
		end
	end,
	never_scores = true,
	weight = 4
}

SMODS.Enhancement{
	key = 'zinc',
	atlas = "TOGAEnhancements",
	pos = { x = 0, y = 2 },
	config = { toga_gmult = 1 },
	loc_vars = function(self, info_queue, card)
		return { vars = { SMODS.signed(card.ability.toga_gmult) } }
	end,
	weight = 6
}

SMODS.Enhancement{
	key = 'platinum',
	atlas = "TOGAEnhancements",
	pos = { x = 3, y = 2 },
	config = { owodds = 5 },
	loc_vars = function(self, info_queue, card)
		if not (card.debuff or card.fake_card) then
			info_queue[#info_queue + 1] = {key = "toga_otherworldlycard", set = 'Other', vars = { SMODS.get_probability_vars(card or self, 1, (card.ability or self.config).owodds) } }
		end
	end,
	weight = 3
}

SMODS.Enhancement{
	key = 'electrum',
	atlas = "TOGAEnhancements",
	pos = { x = 4, y = 0 },
	config = { p_dollars = 1, x_mult = 1.75 },
	loc_vars = function(self, info_queue, card)
		return { key = card and card.showrecipe and self.key .. "_recipe" or self.key, vars = { card.ability.p_dollars, card.ability.x_mult } }
	end,
	in_pool = function(self, args)
		return false
	end,
	alloy = true,
	set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('toga_alloy'), HEX('e4d691'), G.C.WHITE, 1)
    end,
	poweritem = true
}

SMODS.Enhancement{
	key = 'bronze',
	atlas = "TOGAEnhancements",
	pos = { x = 7, y = 0 },
	config = { h_x_chips = 2.5 },
	loc_vars = function(self, info_queue, card)
		return { key = card and card.showrecipe and self.key .. "_recipe" or self.key, vars = { card.ability.h_x_chips } }
	end,
	in_pool = function(self, args)
		return false
	end,
	alloy = true,
	set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('toga_alloy'), HEX('a87544'), G.C.WHITE, 1)
    end,
	poweritem = true
}

SMODS.Enhancement{
	key = 'signalum',
	atlas = "TOGAEnhancements",
	pos = { x = 1, y = 1 },
	config = { x_mult = 2 },
	loc_vars = function(self, info_queue, card)
		return { key = card and card.showrecipe and self.key .. "_recipe" or self.key, vars = { card.ability.x_mult } }
	end,
	in_pool = function(self, args)
		return false
	end,
	alloy = true,
	set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('toga_alloy'), HEX('db4600'), G.C.WHITE, 1)
    end,
	poweritem = true
}

SMODS.Enhancement{
	key = 'invar',
	atlas = "TOGAEnhancements",
	pos = { x = 3, y = 1 },
	config = { h_x_mult = 1.75 },
	loc_vars = function(self, info_queue, card)
		return { key = card and card.showrecipe and self.key .. "_recipe" or self.key, vars = { card.ability.h_x_mult } }
	end,
	in_pool = function(self, args)
		return false
	end,
	alloy = true,
	set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('toga_alloy'), HEX('6f7975'), G.C.WHITE, 1)
    end,
	poweritem = true
}

SMODS.Enhancement{
	key = 'lumium',
	atlas = "TOGAEnhancements",
	pos = { x = 5, y = 1 },
	config = { h_x_mult = 2 },
	loc_vars = function(self, info_queue, card)
		return { key = card and card.showrecipe and self.key .. "_recipe" or self.key, vars = { card.ability.h_x_mult } }
	end,
	in_pool = function(self, args)
		return false
	end,
	alloy = true,
	set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('toga_alloy'), HEX('cf8f42'), G.C.WHITE, 1)
    end,
	poweritem = true
}

SMODS.Enhancement{
	key = 'refinedglowstone',
	atlas = "TOGAEnhancements",
	pos = { x = 6, y = 1 },
	config = { x_mult = 1.25, x_chips = 1.5 },
	loc_vars = function(self, info_queue, card)
		return { key = card and card.showrecipe and self.key .. "_recipe" or self.key, vars = { card.ability.x_chips, card.ability.x_mult } }
	end,
	in_pool = function(self, args)
		return false
	end,
	alloy = true,
	set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('toga_alloy'), HEX('d4bc41'), G.C.WHITE, 1)
    end,
	poweritem = true
}

SMODS.Enhancement{
	key = 'constantan',
	atlas = "TOGAEnhancements",
	pos = { x = 8, y = 1 },
	config = { toga_retriggers = 2 },
	loc_vars = function(self, info_queue, card)
		return { key = card and card.showrecipe and self.key .. "_recipe" or self.key, vars = { card.ability.toga_retriggers } }
	end,
	in_pool = function(self, args)
		return false
	end,
	alloy = true,
	set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('toga_alloy'), HEX('c69953'), G.C.WHITE, 1)
    end,
	calculate = function(self, card, context)
		if context.repetition then return { repetitions = card.ability.toga_retriggers } end
	end,
	poweritem = true
}

SMODS.Enhancement{
	key = 'brass',
	atlas = "TOGAEnhancements",
	pos = { x = 1, y = 2 },
	config = { card_limit = 1 },
	loc_vars = function(self, info_queue, card)
		return { key = card and card.showrecipe and self.key .. "_recipe" or self.key, vars = { card.ability.card_limit } }
	end,
	in_pool = function(self, args)
		return false
	end,
	alloy = true,
	set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('toga_alloy'), HEX('bf8e55'), G.C.WHITE, 1)
    end,
	poweritem = true
}

SMODS.Enhancement{
	key = 'enderium',
	atlas = "TOGAEnhancements",
	pos = { x = 2, y = 2 },
	config = { toga_txcm = 1.75 },
	loc_vars = function(self, info_queue, card)
		return { key = card and card.showrecipe and self.key .. "_recipe" or self.key, vars = { card.ability.toga_txcm } }
	end,
	in_pool = function(self, args)
		return false
	end,
	alloy = true,
	set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('toga_alloy'), HEX('328181'), G.C.WHITE, 1)
    end,
	calculate = function(self, card, context)
		if context.final_scoring_step and (context.cardarea == G.play or context.cardarea == "unscored") then return { xchips = card.ability.toga_txcm, xmult = card.ability.toga_txcm } end
	end,
	poweritem = true
}

SMODS.Enhancement{
	key = 'conductivealloy',
	atlas = "TOGAEnhancements",
	pos = { x = 4, y = 2 },
	loc_vars = function(self, info_queue, card)
		return { key = card and card.showrecipe and self.key .. "_recipe" or self.key }
	end,
	in_pool = function(self, args)
		return false
	end,
	alloy = true,
	set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('toga_alloy'), HEX('884D4E'), G.C.WHITE, 1)
    end,
	calculate = function(self, card, context)
		if context.stay_flipped and context.from_area == G.play and G.deck then return { modify = { to_area = G.deck } } end
	end,
	poweritem = true
}

SMODS.Enhancement{
	key = 'energeticalloy',
	atlas = "TOGAEnhancements",
	pos = { x = 5, y = 2 },
	loc_vars = function(self, info_queue, card)
		return { key = card and card.showrecipe and self.key .. "_recipe" or self.key }
	end,
	in_pool = function(self, args)
		return false
	end,
	alloy = true,
	set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('toga_alloy'), HEX('C5723C'), G.C.WHITE, 1)
    end,
	poweritem = true
}