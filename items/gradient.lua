sendInfoMessage("Loading Gradients...", "TOGAPack")

loc_colour()

SMODS.Gradient({
	key = 'suitgradient',
	colours = { G.C.SUITS.Spades, G.C.SUITS.Hearts, G.C.SUITS.Clubs, G.C.SUITS.Diamonds }
})

SMODS.Gradient({
	key = 'consgradient',
	colours = { G.C.SECONDARY_SET.Tarot, G.C.SECONDARY_SET.Planet, G.C.SECONDARY_SET.Spectral }
})

SMODS.Gradient({
	key = 'jkrgradient',
	colours = { G.C.RARITY[1], G.C.RARITY[2], G.C.RARITY[3], G.C.RARITY[4] }
})