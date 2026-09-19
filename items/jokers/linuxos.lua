sendInfoMessage("Loading Jokers - Linux OS...", "TOGAPack")

local lj = {}

table.insert(lj, {
	key = 'linux_ubuntu',
	config = { extra = { percentage = 0.05 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { 100*card.ability.extra.percentage } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersLinux',
	pos = { x = 0, y = 0 },
	cost = 6,
	blueprint_compat = true,
	calculate = function(self, card, context)
		local curcard = context.other_joker or context.other_consumeable or nil
		if curcard and curcard ~= card and curcard.sell_cost*card.ability.extra.percentage > 0 then
			local xmultval = curcard and curcard.sell_cost*card.ability.extra.percentage or 0
			return { xmult = xmultval > 0 and 1+xmultval or 1, message_card = curcard or context.blueprint_card or card }
		end
	end,
	pixel_size = { w = 69, h = 69 },
	attributes = { 'joker', 'consumeable', 'sell_value', 'xmult' }
})

table.insert(lj, {
	key = 'linux_debian',
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersLinux',
	pos = { x = 1, y = 0 },
	cost = 4,
	blueprint_compat = false,
	perishable_compat = false,
	calculate = function(self, card, context)
		if context.mod_probability and not context.blueprint then
			return { numerator = context.numerator / 2 }
		end
	end,
	pixel_size = { w = 69, h = 94 },
	attributes = { 'passive', 'mod_chance' }
})

table.insert(lj, {
	key = 'linux_slackware',
	config = { extra = { uchips = 30 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { SMODS.signed(card.ability.extra.uchips) } }
	end,
	unlocked = true,
	rarity = 1,
	atlas = 'TOGAJokersLinux',
	pos = { x = 2, y = 0 },
	cost = 4,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == "unscored" then
			return { chips = card.ability.extra.uchips }
		end
	end,
	pixel_size = { w = 69, h = 62 },
	attributes = { 'chips' }
})

table.insert(lj, {
	key = 'linux_redhat',
	config = { extra = { phandscale = 0.05, xmbonus = 0} },
	loc_vars = function(self, info_queue, card)
		card.ability.extra.xmbonus = math.max(card.ability.extra.xmbonus, 0)
		return { vars = { card.ability.extra.phandscale, 1+card.ability.extra.xmbonus } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersLinux',
	pos = { x = 3, y = 0 },
	cost = 5,
	blueprint_compat = true,
	perishable_compat = false,
	demicolon_compat = true,
	calculate = function(self, card, context)
		if context.before and context.poker_hands and not context.blueprint then
			card.ability.extra.xmbonus = math.max(card.ability.extra.xmbonus, 0)
			local phands = 0
			for k, v in pairs(context.poker_hands) do
				if k ~= 'High Card' and next(v) ~= nil then phands = phands + 1 end
			end
			if phands > 0 then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "xmbonus",
					scalar_value = "phandscale",
					operation = function(ref_table, ref_value, initial, change)
						ref_table[ref_value] = initial + phands*change
					end,
					scaling_message = {
						message = phands > 1 and localize('k_upgrade_ex').." x"..phands or localize('k_upgrade_ex'),
					}
				})
				return nil, true
			end
		end
		
		if context.joker_main or context.forcetrigger then return { xmult = 1+math.max(card.ability.extra.xmbonus, 0) } end
	end,
	pixel_size = { w = 69, h = 84 },
	attributes = { 'hand_type', 'xmult', 'scaling' }
})

return lj