sendInfoMessage("Loading Stakes...", "TOGAPack")

SMODS.Stake {
	name = "Teal Stake",
	key = "togateal",
	applied_stakes = { "stake_gold" },
	above_stake = "stake_gold",
	stake_level = 9,
	atlas = "TOGAStakes",
	pos = { x = 0, y = 0 },
	sticker_atlas = "TOGAStickers",
	sticker_pos = { x = 0, y = 0 },
	colour = HEX('008282'),
	shiny = true,
	prefix_config = {
		applied_stakes = { mod = false },
		above_stake = { mod = false }
	},
	calculate = function(self, context)
		if context.toga_affectchipmult and context.opamount and not context.retrigger_joker then
			return { amtmult = 0.9, stake = self }
		end
	end
}