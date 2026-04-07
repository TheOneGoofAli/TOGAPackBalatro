if SDM_0s_Stuff_Config and SDM_0s_Stuff_Config.sdm_bakery then
	SMODS.Joker{
		key = 'spiceoflife',
		config = { extra = { bakedgoods = {} } },
		loc_vars = function(self, info_queue, card)
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
			return { key = count > 1 and self.key.."_rtrg" or self.key, vars = { count > 1 and count or 0 } }
		end,
		unlocked = true,
		discovered = true,
		rarity = 2,
		atlas = 'TOGAJokersOtherDiffSize',
		pos = { x = 6, y = 0 },
		cost = 5,
		pools = { ["TOGAJKR"] = true },
		blueprint_compat = true,
		calculate = function(self, card, context)
			if context.before then
				card.ability.extra.bakedgoods = {}
				for i = 1, #G.consumeables.cards do
					if G.consumeables.cards[i].ability.set == 'Bakery' and not card.ability.extra.bakedgoods[G.consumeables.cards[i].config.center.key] then
						card.ability.extra.bakedgoods[G.consumeables.cards[i].config.center.key] = true
					end
				end
			end
			
			if context.retrigger_joker_check and not context.retrigger_joker and context.other_card.ability.set == 'Bakery' then
				local count = 0
				for k, v in pairs(card.ability.extra.bakedgoods) do
					count = count + 1
				end
				if count > 1 then
					return {
						message = localize('k_again_ex'),
						repetitions = count,
						card = context.blueprint_card or card,
					}
				end
			end
		end,
		set_badges = function(self, card, badges)
			if self.discovered then SMODS.create_mod_badges({ mod = SMODS.find_mod('sdm0sstuff')[1] }, badges) end
		end,
		pixel_size = { w = 69, h = 74 },
		attributes = { 'retrigger', 'bakery', 'consumeable' }
	}
end