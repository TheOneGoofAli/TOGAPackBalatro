sendInfoMessage("Initializing hooks...", "TOGAPack")

-- Prevent seals spawning if power items disabled.
sendInfoMessage("Hooking SMODS.poll_seal...", "TOGAPack")
local smodssealref = SMODS.poll_seal
function SMODS.poll_seal(args)
	local resultseal = smodssealref(args) -- original result.
	local iter, iterlimit = 0, 100 -- just so we don't lock the game up.
	
	if not togabalatro.config.ShowPower and resultseal ~= nil and (resultseal == 'toga_sealseal' or resultseal == 'toga_urlseal') then
		repeat
			iter = iter + 1
			smodssealref(args)
		until (resultseal ~= 'toga_sealseal' and resultseal ~= 'toga_urlseal') or iter > iterlimit
		
		if (resultseal == 'toga_sealseal' or resultseal == 'toga_urlseal') then resultseal = nil end
	end
	
	return resultseal
end

-- Tom Scott?!
sendInfoMessage("Hooking SMODS.showman...", "TOGAPack")
local showmansmodsref = SMODS.showman
function SMODS.showman(card_key)
	if card_key == 'j_toga_tomscott' and next(SMODS.find_card('j_toga_tomscott')) then return true end
	
	return showmansmodsref(card_key)
end

-- Still kept for colouring the button with higher allowed amount of cards to play, but also backwards compat.
sendInfoMessage("Hooking G.FUNCS.can_play...", "TOGAPack")
local canplayref = G.FUNCS.can_play
function G.FUNCS.can_play(e)
	if togabalatro.config.DoMoreLogging and togabalatro.config.DoEvenMoreLogging then sendDebugMessage("G.FUNCS.can_play hook.", "TOGAPack") end
	canplayref(e) -- execute original first before we do anything.
	if #G.hand.highlighted <= G.hand.config.highlighted_limit then
		if #G.hand.highlighted >= 52 then -- Cryptid?
			e.config.colour = G.C.EDITION
			if not togabalatro.handlimitapi() then e.config.button = 'play_cards_from_highlighted' end
		elseif #G.hand.highlighted >= 10 and #G.hand.highlighted < 52 then -- 2x the base and more.
			e.config.colour = G.C.DARK_EDITION
			if not togabalatro.handlimitapi() then e.config.button = 'play_cards_from_highlighted' end
		elseif #G.hand.highlighted > 5 and #G.hand.highlighted < 10 then -- more than base.
			e.config.colour = G.C.PURPLE
			if not togabalatro.handlimitapi() then e.config.button = 'play_cards_from_highlighted' end
		end
	end
end

-- Rosen sound swap stuff.
togabalatro.rosensfx = { chips1 = true, multhit1 = true, multhit2 = true, coin1 = true, generic1 = true, foil2 = true, xchips = true,
						talisman_xchip = true, talisman_echip = true, talisman_eechip = true, talisman_eeechip = true,
						talisman_emult = true, talisman_eemult = true, talisman_eeemult = true }

sendInfoMessage("Hooking play_sound...", "TOGAPack")
local playsoundref = play_sound
function play_sound(sound_code, per, vol)
	-- ...only if config is set to allow it.
	if togabalatro.config.DoMoreLogging and togabalatro.config.DoEvenMoreLogging then sendDebugMessage("play_sound hook.", "TOGAPack") end
	if togabalatro.config.SFXWhenTriggered and next(SMODS.find_card('j_toga_michaelrosen')) and ((togabalatro.config.SFXSwapLevel == 3) or (togabalatro.config.SFXSwapLevel == 2 and togabalatro.rosensfx[sound_code])) then sound_code = 'toga_rosenclick' end
	if G and G.GAME and G.GAME.blind and G.GAME.blind.boss and G.GAME.blind.config.blind.key == 'bl_toga_xpboss' and (togabalatro.config.SFXSwapLevel >= 2) then sound_code = 'toga_winxpcritstop' end
	
	playsoundref(sound_code, per, vol)
end

-- Y2K Sticker yoink.
local ischecking2s = false
sendInfoMessage("Hooking Card:is_face...", "TOGAPack")
local isfaceref = Card.is_face
function Card:is_face(from_boss)
	if togabalatro.config.DoMoreLogging and togabalatro.config.DoEvenMoreLogging then sendDebugMessage("Card:is_face hook.", "TOGAPack") end
	if next(SMODS.find_card('j_toga_y2ksticker')) then
		if not ischecking2s then
			ischecking2s = true
			if self:get_id() == 2 then ischecking2s = false; return true end
		end
		ischecking2s = false
	end
	ischecking2s = false
	local result = isfaceref(self, from_boss)
	local tuneupcalc = {}
	SMODS.calculate_context({ tuneupwizard = true }, tuneupcalc)
	for _, eval in pairs(tuneupcalc) do
		for key, eval2 in pairs(eval) do
			if eval2.flip and eval2.card then result = not result end
		end
	end
	return result
end

