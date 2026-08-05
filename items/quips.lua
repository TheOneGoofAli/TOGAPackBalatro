sendInfoMessage("Loading JimboQuips...", "TOGAPack")

SMODS.JimboQuip({
    key = 'srb2kartlose',
    extra = {
        center = 'c_toga_selfpropelledbomb',
		particle_colours = {
			G.C.RED,
			G.C.BLACK,
			G.C.BLACK
		},
		times = 0,
		pitch = 0.6,
		juice = {0, 0},
		delay = 0
    },
    filter = function(self, type)
		if (type == 'lose' or type == 'loss') then return true, { weight = 3 } end
    end
})

SMODS.JimboQuip({
    key = 'kappa',
    extra = {
        center = 'j_toga_kappa',
		times = 1,
		sound = 'music_shhh'
    },
    filter = function(self, type)
		if (type == 'lose' or type == 'loss') then return true, { weight = next(SMODS.find_card('j_toga_kappa')) and 4822 or 2 } end
    end,
	play_sounds = function(self, times)
		-- sorry, nothing!
	end,
})