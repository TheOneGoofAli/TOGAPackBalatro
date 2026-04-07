sendInfoMessage("Loading Jokers - Mac OS...", "TOGAPack")

local macos9_hxmult, macosx_hxchips, macj = 1.25, 1.25, {}

table.insert(macj, {
	key = 'mac_os_9',
	config = { extra = { hxmult = macos9_hxmult } },
	loc_vars = function(self, info_queue, card)
		card.ability.extra.hxmult = math.max(card.ability.extra.hxmult, macos9_hxmult)
		return { vars = { card.ability.extra.hxmult } }
	end,
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersMac',
	pos = { x = 0, y = 0 },
	cost = 7,
	blueprint_compat = true,
	calculate = function(self, card, context)
		card.ability.extra.hxmult = math.max(card.ability.extra.hxmult, macos9_hxmult)
		if context.cardarea == G.hand and context.other_card and not context.other_card.debuff and context.other_card:is_suit('Clubs')
		and not context.repetition and not context.repetition_only and not context.end_of_round then
			return { xmult = card.ability.extra.hxmult > 1 and card.ability.extra.hxmult or 1 }
		end
	end,
	pixel_size = { w = 71, h = 84 },
	attributes = { 'suit', 'clubs', 'xmult' }
})

table.insert(macj, {
	key = 'mac_os_x',
	config = { extra = { hxchips = macosx_hxchips } },
	loc_vars = function(self, info_queue, card)
		card.ability.extra.hxchips = math.max(card.ability.extra.hxchips, macosx_hxchips)
		return { vars = { card.ability.extra.hxchips } }
	end,
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersMac',
	pos = { x = 1, y = 0 },
	cost = 7,
	blueprint_compat = true,
	calculate = function(self, card, context)
		card.ability.extra.hxchips = math.max(card.ability.extra.hxchips, macosx_hxchips)
		if context.cardarea == G.hand and context.other_card and not context.other_card.debuff and context.other_card:get_id() == 10
		and not context.repetition and not context.repetition_only and not context.end_of_round then
			return { xchips = card.ability.extra.hxchips > 1 and card.ability.extra.hxchips or 1 }
		end
	end,
	pixel_size = { w = 71, h = 84 },
	attributes = { 'rank', 'ten', 'xchips' }
})

return macj