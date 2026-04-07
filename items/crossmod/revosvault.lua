-- Cross-mod stuff for Mineral card pool. Iron, gold and diamonds are valid examples,
-- but bronze and steel are not intended for this pool for being alloys.
sendInfoMessage("Added Diamond cards of Revo's Vault to mineral pool.", "TOGAPack - Revo's Vault")
togabalatro.add_to_oredict('m_crv_diamondcard', 'minerals', true)
togabalatro.add_to_oredict('m_crv_diamondcard', 'diamond', true)
if next(SMODS.find_mod('reverse_tarot')) then
	sendInfoMessage("Added Quartz cards of Revo's Vault to mineral pool.", "TOGAPack - Revo's Vault")
	togabalatro.add_to_oredict('m_crv_quartz', 'minerals', true)
	togabalatro.add_to_oredict('m_crv_quartz', 'quartz', true)
end

SMODS.Joker{
	key = 'printershare',
	config = { extra = { printxmult = 2, odds = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.printxmult, SMODS.get_probability_vars(card or self, 1, (card.ability or self.config).extra.odds) } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersMain',
	pos = { x = 0, y = 4 },
	soul_pos = { x = 7, y = 5 },
	cost = 6,
	pools = { ["TOGAJKR"] = true },
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.other_joker and context.other_joker:is_rarity("crv_p") and SMODS.pseudorandom_probability(card, 'toga_bogosbinted', 1, card.ability.extra.odds, 'printersharing') then
			return { x_mult = card.ability.extra.printxmult, message_card = context.other_joker }
		end
	end,
	set_badges = function(self, card, badges)
		if self.discovered then
			SMODS.create_mod_badges({ mod = SMODS.find_mod('RevosVault')[1] }, badges)
		end
	end,
	attributes = { 'xmult', 'printer', 'chance' }
}