sendInfoMessage("Loading Achievements...", "TOGAPack")

SMODS.Achievement {
	key = 'win9x',
	bypass_all_unlocked = true,
	unlock_condition = function(self, args)
		return next(SMODS.find_card('j_toga_win95')) and next(SMODS.find_card('j_toga_win98')) and next(SMODS.find_card('j_toga_winmillenium'))
	end,
}

SMODS.Achievement {
	key = 'win10k',
	bypass_all_unlocked = true,
	unlock_condition = function(self, args)
		local w2k = SMODS.find_card('j_toga_win2000')
		return next(w2k) and #w2k == 5
	end,
}

SMODS.Achievement {
	key = 'sfrock',
	bypass_all_unlocked = true,
	unlock_condition = function(self, args)
		if args and args.type and args.type == 'hand' and args.scoring_hand and args.handname and args.handname == 'Straight Flush' then
			local allstones = true
			for k, v in ipairs(args.scoring_hand or {}) do
				if not SMODS.has_enhancement(v, 'm_stone') then allstones = false; break end
			end
			return allstones
		end
	end,
}

SMODS.Achievement {
	key = 'manualcrash',
	bypass_all_unlocked = true,
	unlock_condition = function(self, args)
		if args and args.type and args.type == 'manualcrash_toga' then return true end
	end,
}

SMODS.Achievement {
	key = 'alloytime',
	bypass_all_unlocked = true,
	unlock_condition = function(self, args)
		if args and args.type and args.type == 'alloycheck_toga' and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			local ac = args.card
			if ac and ac.playing_card and ac.config and ac.config.center and ac.config.center.original_mod and ac.config.center.original_mod == togabalatro and ac.config.center.alloy then
				return true
			end
		end
	end,
}

SMODS.Achievement {
	key = 'supersonic',
	bypass_all_unlocked = true,
	unlock_condition = function(self, args)
		if args and args.type and args.type == 'supersoniccheck_toga' then
			local ac = args.card
			if ac and ac.config and ac.config.center and ac.config.center.key and ac.config.center.key == 'j_toga_supersonicthehedgehog' then
				return true
			end
		end
	end,
}

SMODS.Achievement {
	key = 'altloadscrn',
	bypass_all_unlocked = true,
	hidden_text = true,
	unlock_condition = function(self, args)
		if args and args.type and args.type == 'altloadscreen' and togabalatro.config.BonusLoadScreen then return true end
	end,
}

SMODS.Achievement {
	key = 'hypersonic',
	bypass_all_unlocked = true,
	hidden_text = true,
	unlock_condition = function(self, args)
		if args and args.type and args.type == 'hypersoniccheck_toga' then
			local ac = args.card
			if ac and ac.config and ac.config.center and ac.config.center.key and ac.config.center.key == 'j_toga_hypersonicthehedgehog' then
				return true
			end
		end
	end,
}

SMODS.Achievement {
	key = 'negativebrass',
	bypass_all_unlocked = true,
	hidden_text = true,
	unlock_condition = function(self, args)
		if args and args.type and args.type == 'negativecheck_toga' and G.STAGE == G.STAGES.RUN and not G.screenwipe then
			local ac = args.card
			if ac and ac.playing_card and ac.config and ac.config.center and ac.config.center.key and ac.config.center.key == 'm_toga_brass' and ac.edition and ac.edition.negative then
				return true
			end
		end
	end,
}

SMODS.Achievement {
	key = 'winmecrash',
	bypass_all_unlocked = true,
	hidden_text = true,
	unlock_condition = function(self, args)
		if args and args.type and args.type == 'winmedebuff' then return true end
	end,
}

SMODS.Achievement {
	key = 'teapots',
	bypass_all_unlocked = true,
	hidden_text = true,
	unlock_condition = function(self, args)
		local teapot = SMODS.find_card('c_toga_glteapot')
		return next(teapot) and #teapot >= 3
	end,
}

SMODS.Achievement {
	key = 'titlexp',
	bypass_all_unlocked = true,
	hidden_text = true,
	unlock_condition = function(self, args)
		if args and args.type and args.type == 'mmm_toga' and not togabalatro.checksiiva() and G.STAGE == G.STAGES.MAIN_MENU and togabalatro.config.UseCustomMMMusic and togabalatro.mmm and togabalatro.mmm == 'titlexp' then
			return true
		end
	end,
}