-- Hexa & Binary Joker and Megas XLR yoink.
local getiduse = false
sendInfoMessage("Hooking Card:get_id...", "TOGAPack")
local getidref = Card.get_id
function Card:get_id()
	if togabalatro.config.DoMoreLogging and togabalatro.config.DoEvenMoreLogging then sendDebugMessage("Card:get_id hook.", "TOGAPack") end
	if not getiduse then
		getiduse = true
		local id = getidref(self) or self.base.id
		if next(SMODS.find_card('j_toga_megasxlr')) and id == 8 then id = 13 end
		if next(SMODS.find_card('j_toga_hexadecimaljkr')) and id == 14 then id = 10 end
		if next(SMODS.find_card('j_toga_binaryjkr')) and id == 10 then id = 2 end
		getiduse = false
		return id
	else
		getiduse = false
		return getidref(self)
	end
end

-- This still feels hacky, tbh.
sendInfoMessage("Hooking Card:is_suit...", "TOGAPack")
local issuitref = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
	if togabalatro.config.DoMoreLogging and togabalatro.config.DoEvenMoreLogging then sendDebugMessage("Card:get_is_suit hook.", "TOGAPack") end
	if flush_calc then
		if next(SMODS.find_card('j_toga_heartyspades')) and next(SMODS.find_card('j_smeared'))
		and (self.base.suit == 'Hearts' or self.base.suit == 'Spades' or self.base.suit == 'Diamonds' or self.base.suit == 'Clubs') and (suit == 'Hearts' or suit == 'Spades' or suit == 'Diamonds' or suit == 'Clubs') then
			if togabalatro.config.DoMoreLogging then sendInfoMessage("Hearty Spades + Smeared Joker flush pass.", "TOGAPack") end
			return true
		end
		if next(SMODS.find_card('j_toga_heartyspades')) and not SMODS.has_no_suit(self) and (self.base.suit == 'Hearts' or self.base.suit == 'Spades') and (suit == 'Hearts' or suit == 'Spades') then
			if togabalatro.config.DoMoreLogging then sendInfoMessage("Hearty Spades flush pass.", "TOGAPack") end
			return true
		end
		return issuitref(self, suit, bypass_debuff, flush_calc)
	else
		if self.debuff and not bypass_debuff then return end
		if next(SMODS.find_card('j_toga_heartyspades')) and next(SMODS.find_card('j_smeared')) and not SMODS.has_no_suit(self)
		and (self.base.suit == 'Hearts' or self.base.suit == 'Spades' or self.base.suit == 'Diamonds' or self.base.suit == 'Clubs') and (suit == 'Hearts' or suit == 'Spades' or suit == 'Diamonds' or suit == 'Clubs') then
			if togabalatro.config.DoMoreLogging then sendInfoMessage("Hearty Spades + Smeared Joker pass.", "TOGAPack") end
			return true
		end
		if next(SMODS.find_card('j_toga_heartyspades')) and not SMODS.has_no_suit(self) and (self.base.suit == 'Hearts' or self.base.suit == 'Spades') and (suit == 'Hearts' or suit == 'Spades') then
			if togabalatro.config.DoMoreLogging then sendInfoMessage("Hearty Spades pass.", "TOGAPack") end
			return true
		end
		return issuitref(self, suit, bypass_debuff, flush_calc)
	end
end

sendInfoMessage("Hooking Card:should_hide_front...", "TOGAPack")
local shfref = Card.should_hide_front
function Card:should_hide_front()
	local ret = shfref(self)
	if ret and next(SMODS.find_card('j_toga_cavingjkr')) then return false
	elseif self.config.center.key == 'm_toga_glowstone' then return false
	else return ret end
end

