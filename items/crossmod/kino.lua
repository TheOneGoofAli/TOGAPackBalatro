SMODS.Joker{
	key = 'netshow',
	config = { extra = { moviexmult = 0.1, bonusxmult = 0 } },
	loc_vars = function(self, info_queue, card)
		local uniquegenrest, uniquegenresc = {}, 0
		if G.jokers then
			for i = 1, #G.jokers.cards do
				for k, v in pairs(kino_genres) do
					if is_genre(G.jokers.cards[i], v) and not uniquegenrest[v] then
						uniquegenrest[v] = true
						uniquegenresc = uniquegenresc + 1
					end
				end
			end
		end
		return { vars = { card.ability.extra.moviexmult, 1+card.ability.extra.bonusxmult, uniquegenresc } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 3, y = 7 },
	cost = 6,
	pools = { ["TOGAJKR"] = true },
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.before then
			local uniquegenrest = {}
			for i = 1, #G.jokers.cards do
				for k, v in pairs(kino_genres) do
					if is_genre(G.jokers.cards[i], v) and not uniquegenrest[v] then
						uniquegenrest[v] = true
						card.ability.extra.bonusxmult = card.ability.extra.bonusxmult + card.ability.extra.moviexmult
					end
				end
			end
		end
		
		if context.joker_main then return { x_mult = 1+card.ability.extra.bonusxmult } end
	end,
	set_badges = function(self, card, badges)
		if self.discovered then
			SMODS.create_mod_badges({ mod = SMODS.find_mod('kino')[1] }, badges)
		end
	end,
}