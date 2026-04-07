-- PSO2 Jokers.

local pso2j = {}

table.insert(pso2j, {
	key = 'pso2shifta',
	config = { extra = { pwrbst = 1.97 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.pwrbst } }
	end,
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersPSO2',
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	cost = 7,
	blueprint_compat = false,
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge(localize('toga_firetech'), G.C.RED, G.C.WHITE, 1)
	end,
	attributes = { 'passive', 'hand_type', 'planet' }
})

table.insert(pso2j, {
	key = 'pso2deband',
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAJokersPSO2',
	pos = { x = 0, y = 0 },
	soul_pos = { x = 2, y = 0 },
	cost = 7,
	blueprint_compat = false,
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge(localize('toga_icetech'), G.C.BLUE, G.C.WHITE, 1)
	end,
	attributes = { 'passive', 'blind_requirement' }
})

table.insert(pso2j, {
	key = 'pso2ironwill',
	unlocked = true,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	rarity = 3,
	atlas = 'TOGAJokersPSO2',
	pos = { x = 0, y = 0 },
	soul_pos = { x = 3, y = 0 },
	cost = 10,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = false,
	calculate = function(self, card, context)
		if context.retrigger_joker or context.blueprint then return end
		
		if context.end_of_round and context.game_over and not context.repetition and not context.individual then
			return {
				message = localize('toga_pso2ironwillproc'),
				saved = localize('toga_pso2ironwillsave'),
				colour = G.C.RED,
				extra = {
					func = function()
						ease_dollars(-G.GAME.dollars+1, true)
						SMODS.debuff_card(card, 'ironwillproc', 'lethalhitsave')
						SMODS.destroy_cards(card, true, nil, true)
					end
				}
			}
		end
	end,
	poweritem = true,
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge(localize('toga_skillhunter'), G.C.SECONDARY_SET.Enhanced, G.C.WHITE, 1)
	end,
	attributes = { 'prevents_death', 'economy' }
})

return pso2j