-- This really shuffled my brain...
sendInfoMessage("Hooking CardArea:shuffle...", "TOGAPack")
local sonicshuffle = CardArea.shuffle
function CardArea:shuffle(_seed)
	local r = sonicshuffle(self, _seed)
	if self == G.deck then
		local otherc, smsc = {}, {}
		for i, k in ipairs(self.cards) do
			if SMODS.has_enhancement(k, 'm_toga_sms') then
				smsc[#smsc+1] = k
			else
				otherc[#otherc+1] = k
			end
		end
		for _, card in ipairs(otherc) do
			table.insert(smsc, card)
		end
		self.cards = smsc
		self:set_ranks()
	end
	return r
end

-- The G.FUNCS.draw_from_deck_to_hand hook has been moved to be a patch instead.

-- for a Boss/Showdown Blind...
sendInfoMessage("Hooking Blind:defeat...", "TOGAPack")
local blindkillref = Blind.defeat
function Blind:defeat(silent)
	if togabalatro.config.DoMoreLogging and togabalatro.config.DoEvenMoreLogging then sendDebugMessage("Blind:defeat hook.", "TOGAPack") end
	blindkillref(self, silent)
	if not G.GAME.dialupmodem and self.name == 'bl_toga_dialupmodem' then G.GAME.dialupmodem = true end
end

-- no disabley. :)
sendInfoMessage("Hooking Blind:disable...", "TOGAPack")
local bldisref = Blind.disable
function Blind:disable()
	if self.debuff.toga_no_disable then
		play_sound('toga_winxpcritstop', 1, 0.5)
		return
	end
	return bldisref(self)
end

sendInfoMessage("Hooking Game:update_game_over...", "TOGAPack")
local ugoref = Game.update_game_over
function Game:update_game_over(dt)
	if not G.STATE_COMPLETE then
		if G.GAME.selected_back.effect.center.key == 'b_toga_screamingdeck' and togabalatro.config.SFXWhenTriggered then play_sound('toga_soldierscream', 1, 0.4) end
		if G.GAME.selected_back.effect.center.key == 'b_toga_srb2kartdeck' and togabalatro.config.SpecialDeckMusic then G.toga_customdeckmusic = true; G.normal_music_speed = true end
		if next(SMODS.find_card('j_toga_spacecadetpinball', true)) and togabalatro.config.SFXWhenTriggered then play_sound('toga_pinballshutdown', 1, 0.4) end
	end
	ugoref(self, dt)
end

togabalatro.randomwintext = function()
	if togabalatro.config.SpecialDeckMusic then return localize('toga_srb2kartwin_'..math.random(1, 8)) end
end

local cuiboxwinref = create_UIBox_win
function create_UIBox_win()
	if togabalatro.config.SpecialDeckMusic and G.GAME.selected_back.effect.center.key == 'b_toga_srb2kartdeck' then
		local show_lose_cta = false
		local eased_green = copy_table(G.C.GREEN)
		eased_green[4] = 0
		ease_value(eased_green, 4, 0.5, nil, nil, true)
		local t = create_UIBox_generic_options({ padding = 0, bg_colour = eased_green, colour = G.C.BLACK, outline_colour = G.C.EDITION, no_back = true, no_esc = true, contents = {
			{n=G.UIT.R, config={align = "cm"}, nodes={
				{n=G.UIT.O, config={object = DynaText({string = {togabalatro.randomwintext() or localize('ph_you_win')}, colours = {G.C.EDITION}, shadow = true, float = true, spacing = 10, rotate = true, scale = 1.5, pop_in = 0.4, maxw = 6.5})}},
			}},
			{n=G.UIT.R, config={align = "cm", padding = 0.15}, nodes={
				{n=G.UIT.C, config={align = "cm"}, nodes={
					{n=G.UIT.R, config={align = "cm", padding = 0.08}, nodes={
						create_UIBox_round_scores_row('hand'),
						create_UIBox_round_scores_row('poker_hand'),
					}},
					{n=G.UIT.R, config={align = "cm"}, nodes={
						{n=G.UIT.C, config={align = "cm", padding = 0.08}, nodes={
							create_UIBox_round_scores_row('cards_played', G.C.BLUE),
							create_UIBox_round_scores_row('cards_discarded', G.C.RED),
							create_UIBox_round_scores_row('cards_purchased', G.C.MONEY),
							create_UIBox_round_scores_row('times_rerolled', G.C.GREEN),
							create_UIBox_round_scores_row('new_collection', G.C.WHITE),
							create_UIBox_round_scores_row('seed', G.C.WHITE),
							UIBox_button({button = 'copy_seed', label = {localize('b_copy')}, colour = G.C.BLUE, scale = 0.3, minw = 2.3, minh = 0.4,}),
						}},
						{n=G.UIT.C, config={align = "tr", padding = 0.08}, nodes={
							create_UIBox_round_scores_row('furthest_ante', G.C.FILTER),
							create_UIBox_round_scores_row('furthest_round', G.C.FILTER),
							{n=G.UIT.R, config={align = "cm", minh = 0.4, minw = 0.1}, nodes={}},
							show_win_cta and UIBox_button({id = 'win_cta', button = 'show_main_cta', label = {localize('b_next')}, colour = G.C.GREEN, scale = 0.8, minw = 2.5, minh = 2.5, focus_args = {nav = 'wide', snap_to = true}}) or nil,
							not show_win_cta and UIBox_button({id = 'from_game_won', button = 'notify_then_setup_run', label = {localize('b_start_new_run')}, minw = 2.5, maxw = 2.5, minh = 1, focus_args = {nav = 'wide', snap_to = true}}) or nil,
							not show_win_cta and {n=G.UIT.R, config={align = "cm", minh = 0.2, minw = 0.1}, nodes={}} or nil,
							not show_win_cta and UIBox_button({button = 'go_to_menu', label = {localize('b_main_menu')}, minw = 2.5, maxw = 2.5, minh = 1, focus_args = {nav = 'wide'}}) or nil,
						}}
					}},
					{n=G.UIT.R, config={align = "cm", padding = 0.08}, nodes={
						UIBox_button({button = 'exit_overlay_menu', label = {localize('b_endless')}, minw = 6.5, maxw = 5, minh = 1.2, scale = 0.7, shadow = true, colour = G.C.BLUE, focus_args = {nav = 'wide', button = 'x',set_button_pip = true}}),
					}},
				}}
			}}
		}})
		t.config.id = 'you_win_UI'
		return t
	else
		return cuiboxwinref()
	end
end

local cuiboxgameoverref = create_UIBox_game_over
function create_UIBox_game_over()
	if togabalatro.config.SpecialDeckMusic and G.GAME.selected_back.effect.center.key == 'b_toga_srb2kartdeck' and not togabalatro.checksiiva() then
		local show_lose_cta = false
		local eased_red = copy_table(G.GAME.round_resets.ante <= G.GAME.win_ante and G.C.RED or G.C.BLUE)
		eased_red[4] = 0
		ease_value(eased_red, 4, 0.8, nil, nil, true)
		local t = create_UIBox_generic_options({ bg_colour = eased_red ,no_back = true, padding = 0, contents = {
			{n=G.UIT.R, config={align = "cm"}, nodes={
				{n=G.UIT.O, config={object = DynaText({string = {localize('ph_game_over')}, colours = {G.C.RED},shadow = true, float = true, scale = 1.5, pop_in = 0.4, maxw = 6.5})}},
			}},
			{n=G.UIT.R, config={align = "cm", padding = 0.15}, nodes={
				{n=G.UIT.C, config={align = "cm"}, nodes={
					{n=G.UIT.R, config={align = "cm", padding = 0.05, colour = G.C.BLACK, emboss = 0.05, r = 0.1}, nodes={
						{n=G.UIT.R, config={align = "cm", padding = 0.08}, nodes={
							create_UIBox_round_scores_row('hand'),
							create_UIBox_round_scores_row('poker_hand'),
						}},
						{n=G.UIT.R, config={align = "cm"}, nodes={
							{n=G.UIT.C, config={align = "cm", padding = 0.08}, nodes={
								create_UIBox_round_scores_row('cards_played', G.C.BLUE),
								create_UIBox_round_scores_row('cards_discarded', G.C.RED),
								create_UIBox_round_scores_row('cards_purchased', G.C.MONEY),
								create_UIBox_round_scores_row('times_rerolled', G.C.GREEN),
								create_UIBox_round_scores_row('new_collection', G.C.WHITE),
								create_UIBox_round_scores_row('seed', G.C.WHITE),
								UIBox_button({button = 'copy_seed', label = {localize('b_copy')}, colour = G.C.BLUE, scale = 0.3, minw = 2.3, minh = 0.4, focus_args = {nav = 'wide'}}),
							}},
							{n=G.UIT.C, config={align = "tr", padding = 0.08}, nodes={
								create_UIBox_round_scores_row('furthest_ante', G.C.FILTER),
								create_UIBox_round_scores_row('furthest_round', G.C.FILTER),
								create_UIBox_round_scores_row('defeated_by'),
							}}
						}}
					}},
					show_lose_cta and 
					{n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
						{n=G.UIT.C, config={id = 'lose_cta', align = "cm", minw = 5, padding = 0.1, r = 0.1, hover = true, colour = G.C.GREEN, button = "show_main_cta", shadow = true}, nodes={
							{n=G.UIT.R, config={align = "cm", padding = 0, no_fill = true}, nodes={
							{n=G.UIT.T, config={text = localize('b_next'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT, focus_args = {nav = 'wide', snap_to = true}}}
							}}
						}}
					}} or
					{n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
						{n=G.UIT.R, config={id = 'from_game_over', align = "cm", minw = 5, padding = 0.1, r = 0.1, hover = true, colour = G.C.RED, button = "notify_then_setup_run", shadow = true, focus_args = {nav = 'wide', snap_to = true}}, nodes={
							{n=G.UIT.R, config={align = "cm", padding = 0, no_fill = true, maxw = 4.8}, nodes={
							{n=G.UIT.T, config={text = localize('b_start_new_run'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT}}
							}}
						}},
						{n=G.UIT.R, config={align = "cm", minw = 5, padding = 0.1, r = 0.1, hover = true, colour = G.C.RED, button = "go_to_menu", shadow = true, focus_args = {nav = 'wide'}}, nodes={
							{n=G.UIT.R, config={align = "cm", padding = 0, no_fill = true, maxw = 4.8}, nodes={
							{n=G.UIT.T, config={text = localize('b_main_menu'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT}}
							}}
						}}
					}}
				}},
			}}
		}})
		t.config.id = 'game_over_UI'
		return t
	else
		return cuiboxgameoverref()
	end
end

sendInfoMessage("Hooking Game:start_run...", "TOGAPack")
local gsrref = Game.start_run
function Game:start_run(args)
	local ret = gsrref(self, args)
	if self.toga_customdeckmusic then self.toga_customdeckmusic = nil; self.normal_music_speed = nil end
	if togabalatro.smiletriggeronce then togabalatro.smiletriggeronce = nil end
	return ret
end

sendInfoMessage("Hooking win_game...", "TOGAPack")
local yourewinner = win_game
function win_game()
	if G.GAME.selected_back.effect.center.key == 'b_toga_srb2kartdeck' and togabalatro.config.UseCustomModTabMusic then G.normal_music_speed = true; G.toga_normal_music_speed = true; G.toga_customdeckmusic = true end
	yourewinner()
end

-- Hook for Strength-like stuff.
sendInfoMessage("Hooking SMODS.modify_rank...", "TOGAPack")
local modifyrankref = SMODS.modify_rank
function SMODS.modify_rank(card, amount, manual_sprites)
	local vscalc = {}
	SMODS.calculate_context({ vs_modify_rank = true }, vscalc)
	for _, eval in pairs(vscalc) do
		for key, eval2 in pairs(eval) do
			if eval2.amount and eval2.card then amount = amount + eval2.amount end
		end
	end
	local bonzicalc = {}
	SMODS.calculate_context({ bonzi_modify_rank = true }, bonzicalc)
	for _, eval in pairs(bonzicalc) do
		for key, eval2 in pairs(eval) do
			if eval2.amount and eval2.card then amount = amount * eval2.amount end
		end
	end
	return modifyrankref(card, amount, manual_sprites)
end

-- Hooking for rank/suit-specific stuff.
local changebaseref = SMODS.change_base
function SMODS.change_base(card, suit, rank, manual_sprites)
	if next(SMODS.find_card('j_toga_certserver')) and G.GAME.current_round.togabalatro and G.GAME.current_round.togabalatro.certserver and G.GAME.current_round.togabalatro.certserver.rank and rank ~= nil then
		rank = G.GAME.current_round.togabalatro.certserver.rank
	end
	if next(SMODS.find_card('j_toga_regedit')) and G.GAME.current_round.togabalatro and G.GAME.current_round.togabalatro.regedit and G.GAME.current_round.togabalatro.regedit.suit and suit ~= nil then
		suit = G.GAME.current_round.togabalatro.regedit.suit
	end
    return changebaseref(card, suit, rank, manual_sprites)
end

-- Voucher redeem calculation.
sendInfoMessage("Hooking Card:apply_to_run...", "TOGAPack")
local applytorunref = Card.apply_to_run
function Card:apply_to_run(center)
	applytorunref(self, center)
	SMODS.calculate_context({ redeem_individual_voucher = true, voucher = center or self })
end

-- Hooking for suit-specific stuff.
sendInfoMessage("Hooking Card:change_suit...", "TOGAPack")
local changesuitref = Card.change_suit
function Card:change_suit(new_suit)
	if next(SMODS.find_card('j_toga_regedit')) and G.GAME.current_round.togabalatro and G.GAME.current_round.togabalatro.regedit and G.GAME.current_round.togabalatro.regedit.suit then
		new_suit = G.GAME.current_round.togabalatro.regedit.suit
	end
	changesuitref(self, new_suit)
end

-- Hooking for influencing hand level changes.
sendInfoMessage("Hooking level_up_hand...", "TOGAPack")
local lvluphandref = level_up_hand
function level_up_hand(card, hand, instant, amount)
	amount = amount or to_big(1)
	if to_big(amount) > to_big(0) then
		local xpcalc = {}
		SMODS.calculate_context({ toga_xplvlup = true }, xpcalc)
		for _, eval in pairs(xpcalc) do
			for key, eval2 in pairs(eval) do
				if eval2.card and SMODS.pseudorandom_probability(eval2.card, "experiencethebest", 1, eval2.odds or eval2.card.ability.extra.odds or 4, 'yesyoucan') then
					amount = amount * 2
					SMODS.calculate_effect({message = localize('k_upgrade_ex')}, eval2.card)
				end
			end
		end
	end
	lvluphandref(card, hand, instant, amount)
end

togabalatro.chipmultopswap = {
	['chips'] = 'mult',
	['h_chips'] = 'h_mult',
	['chip_mod'] = 'mult_mod',
	['mult'] = 'chips',
	['h_mult'] = 'h_chips',
	['mult_mod'] = 'chip_mod',
	['x_chips'] = 'x_mult',
	['xchips'] = 'xmult',
	['Xchip_mod'] = 'Xmult_mod',
	['x_mult'] = 'x_chips',
	['xmult'] = 'xchips',
	['Xmult'] = 'xchips',
	['x_mult_mod'] = 'Xchip_mod',
	['Xmult_mod'] = 'Xchip_mod',
	-- Talisman.
	['e_mult'] = 'e_chips',
	['emult'] = 'echips',
	['ee_mult'] = 'ee_chips',
	['eemult'] = 'eechips',
	['eee_mult'] = 'eee_chips',
	['eeemult'] = 'eeechips',
	['hypermult'] = 'hyperchips',
	['hyper_mult'] = 'hyper_chips',
	['e_chips'] = 'e_mult',
	['echips'] = 'emult',
	['ee_chips'] = 'ee_mult',
	['eechips'] = 'eemult',
	['eee_chips'] = 'eee_mult',
	['eeechips'] = 'eeemult',
	['hyperchips'] = 'hypermult',
	['hyper_chips'] = 'hyper_mult',
	['Emult_mod'] = 'Echip_mod',
	['EEmult_mod'] = 'EEchip_mod',
	['EEEmult_mod'] = 'EEEchip_mod',
	['hypermult_mod'] = 'hyperchip_mod',
	['Echip_mod'] = 'Emult_mod',
	['EEchip_mod'] = 'EEmult_mod',
	['EEEchip_mod'] = 'EEEmult_mod',
	['hyperchip_mod'] = 'hypermult_mod',
	-- Other mods can add their custom operations to this table.
}

togabalatro.chipmodkeys = {
	['chips'] = 'add', ['h_chips'] = 'add', ['chip_mod'] = 'add',
	['x_chips'] = 'mult', ['xchips'] = 'mult', ['Xchip_mod'] = 'mult',
	['e_chips'] = 'mult', ['echips'] = 'mult', ['Echip_mod'] = 'mult',
	['ee_chips'] = 'mult', ['eechips'] = 'mult', ['EEchip_mod'] = 'mult',
	['eee_chips'] = 'mult', ['eeechips'] = 'mult', ['EEEchip_mod'] = 'mult',
	['hyperchips'] = 'mult', ['hyper_chips'] = 'mult', ['hyperchip_mod'] = 'mult',
	-- Other mods can add their custom operations to this table.
}

togabalatro.multmodkeys = {
	['mult'] = 'add', ['h_mult'] = 'add', ['mult_mod'] = 'add',
	['x_mult'] = 'mult', ['xmult'] = 'mult', ['Xmult'] = 'mult', ['x_mult_mod'] = 'mult', ['Xmult_mod'] = 'mult',
	['e_mult'] = 'mult', ['emult'] = 'mult', ['Emult_mod'] = 'mult',
	['ee_mult'] = 'mult', ['eemult'] = 'mult', ['EEmult_mod'] = 'mult',
	['eee_mult'] = 'mult', ['eeemult'] = 'mult', ['EEEmult_mod'] = 'mult',
	['hypermult'] = 'mult', ['hyper_mult'] = 'mult', ['hypermult_mod'] = 'mult',
	-- Other mods can add their custom operations to this table.
}

sendInfoMessage("Hooking SMODS.calculate_individual_effect...", "TOGAPack")
local calcindiveffectref = SMODS.calculate_individual_effect
SMODS.calculate_individual_effect = function(effect, scored_card, key, amount, from_edition)
	-- do stuff if only the table is actually a table and has not been mangled by external factors.
	if type(togabalatro.chipmultopswap) == 'table' and togabalatro.chipmultopswap[key] then
		local activesyncs = SMODS.find_card('j_toga_activesync')
		if next(activesyncs) then
			for i = 1, #activesyncs do
				if SMODS.pseudorandom_probability(activesyncs[i], "msactivesync", 1, activesyncs[i].ability.extra.odds or 8, 'msactivesync') then
					local msg
					if string.find(key, 'chip') then msg = localize('toga_activesyncmult') elseif string.find(key, 'mult') then msg = localize('toga_activesyncchip') end
					if msg and not (Talisman and Talisman.config_file.disable_anims) then
						card_eval_status_text(activesyncs[i], 'extra', nil, nil, nil, {message = msg, colour = string.find(key, 'chip') and G.C.CHIPS or string.find(key, 'mult') and G.C.MULT, delay = 0.2})
					end
					key = togabalatro.chipmultopswap[key]
				end
			end
		end
		local jarate = SMODS.find_card('j_toga_jarate')
		if next(jarate) and amount then
			for i = 1, #jarate do
				if SMODS.pseudorandom_probability(jarate[i], "tf2jarate", 1, jarate[i].ability.extra.odds or 15, 'tf2jarate') then
					if not (Talisman and Talisman.config_file.disable_anims) then
						card_eval_status_text(jarate[i], 'extra', nil, nil, nil, {
							message = localize('toga_jarated'),
							sound = not silent and togabalatro.config.SFXWhenTriggered and "toga_jaratehit",
							pitch = not silent and togabalatro.config.SFXWhenTriggered and togabalatro.randompitch(),
							volume = 0.3,
							delay = 0.2
						})
					end
					amount = amount*jarate[i].ability.extra.minicrit
				end
			end
		end
	end
	if not tonumber(G.GAME.modifiers.toga_chipamtmod) then G.GAME.modifiers.toga_chipamtmod = 1 end
	if not tonumber(G.GAME.modifiers.toga_multamtmod) then G.GAME.modifiers.toga_multamtmod = 1 end
	local chipmod, multmod = 0+tonumber(G.GAME.modifiers.toga_chipamtmod), 0+tonumber(G.GAME.modifiers.toga_multamtmod)
	if togabalatro.chipmodkeys[key] and tonumber(chipmod) then
		amount = amount*chipmod
	elseif togabalatro.multmodkeys[key] and tonumber(multmod) then
		amount = amount*multmod
	end
	local ret = calcindiveffectref(effect, scored_card, key, amount, from_edition)
	if ret then return ret end
end

sendInfoMessage("Hooking Card_Character:add_speech_bubble...", "TOGAPack")
local cardcharaddspeechbubbleref = Card_Character.add_speech_bubble
function Card_Character:add_speech_bubble(text_key, align, loc_vars, quip_args)
	if self.config.args.center == 'c_toga_selfpropelledbomb' then return end
	cardcharaddspeechbubbleref(self, text_key, align, loc_vars, quip_args)
end

sendInfoMessage("Hooking Card_Character:say_stuff...", "TOGAPack")
local cardcharsaystuffref = Card_Character.say_stuff
function Card_Character:say_stuff(n, not_first, quip_key)
	if self.config.args.center == 'c_toga_selfpropelledbomb' then return end
	cardcharsaystuffref(self, n, not_first, quip_key)
end

-- weaponized negativity.
local negweightref = G.P_CENTERS['e_negative'].get_weight
G.P_CENTERS['e_negative'].get_weight = function(self)
	return negweightref(self)*(G.GAME.toga_negchance or 1)
end

-- Golden Wrench destruction...
togabalatro.goldenwrench = function(card)
	if card and card.config and card.config.center_key ~= 'j_toga_goldenwrench' then return end
	G.E_MANAGER:add_event(Event({
		func = function()
			for i = 1, #G.playing_cards do
				G.playing_cards[i]:set_ability(G.P_CENTERS.m_gold)
				G.playing_cards[i]:juice_up()
			end
			if togabalatro.config.SFXWhenTriggered and not silent then play_sound('toga_goldenhit', 1, 0.7) end -- insert sound here.
			return true
		end
	}))
end

-- Golden Wrench...
sendInfoMessage("Hooking Card:start_dissolve...", "TOGAPack")
local startdisref = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
	if self and self.config and self.config.center_key == 'j_toga_goldenwrench' and not self.ability.sold then togabalatro.goldenwrench(self) end
	startdisref(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
end

togabalatro.isplayingcardarea = function(target)
	local t = {}
	t[#t+1] = G.play
	t[#t+1] = G.hand
	t[#t+1] = G.deck
	t[#t+1] = G.discard
	-- TOGA-TARGET: add your own CardAreas for playing cards
	for i, v in ipairs(t) do
		if v == target then return true end
	end
	return false
end

sendInfoMessage("Hooking draw_card...", "TOGAPack")
local drawcardref = draw_card
function draw_card(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only)
	drawcardref(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only)
	if togabalatro.isplayingcardarea(to) and togabalatro.isplayingcardarea(from) then SMODS.calculate_context({ individual_draw = true, from_area = from, to_area = to }) end
end

togabalatro.externalfontsloaded = {}
togabalatro.getexternalfontcount = function()
	local count = 0
	for k, v in pairs(togabalatro.externalfontsloaded or {}) do
		if k and v then count = count + 1 end
	end
	return count
end

sendInfoMessage("Hooking love.graphics.newFont...", "TOGAPack")
local newfontref = love.graphics.newFont
function love.graphics.newFont(arg1, arg2, arg3, arg4)
	togabalatro.externalfontsloaded = togabalatro.externalfontsloaded or {}
	if type(arg1) == 'string' and not togabalatro.externalfontsloaded[arg1] then togabalatro.externalfontsloaded[arg1] = true end
	
	return newfontref(arg1, arg2, arg3, arg4)
end

sendInfoMessage("Hooking Card:set_debuff...", "TOGAPack")
local setdebuffref = Card.set_debuff
function Card:set_debuff(should_debuff)
	local prevstate = self.debuff
	setdebuffref(self, should_debuff)
    if self.debuff ~= prevstate and self.debuff == true then SMODS.calculate_context({ debuffed_ups = true, card = self }) end
end

local oldcalcdestroycard = SMODS.calculate_destroying_cards
function SMODS.calculate_destroying_cards(context, cards_destroyed, scoring_hand)
	oldcalcdestroycard(context, cards_destroyed, scoring_hand)
	for i,card in ipairs((context.cardarea or {}).cards or {}) do
		if card and card.atomsmashed then
			card.getting_sliced = true
			if SMODS.shatters(card) then
				card.shattered = true
			else
				card.destroyed = true
			end
			cards_destroyed[#cards_destroyed+1] = card
		end
	end
end

local easedolref = ease_dollars
function ease_dollars(mod, instant)
	if next(SMODS.find_card('j_toga_mswallet')) and G.STATE ~= G.STATES.SHOP and not G.shop then mod = mod * -1 end
    easedolref(mod, instant)
end

local quitref = love.quit
function love.quit()
	if G.jokers and next(SMODS.find_card('j_toga_notsosmileyface', true)) then
		local nssms = SMODS.find_card('j_toga_notsosmileyface', true)
		local nssm = pseudorandom_element(nssms, pseudoseed('toga_:)'))
		if nssm then
			G.FUNCS:exit_overlay_menu()
			card_eval_status_text(nssm, 'extra', nil, nil, nil, {message = localize('k_nope_ex'), colour = G.C.PURPLE, sound = 'tarot2'})
			return true
		end
	end
	quitref()
end

local gotomenuref = G.FUNCS.go_to_menu
function G.FUNCS.go_to_menu(e)
	if G.jokers and next(SMODS.find_card('j_toga_notsosmileyface', true)) then
		local nssms = SMODS.find_card('j_toga_notsosmileyface', true)
		local nssm = pseudorandom_element(nssms, pseudoseed('toga_:)'))
		if nssm and (not togabalatro.smiletriggeronce or math.random(1, 2) == 1) then
			togabalatro.smiletriggeronce = true
			G.FUNCS:exit_overlay_menu()
			card_eval_status_text(nssm, 'extra', nil, nil, nil, {message = localize('k_nope_ex'), colour = G.C.PURPLE, sound = 'tarot2'})
			return true
		end
	end
	gotomenuref(e)
end

local ismin, ismax = false, false
local loveupdref = love.update
local qeval, notifyrestart = togabalatro.config.EnableQE, false
local bmpcurval, notifyitemreinit = togabalatro.config.BMPAllItems, false
local kingcdival, notifykingcdi = togabalatro.config.KingCDIDeck, false
local wtfdeckval, notifywtfdeck = togabalatro.config.WTFDeck, false
local cfgrestartval = { ['EnableQE'] = true }
function love.update(dt)
	if togabalatro then
		-- Hello everybody, my name is Windiplier.
		if love.window.isMinimized() and not ismin then
			ismin = true
			togabalatro.playwindowsfx('min')
		elseif ismin and not love.window.isMinimized() then
			ismin = false
			togabalatro.playwindowsfx('restup')
		elseif love.window.isMaximized() and not ismax then
			ismax = true
			togabalatro.playwindowsfx('max')
		elseif ismax and not love.window.isMaximized() then
			ismax = false
			togabalatro.playwindowsfx('restdw')
		end
		
		if togabalatro.config.EnableQE ~= qeval and not notifyrestart then
			notifyrestart = true
			togabalatro.systemchanges({ source = 'qe', uifunc = togabalatro.needrestartqeui })
		end
		
		if togabalatro.config.BMPAllItems ~= bmpcurval and not notifyitemreinit then
			notifyitemreinit = true
			togabalatro.config.mpnotice = nil
			togabalatro.systemchanges({ source = 'bmp', uifunc = togabalatro.needrestartbmpui })
		end
		
		if togabalatro.config.KingCDIDeck ~= kingcdival and not notifykingcdi then
			notifykingcdi = true
			togabalatro.systemchanges({ source = 'kingcdi', uifunc = togabalatro.needrestartkingcdi })
		end
		
		if togabalatro.config.WTFDeck ~= wtfdeckval and not notifywtfdeck then
			notifywtfdeck = true
			togabalatro.systemchanges({ source = 'wtfdeck', uifunc = togabalatro.needrestartwtfdeck })
		end
	end
	
	loveupdref(dt)
end

local mmhook = Game.main_menu
function Game:main_menu(ctx)
    local r = mmhook(self,ctx)
	G.E_MANAGER:add_event(Event({
		func = function() togabalatro.msoobe() return true end
	}))
	if togabalatro.checkbmp() then
		G.E_MANAGER:add_event(Event({
			func = function() togabalatro.bmpnote() return true end
		}))
	end
	if togabalatro.stjcheck() then
		G.E_MANAGER:add_event(Event({
			func = function() togabalatro.stjnotice() return true end
		}))
	end
	if togabalatro.checksiiva() then
		G.E_MANAGER:add_event(Event({
			func = function() togabalatro.qualatronotice() return true end
		}))
	end
    return r
end

local calcrentref = Card.calculate_rental
function Card:calculate_rental()
    if G.GAME.modifiers.toga_norentperish then return end
	return calcrentref(self)
end

local calcperishref = Card.calculate_perishable
function Card:calculate_perishable()
	if self and self.ability and tonumber(self.ability.perish_tally) and self.ability.perish_tally > 0 and G.GAME.modifiers.toga_norentperish then return end
	return calcperishref(self)
end

local getflushref = get_flush
function get_flush(hand)
	local ret = getflushref(hand)
	if next(ret) then return ret end
	
	if not next(SMODS.find_card('j_toga_toiletrock')) then return {} end
	
	ret = {}
	local four_fingers = SMODS.four_fingers('flush')
	if #hand < four_fingers then return ret
	else
		local t = {}
		local stone_count = 0
		for i=1, #hand do
			if SMODS.has_enhancement(hand[i], 'm_stone') then stone_count = stone_count + 1; t[#t+1] = hand[i] end
		end
		if stone_count >= four_fingers then
			table.insert(ret, t)
			return ret
		end
		return {}
	end
end

local getstraightref = get_straight
function get_straight(hand, min_length, skip, wrap)
	local ret = getstraightref(hand, min_length, skip, wrap)
	if next(ret) then return ret end
	
	if not next(SMODS.find_card('j_toga_wishingstones')) then return {} end
	
    min_length = min_length or 5
    if min_length < 2 then min_length = 2 end
    if #hand < min_length then return {} end
	
	ret = {}
	local stone_count, t = 0, {}
	for i = 1, #hand do
		if SMODS.has_enhancement(hand[i], 'm_stone') then stone_count = stone_count + 1; t[#t+1] = hand[i] end
	end
	if stone_count >= min_length then
		table.insert(ret, t)
		return ret
	end

    return {}
end