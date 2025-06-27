SMODS.Atlas{key = "TOGAYahistuff", path = "togayahi.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGAXPBlind", path = "togaxpblind.png", px = 34, py = 34, atlas_table = 'ANIMATION_ATLAS', frames = 1}

local horsehxmult, horsehdollars, horseeeemult = 1.69, 1, 1.04
local supremescret = 1000

SMODS.Joker{
	key = 'horseconch',
	config = { extra = { hxmult = horsehxmult, hdollars = horsehdollars, heeemult = Talisman and horseeeemult } },
	loc_vars = function(self, info_queue, card)
		if self.discovered then
			card.ability.extra.hxmult = math.max(card.ability.extra.hxmult, horsehxmult)
			info_queue[#info_queue+1] = G.P_SEALS['yahimod_horse_seal']
		end
		return { vars = { card.ability.extra.hxmult, card.ability.extra.hdollars } }
	end,
	unlocked = true,
	rarity = 3,
	atlas = 'TOGAYahistuff',
	pos = { x = 0, y = 0 },
	cost = 6,
	pools = { ["TOGAJKR"] = true },
	blueprint_compat = true,
	calculate = function(self, card, context)
		card.ability.extra.hxmult = math.max(card.ability.extra.hxmult, horsehxmult)
		if Talisman then card.ability.extra.heeemult = math.max(card.ability.extra.heeemult, horseeeemult) end
		if context.cardarea == G.hand and context.other_card and not context.other_card.debuff and context.other_card.seal == "yahimod_horse_seal"
		and not context.repetition and not context.repetition_only and not context.end_of_round then
			--local chanceroll = Talisman and pseudorandom("thegianthorseconchweighsover11pounds") < G.GAME.probabilities.normal/supremescret
			local chanceroll = Talisman and SMODS.pseudorandom_probability(card, "thegianthorseconchweighsover11pounds", 1, supremescret)
			return {
				xmult = not chanceroll and card.ability.extra.hxmult,
				eeemult = chanceroll and card.ability.extra.heeemult,
				eeemult_message = Talisman and {message = localize{ type = "variable", key = "toga_EEEmult", vars = { card.ability.extra.heeemult } }, colour = G.C.DARK_EDITION, sound = "talisman_eeemult"} or nil,
				dollars = card.ability.extra.hdollars
			}
		end
	end,
	set_badges = function(self, card, badges)
		if self.discovered then
			SMODS.create_mod_badges({ mod = SMODS.find_mod('Yahimod')[1] }, badges)
		end
		badges[#badges+1] = create_badge("Joke (TOGA)", G.C.SECONDARY_SET.Tarot, G.C.WHITE, 1 )
	end,
	update = function(self, card, context)
		if card.ability.cry_rigged then card.ability.cry_rigged = nil end
	end,
	pixel_size = { w = 50, h = 95 }
}

local catxchips, cateeechips = 1.35, 1.04

SMODS.Joker{
	key = 'gatosorrindo',
	config = { extra = { xchips = catxchips, eeechips = Talisman and cateeechips } },
	loc_vars = function(self, info_queue, card)
		if self.discovered then card.ability.extra.xchips = math.max(card.ability.extra.xchips, catxchips) end
		return { vars = { card.ability.extra.xchips } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAYahistuff',
	pos = { x = 1, y = 0 },
	cost = 5,
	pools = { ["Cat"] = true, ["TOGAJKR"] = true },
	blueprint_compat = true,
	calculate = function(self, card, context)
		card.ability.extra.xchips = math.max(card.ability.extra.xchips, catxchips)
		if Talisman then card.ability.extra.eeechips = math.max(card.ability.extra.eeechips, cateeechips) end
		if context.other_joker and context.other_joker.config.center and context.other_joker.config.center.pools
		and context.other_joker.config.center.pools.Cat and context.other_joker.config.center.key ~= card.config.center.key then
			--local chanceroll = Talisman and pseudorandom("thecatmusical") < G.GAME.probabilities.normal/supremescret
			local chanceroll = Talisman and local chanceroll = Talisman and SMODS.pseudorandom_probability(card, "thecatmusical", 1, supremescret)
			return {
				xchips = not chanceroll and card.ability.extra.xchips,
				eeechips = chanceroll and card.ability.extra.eeechips,
				eeechip_message = Talisman and {message = localize{ type = "variable", key = "toga_EEEchip", vars = { card.ability.extra.eeechips } }, colour = G.C.DARK_EDITION, sound = "talisman_eeechip"} or nil,
				message_card = context.other_joker
			}
		end
	end,
	set_badges = function(self, card, badges)
		if self.discovered then
			SMODS.create_mod_badges({ mod = SMODS.find_mod('Yahimod')[1] }, badges)
		end
		badges[#badges+1] = create_badge("Joke (TOGA)", G.C.SECONDARY_SET.Tarot, G.C.WHITE, 1 )
	end,
	update = function(self, card, context)
		if card.ability.cry_rigged then card.ability.cry_rigged = nil end
	end,
	pixel_size = { w = 69, h = 74 }
}

SMODS.Consumable {
	key = 'bombshee',
	loc_vars = function(self, info_queue, card)
		return { key = G.washee == 1 and self.key or self.key.."_n" }
	end,
	set = 'Tarot',
	atlas = 'TOGAYahistuff',
	pos = {x = 2, y = 0},
	no_collection = true,
	cost = 5,
	in_pool = function()
		return G.washee == 1
	end,
	can_use = function(self, card, area, copier)
		return G.washee == 1
	end,
	use = function(self, card, area, copier)
		if G.washee == 1 then
			G.E_MANAGER:add_event(Event({func = function()
				G.washee = nil
				play_sound("toga_failsfx", 1, 0.5)
			return true end }))
		end
	end,
	set_badges = function(self, card, badges)
		if self.discovered then SMODS.create_mod_badges({ mod = SMODS.find_mod('Yahimod')[1] }, badges) end
	end
}

SMODS.Blind{
	key = 'xpboss',
	atlas = 'TOGAXPBlind',
	boss_colour = HEX('7292e5'),
	pos = { x = 0, y = 0 },
	dollars = 5,
	mult = 5.1,
	boss = { min = 1, showdown = true },
	ignore_showdown_check = true,
	debuff = { toga_no_disable = true },
	set_blind = function(self)
		for i = 1, #G.jokers.cards do
			G.jokers.cards[i]:set_ability(G.P_CENTERS['j_toga_winxp'])
		end
	end,
}