-- We are loading...
sendInfoMessage("░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▐▓█▀▀▀▀▀▀▀▀█▓▌░▄▄▄▄▄░░", "TOGAPack")
sendInfoMessage("░█░░░█▀█░█▀█░█▀▄░█░█▄░█░█▀▀░░░░░░░░▐▓█░░░░░░░░█▓▌░█▄▄▄█░░", "TOGAPack")
sendInfoMessage("░█░░░█░█░█▀█░█░█░█░█░▀█░█░█░░░░░░░░▐▓█░░░░░░░░█▓▌░█▄▄▄█░░", "TOGAPack")
sendInfoMessage("░▀▀▀░▀▀▀░▀░▀░▀▀░░▀░▀░░▀░▀▀▀░░▀░▀░▀░▐▓█▄▄▄▄▄▄▄▄█▓▌░█████░░", "TOGAPack")
sendInfoMessage("░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▄▄██▄▄░░░░░█████░░", "TOGAPack")
sendInfoMessage("Hello World! Starting TOGAPack...", "TOGAPack")

-- Define thy map.
SMODS.Atlas{key = "TOGAJokersMain", path = "togajokers.png", px = 72, py = 95}
SMODS.Atlas{key = "TOGAJokersMainW", path = "togajokersw.png", px = 91, py = 95}
SMODS.Atlas{key = "TOGAJokersOther", path = "togajokersother.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGAJokersOtherDiffSize", path = "togajokersothersize.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGAJokersWindows", path = "togajokerswinos.png", px = 72, py = 95}
SMODS.Atlas{key = "TOGAJokersMac", path = "togamacos.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGAJokersLinux", path = "togalinuxos.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGAJokersUpdate", path = "togajokerupdate.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGAJokerRover", path = "togarover.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGABoosterPack", path = "togabooster.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGAConsumables", path = "togacons.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGADeckBack", path = "togadeck.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGATags", path = "togatags.png", px = 34, py = 34}
SMODS.Atlas{key = "TOGASeals", path = "togaseal.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGAEnhancements", path = "togaenh.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGAStickers", path = "togastickers.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGAStakes", path = "togastake.png", px = 29, py = 29}
SMODS.Atlas{key = "TOGADialUpBlind", path = "togadialupblind.png", px = 34, py = 34, atlas_table = 'ANIMATION_ATLAS', frames = 24}
SMODS.Atlas{key = "TOGAWWWBlind", path = "togawwwblind.png", px = 34, py = 34, atlas_table = 'ANIMATION_ATLAS', frames = 32}
SMODS.Atlas{key = "TOGAOtherBlind", path = "togaotherblind.png", px = 34, py = 34, atlas_table = 'ANIMATION_ATLAS', frames = 1}
SMODS.Atlas{key = "TOGAMoreIcons", path = "togamoricons.png", px = 36, py = 36, disable_mipmap = true}
SMODS.Atlas{key = "TOGAFunny", path = "togazefunny.png", px = 64, py = 64, atlas_table = 'ANIMATION_ATLAS', frames = 9}
SMODS.Atlas{key = "TOGAFunnyStatic", path = "togazefunny.png", px = 64, py = 64}
SMODS.Atlas{key = "modicon", path = "togaicon.png", px = 32, py = 32}

-- Hear me scream.
SMODS.Sound({key = "win95start", path = "win95start.ogg"}) -- The Microsoft Sound (95 & NT4)
SMODS.Sound({key = "win95tada", path = "win95tada.ogg"}) -- tada.wav (3.x, 95 & NT4)
SMODS.Sound({key = "bells", path = "startup/bells.wav"}) -- Windows 3.0 MME
SMODS.Sound({key = "gong", path = "startup/GONG.WAV"}) -- Windows 3.0 MME
SMODS.Sound({key = "w96", path = "startup/w96.wav"}) -- Custom Windows Startup
SMODS.Sound({key = "w94", path = "startup/w94.wav"}) -- Custom Windows Startup
SMODS.Sound({key = "money9597", path = "startup/mm9597.wav"}) -- Microsoft Money 95/97
SMODS.Sound({key = "money9899", path = "startup/mm9899.ogg"}) -- Microsoft Money 98/99
SMODS.Sound({key = "longhorn", path = "startup/longhorn.wav"}) -- "Longhorn Startup" / Samsung Theme for Windows XP
SMODS.Sound({key = "ntreskit", path = "startup/ntreskit.ogg"}) -- Windows NT4 Resource Kit
SMODS.Sound({key = "chordold", path = "chordold.wav"}) -- chord.wav (95 & NT4)
SMODS.Sound({key = "chord", path = "chord.wav"}) -- chord.wav (98, ME, 2000 and XP)
SMODS.Sound({key = "win98start", path = "win98start.ogg"}) -- The Microsoft Sound (98) [edited]
SMODS.Sound({key = "win98tada", path = "win98tada.ogg"}) -- tada.wav (98, ME, 2000 and XP)
SMODS.Sound({key = "winme2000start", path = "winmestart.ogg"}) -- Windows Logon Sound for ME/2000 [edited]
SMODS.Sound({key = "winme2000shutdown", path = "winmeshutdown.ogg"}) -- Windows Logoff Sound for ME/2000 [edited]
SMODS.Sound({key = "winnt4startorig", path = "Windows NT Logon Sound.wav"}) -- Windows Logon Sound for NT4 [original]
SMODS.Sound({key = "winnt4start", path = "winnt4start.ogg"}) -- Windows Logon Sound for NT4 [edited]
SMODS.Sound({key = "winnt4shutdown", path = "winnt4shutdown.ogg"}) -- Windows Logoff Sound for NT4 [edited]
SMODS.Sound({key = "winxplogon", path = "Windows XP Logon Sound.wav"}) -- Windows Logon Sound, XP
SMODS.Sound({key = "winxplogoff", path = "Windows XP Logoff Sound.wav"}) -- Windows Logoff Sound, XP
SMODS.Sound({key = "winxpyesyoucan", path = "theexperience.ogg"}) -- Snippet from Windows XP Tour
SMODS.Sound({key = "winxpcritstop", path = "Windows XP Critical Stop.wav"}) -- Critical Stop, XP
SMODS.Sound({key = "winxpballoon", path = "Windows XP Balloon.wav"}) -- Critical Stop, XP
SMODS.Sound({key = "winxpinfobar", path = "Windows XP Information Bar.wav"}) -- Information Bar, XP
SMODS.Sound({key = "winvista78logon", path = "winvista78logon.wav"}) -- Startup/Logon, Vista, 7 & 8.x
SMODS.Sound({key = "winvista78logoff", path = "winvista78logoff.wav"}) -- Logoff, Vista, 7 & 8.x
SMODS.Sound({key = "winvista7critstop", path = "winvista7critstop.wav"}) -- Critical Stop, Vista, 7
SMODS.Sound({key = "win8error", path = "win8bg.wav"}) -- Windows Background, 8.x
SMODS.Sound({key = "ssb64crowdohh", path = "Crowd Ohhh.ogg"}) -- Crowd Ohhh from Super Smash Bros 64
SMODS.Sound({key = "duck", path = "duck.ogg"}) -- Mac OS 9 Quack
SMODS.Sound({key = "kcud", path = "kcud.ogg"}) -- kcauQ 9 SO caM
SMODS.Sound({key = "ie31", path = "1.wav"}) -- Internet Explorer 3 Administration Kit Autorun
SMODS.Sound({key = "access97", path = "Microsoft Access 97 Sound.wav"}) -- Microsoft Access 97
SMODS.Sound({key = "recyclebinsfx", path = "recycle.ogg"}) -- recycle.wav (98, ME, 2000) 
SMODS.Sound({key = "plus98emptybin", path = "WI_EMPTY.WAV"}) -- Plus! 98, Windows 98 Empty Recycle Bin
SMODS.Sound({key = "infraredbegin", path = "ir_begin.ogg"}) -- Infrared Begin (starting infrared activity?)
SMODS.Sound({key = "infraredend", path = "ir_end.ogg"}) -- Infrared End (ending infrared activity?)
SMODS.Sound({key = "o97doorbell", path = "doorbell.wav"}) -- doorbell.wav from Office 97 Multimedia
SMODS.Sound({key = "o97glide", path = "glide.wav"}) -- glide.wav from Office 97 Multimedia
SMODS.Sound({key = "mmeclap", path = "CLAP.WAV"}) -- clap.wav from Windows 3.0 MME
SMODS.Sound({key = "officehammer", path = "HAMMER.WAV"}) -- hammer.wav from Microsoft Office sounds, unused as of 1.7.1-RC1
SMODS.Sound({key = "roverbark", path = "roverbark.ogg"}) -- 0002.wav, Microsoft Agent - Rover
SMODS.Sound({key = "mscmenucmd", path = "Musica Menu Command.ogg"}) -- Musica Sound Scheme (95 & NT4)
SMODS.Sound({key = "spb", path = "kc57.ogg"}) -- Unused in Knuckles Chaotix, Self-Propelled Bomb targeting first place in SRB2Kart/Dr. Robotnik's Ring Racers.
SMODS.Sound({key = "thundershield", path = "DSZIO3.ogg"}) -- Thunder Shield
SMODS.Sound({key = "anviluse", path = "mcanviluse.ogg"}) -- Snippet of block.anvil.use, Minecraft
SMODS.Sound({key = "xporb", path = "mcxp.ogg"}) -- Experience, Minecraft
SMODS.Sound({key = "pinballstart", path = "SOUND4.WAV"}) -- Round Start, Plus! 98 - Space Cadet Pinball Demo
SMODS.Sound({key = "pinballshutdown", path = "SOUND68.WAV"}) -- Board Shut Down - Space Cadet Pinball Demo
SMODS.Sound({key = "pinballloseball", path = "SOUND27.WAV"}) -- Lose Ball, Plus! 98 - Space Cadet Pinball Demo
SMODS.Sound({key = "pinballsfx8", path = "pinball/SOUND8.WAV"}) -- Space Cadet Pinball Demo SFX
SMODS.Sound({key = "pinballsfx14", path = "pinball/SOUND14.WAV"}) -- Space Cadet Pinball Demo SFX
SMODS.Sound({key = "pinballsfx16", path = "pinball/SOUND16.WAV"}) -- Space Cadet Pinball Demo SFX
SMODS.Sound({key = "pinballsfx21", path = "pinball/SOUND21.WAV"}) -- Space Cadet Pinball Demo SFX
SMODS.Sound({key = "pinballsfx24", path = "pinball/SOUND24.WAV"}) -- Space Cadet Pinball Demo SFX
SMODS.Sound({key = "pinballsfx26", path = "pinball/SOUND26.WAV"}) -- Space Cadet Pinball Demo SFX
SMODS.Sound({key = "pinballsfx43", path = "pinball/SOUND43.WAV"}) -- Space Cadet Pinball Demo SFX
SMODS.Sound({key = "pinballsfx49", path = "pinball/SOUND49.WAV"}) -- Space Cadet Pinball Demo SFX
SMODS.Sound({key = "pinballsfx53", path = "pinball/SOUND53.WAV"}) -- Space Cadet Pinball Demo SFX
SMODS.Sound({key = "pinballsfx55", path = "pinball/SOUND55.WAV"}) -- Space Cadet Pinball Demo SFX
SMODS.Sound({key = "rosenclick", path = "rosenclick.ogg"}) -- *click* Nice. - Michael Rosen
SMODS.Sound({key = "rosenhello", path = "rosenhello.ogg"}) -- self explanatory, same as above.
SMODS.Sound({key = "rosenbye", path = "rosenthatsashame.ogg"}) -- self explanatory, same as above.
SMODS.Sound({key = "rosenah", path = "rosenah.ogg"}) -- self explanatory, same as above.
SMODS.Sound({key = "scalesofjustice", path = "ScalesOfJustice.wav"}) -- self explanatory, Worms Armageddon/World Party.
SMODS.Sound({key = "failsfx", path = "comedicfail.ogg"}) -- fart.mp3
SMODS.Sound({key = "goldenhit", path = "Saxxy_impact_gen_06.ogg"}) -- getting a kill with a Golden Wrench, Saxxy or Golden Frying Pan, TF2
SMODS.Sound({key = "jaratehit", path = "crit_hit_mini.wav"}) -- Minicrits, TF2
SMODS.Sound({key = "soldierscream", path = "screm.ogg"}) -- TF2 Soldier screaming?
SMODS.Sound({key = "bass", path = "bass.ogg"}) -- Roblox Bass / Kik-Arse Bass Soundfont (2007) / Zero-G Sample Disc Bass 4 (1990s)
SMODS.Sound({key = "mcprf5400", path = "macperforma5400.ogg"}) -- Mac Performa 5400 (Death Chime)
SMODS.Sound({key = "dingy", path = "ding.wav"}) -- ding.wav (98, ME, 2000 and XP)

-- I command you to execute.
SMODS.Sound({key = "win95pluscmd1", path = "plus95/Dangerous Creatures menu command.ogg"})
SMODS.Sound({key = "win95pluscmd2", path = "plus95/Inside your Computer menu command.ogg"})
SMODS.Sound({key = "win95pluscmd3", path = "plus95/Jungle menu command.ogg"})
SMODS.Sound({key = "win95pluscmd4", path = "plus95/Leonardo da Vinci menu command.ogg"})
SMODS.Sound({key = "win95pluscmd5", path = "plus95/Mystery menu command.ogg"})
SMODS.Sound({key = "win95pluscmd6", path = "plus95/Nature menu command.ogg"})
SMODS.Sound({key = "win95pluscmd7", path = "plus95/Science menu command.ogg"})
SMODS.Sound({key = "win95pluscmd8", path = "plus95/Space menu command.ogg"})
SMODS.Sound({key = "win95pluscmd9", path = "plus95/Sports menu command.ogg"})
SMODS.Sound({key = "win95pluscmd10", path = "plus95/The 60's USA menu command.ogg"})
SMODS.Sound({key = "win95pluscmd11", path = "plus95/The Golden Era menu command.ogg"})
SMODS.Sound({key = "win95pluscmd12", path = "plus95/Windows 95 menu command.ogg"})
SMODS.Sound({key = "win95pluscmd13", path = "plus95/Travel menu command.ogg"})

-- wmplayer.exe > balatro♠ost.mid
SMODS.Sound({
	key = "music_balatro98",
	path = "balatro98.ogg",
	select_music_track = function()
		return (not togabalatro.checksiiva()) and togabalatro.config.UseCustomMMMusic and G.STAGE == G.STAGES.MAIN_MENU
		or togabalatro.config.BoosterPackMusic and G.pack_cards and not G.screenwipe and G.STATE == G.STATES.SMODS_BOOSTER_OPENED and SMODS.OPENED_BOOSTER
		and (SMODS.OPENED_BOOSTER.config.center.key == 'p_toga_togazipboosterpack' or SMODS.OPENED_BOOSTER.config.center.key == 'p_toga_togaziparchivepack'
		or SMODS.OPENED_BOOSTER.config.center.key == 'p_toga_togararpack' or SMODS.OPENED_BOOSTER.config.center.key == 'p_toga_togacardcabpack'
		or SMODS.OPENED_BOOSTER.config.center.key == 'p_toga_togaxcopydnapack') and 2
	end,
})

SMODS.Sound({
	key = "music_spbattacklose",
	path = "O_SPBA_L.ogg",
	select_music_track = function()
		return G.STATE == G.STATES.GAME_OVER and togabalatro.config.SpecialDeckMusic and G.GAME.selected_back.effect.center.key == 'b_toga_srb2kartdeck'
		and G.OVERLAY_MENU and G.OVERLAY_MENU:get_UIE_by_ID('game_over_UI') and not togabalatro.checksiiva() and 69420
	end,
	sync = false,
	pitch = 1,
	volume = 0.2
})

SMODS.Sound({
	key = "music_spbattackwin",
	path = "O_SPBA_W.ogg",
	select_music_track = function()
		return G.SETTINGS.paused and G.GAME.won and togabalatro.config.SpecialDeckMusic and G.GAME.selected_back.effect.center.key == 'b_toga_srb2kartdeck'
		and G.OVERLAY_MENU and G.OVERLAY_MENU:get_UIE_by_ID('you_win_UI') and not togabalatro.checksiiva() and 69420
	end,
	sync = false,
	pitch = 1,
	volume = 0.2
})

SMODS.Sound({
	key = "music_upgradestation",
	path = "upgradestation.ogg",
	pitch = 1,
	select_music_track = function()
		return togabalatro.config.UseCustomModTabMusic and SMODS.LAST_SELECTED_MOD_TAB and G.ACTIVE_MOD_UI and G.ACTIVE_MOD_UI.id == "TOGAPack" and not togabalatro.checksiiva() and 2
	end,
})

SMODS.Sound({
	key = "music_shhh",
	path = "silence.ogg",
	pitch = 1,
	select_music_track = function()
		return G.OVERLAY_MENU and G.OVERLAY_MENU:get_UIE_by_ID('toga_intro') and 69e42
	end,
	sync = false,
})

-- I think, therefore, I am.
togabalatro = SMODS.current_mod

assert(SMODS.load_file("tabs.lua"))()

togabalatro.custom_ui = function(modNodes)
	if math.random(1, 10) == 5 then
		table.insert(modNodes, #modNodes+1, {n = G.UIT.R, config = {r = 0.1, align = "cm", padding = 0.1}, nodes = {
			{n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {
				{n = G.UIT.O, config = { w = 1, h = 1, object = AnimatedSprite(0, 0, 1, 1, G.ANIMATION_ATLAS['toga_TOGAFunny'], { x = 0, y = 0 }) } },
			}},
		}})
	end
end

togabalatro.description_loc_vars = function(self)
	return {
		scale = 1.25,
		text_colour = HEX('FFFFFF'),
		background_colour = HEX('2B2B2B')
	}
end

togabalatro.debug_info = {
	QEDeck = togabalatro.config.EnableQE,
	JokeItems = togabalatro.config.JokeJokersActive,
	MainlineItems = togabalatro.config.ShowPower,
	NerfedItems = togabalatro.config.UseNerfed,
	Logging = togabalatro.config.DoMoreLogging and togabalatro.config.DoEvenMoreLogging and "Full" or togabalatro.config.DoMoreLogging and "Normal" or false,
	KingCDIDeck = togabalatro.config.KingCDIDeck,
	WITDeck = togabalatro.config.WTFDeck,
	BMPForceAllItems = BMP and togabalatro.config.BMPAllItems or nil,
	SlayTheJokersCompat = SMODS.Mods['SlayTheJokers'] and SMODS.Mods['SlayTheJokers'].can_load or nil
}

togabalatro.optional_features = function()
	return {
		retrigger_joker = true,
		quantum_enhancements = togabalatro.config.EnableQE and true or nil
	}
end

togabalatro.set_debuff = function(card)
	if SMODS.has_enhancement(card, 'm_toga_nickel') then return 'prevent_debuff' end
end

togabalatro.nfs = require('nativefs')
togabalatro.errorhandler = function()
	if togabalatro.config.DoCrashSFX and not togabalatro.crashtrig then
		local crashdata = love.filesystem.newFileData(togabalatro.nfs.read(togabalatro.path.."/assets/sounds/macperforma5400.ogg"))
		if crashdata then
			local crashsfx = love.sound.newSoundData(crashdata)
			if crashsfx then
				local crashsource = love.audio.newSource(crashsfx, 'static')
				if crashsource then
					crashsource:setVolume(0.33)
					love.audio.play(crashsource)
				end
			end
		end
	end
	togabalatro.crashtrig = true
end

togabalatro.rlt = function()
	G:set_language()
	G:init_item_prototypes()
end

togabalatro.mancrash = function()
	G.E_MANAGER:add_event(Event({
		func = function() error('Manually initiated crash.', 0) return true end
	}))
end

togabalatro.getrandcons = function(seed)
	seed = seed or 'grep'
	local getconspool = get_current_pool('Consumeables')
	local curcons, iter, iterlimit = nil, 0, 2222
	while iter < iterlimit do
		curcons = pseudorandom_element(getconspool, pseudoseed(seed))
		if curcons ~= "UNAVAILABLE" then break end
	end
	if curcons and curcons ~= "UNAVAILABLE" then return curcons else return "c_tower" end
end

togabalatro.iswindows = function(card)
	if card.config.center.key == 'j_toga_win95' or card.config.center.key == 'j_toga_win98'
	or card.config.center.key == 'j_toga_win98' or card.config.center.key == 'j_toga_winmillenium'
	or card.config.center.key == 'j_toga_win2000' or card.config.center.key == 'j_toga_winxp'
	or card.config.center.key == 'j_toga_winvista' or card.config.center.key == 'j_toga_win7'
	or card.config.center.key == 'j_toga_win8' then return true end
end

togabalatro.performpseudolag = function()
	if not togabalatro.pseudolag then -- restrict so we don't go too crazy.
		togabalatro.pseudolag = true
		if togabalatro.cursorsupport then love.mouse.setCursor(love.mouse.getSystemCursor("waitarrow")) end
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = math.random()*G.SETTINGS.GAMESPEED/2,
			func = function()
				togabalatro.pseudolag = nil
				if togabalatro.cursorsupport then love.mouse.setCursor(love.mouse.getSystemCursor("arrow")) end
				return true
			end
		}))
	end
end

togabalatro.systemtype = function()
	local stype = love.system.getOS()
	if stype == 'Windows' then return 'Windows'
	elseif stype == 'OS X' or stype == 'Linux' then return 'UNIX'
	elseif stype == 'Android' or stype == 'iOS' then return 'Mobile ('..stype..')' -- how.
	end
end

togabalatro.curcpucount = love.system.getProcessorCount()
togabalatro.cursorsupport = love.mouse.isCursorSupported()
togabalatro.curos = togabalatro.systemtype()

function os.capture(cmd, raw)
	local f = assert(io.popen(cmd, 'r'))
	local s = assert(f:read('*a'))
	f:close()
	if raw then return s end
	s = string.gsub(s, '^%s+', '')
	s = string.gsub(s, '%s+$', '')
	s = string.gsub(s, '[\n\r]+', ' ')
	return s
end

function togabalatro.mlineproc(s)
	local t = {}
	local i = 1
	for str in string.gmatch(s, "[^\r\n]+") do
		t[i] = str
		i = i + 1
	end
	return t
end

-- Initialize the process information during load of this mod into a table. Previously, this was active
-- in a constant loop, which could cause excessive unfocusing of the game as the system executed the function.
-- Now, we do it just once here instead.
if togabalatro.curos == 'Windows' then togabalatro.tasklisttable = togabalatro.mlineproc(os.capture('tasklist', true))
elseif togabalatro.curos == 'UNIX' then togabalatro.tasklisttable = togabalatro.mlineproc(os.capture('ps -e', true)) end

-- If we still got nothing, just make the table blank.
if not togabalatro.tasklisttable then togabalatro.tasklisttable = {} end

-- Check for specific process name.
togabalatro.getprocessamount = function(process)
	process = string.lower(process) or 'whereismysupersuit'
	local count = 0
	for k, v in pairs(togabalatro.tasklisttable or {}) do
		if string.find(v, process) then count = count + 1 end
	end
	return count
end

togabalatro.processcounts = {}
togabalatro.processcounts.chrome = togabalatro.getprocessamount('Chrome')
togabalatro.processcounts.firefox = togabalatro.getprocessamount('Firefox')

togabalatro.startupsfx = {'toga_w96', 'toga_w94', 'toga_bells', 'toga_ntreskit', 'toga_longhorn', 'toga_gong', 'toga_money9597', 'toga_money9899'}
togabalatro.verifysfxconfig = function()
	togabalatro.config.StartUpSFX = type(togabalatro.config.StartUpSFX) == 'table' and togabalatro.config.StartUpSFX or {}
	togabalatro.config.StartUpSFX.Selected = togabalatro.config.StartUpSFX.Selected or 1
	togabalatro.config.StartUpSFX.UseSelected = togabalatro.config.StartUpSFX.UseSelected or false
end
togabalatro.execstartupsfx = function(change_context)
	if not togabalatro.has_tried_startup and togabalatro.config.StartUpSound then
		togabalatro.verifysfxconfig()
		if not togabalatro.config.StartUpSFX.UseSelected or togabalatro.config.StartUpSFX.Selected == nil then
			togabalatro.config.StartUpSFX.Selected = math.random(1, #togabalatro.startupsfx)
		end
		play_sound(togabalatro.startupsfx[togabalatro.config.StartUpSFX.Selected], 1, 0.5)
	end
	togabalatro.has_tried_startup = true
	
	-- Sneak our title screen card addition here.
	local replace_card = Card(G.title_top.T.x, G.title_top.T.y, G.CARD_W, G.CARD_H, nil, G.P_CENTERS.j_toga_win95)
	replace_card.click = function() G.FUNCS.openModUI_TOGAPack() end
	G.title_top.T.w = G.title_top.T.w*1.7675
	G.title_top.T.x = G.title_top.T.x - 0.8
	replace_card.T.w = replace_card.T.w*1.1*1.2
	replace_card.T.h = replace_card.T.h*1.1*1.2
    G.title_top:emplace(replace_card)

    replace_card.states.visible = false
    replace_card.no_ui = true
    replace_card.ambient_tilt = 0.0

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = change_context == 'game' and 1.5 or 0,
        blockable = false,
        blocking = false,
        func = (function()
            if change_context == 'splash' then 
                replace_card.states.visible = true
                replace_card:start_materialize({G.C.WHITE,G.C.WHITE}, true, 2.5)
                play_sound('whoosh1', math.random()*0.1 + 0.3,0.3)
                play_sound('crumple'..math.random(1,5), math.random()*0.2 + 0.6,0.65)
            else
                replace_card.states.visible = true
                replace_card:start_materialize({G.C.WHITE,G.C.WHITE}, nil, 1.2)
            end
            G.VIBRATION = G.VIBRATION + 1
            return true
    end)}))
end

SMODS.ObjectType{
	object_type = "ObjectType",
	key = "TOGAJKR",
	default = "j_toga_win95",
	cards = {
		["j_toga_win95"] = true, ["j_toga_win98"] = true, ["j_toga_winmillenium"] = true, ["j_toga_winnt4"] = true,
		["j_toga_win2000"] = true, ["j_toga_winxp"] = true, ["j_toga_winvista"] = true, ["j_toga_win7"] = true,
		["j_toga_win8"] = true, ["j_toga_useraccounts"] = true, ["j_toga_virtualmemory"] = true,
		["j_toga_computerlock"] = true, ["j_toga_recyclebin"] = true, ["j_toga_theinternet"] = true,
		["j_toga_bonusducks"] = true, ["j_toga_spacecadetpinball"] = true, ["j_toga_jokersrb2kart"] = true,
		["j_toga_heartyspades"] = true, ["j_toga_systemrestore"] = true, ["j_toga_mcanvil"] = true, 
		["j_toga_bonusducks"] = true, ["j_toga_speedsneakers"] = true, ["j_toga_internetexplorer"] = true,
		["j_toga_megasxlr"] = true, ["j_toga_asterism"] = true, ["j_toga_theinternet"] = true,
		["j_toga_binaryjkr"] = true, ["j_toga_hexadecimaljkr"] = true, ["j_toga_y2ksticker"] = true,
		["j_toga_jimboplus"] = true, ["j_toga_tomscott"] = true, ["j_toga_goldenwrench"] = true,
		["j_toga_skype"] = true, ["j_toga_msn"] = true, ["j_toga_mac_os_9"] = true, 
		["j_toga_mac_os_x"] = true, ["j_toga_linux_ubuntu"] = true, ["j_toga_linux_debian"] = true,
		["j_toga_linux_slackware"] = true, ["j_toga_linux_redhat"] = true, ["j_toga_tempinternetfiles"] = true,
		["j_toga_google"] = true, ["j_toga_bonzibuddy"] = true, ["j_toga_netscapenavigator"] = true,
		["j_toga_diskcleanup"] = true, ["j_toga_regedit"] = true, ["j_toga_msagent"] = true,
		["j_toga_drwatson"] = true, ["j_toga_fontsfolder"] = true, ["j_toga_pcmcia"] = true,
		["j_toga_scsi"] = true, ["j_toga_visualstudio"] = true, ["j_toga_printershare"] = true,
		["j_toga_netshow"] = true, ["j_toga_certserver"] = true, ["j_toga_cpu"] = true,
		["j_toga_ups"] = true, ["j_toga_hammer"] = true, ["j_toga_joker203"] = true,
		["j_toga_chrome"] = true, ["j_toga_firefox"] = true, ["j_toga_cavingjkr"] = true,
		["j_toga_miningjkr"] = true, ["j_toga_virtualpc"] = true, ["j_toga_tuneupwizard"] = true,
		["j_toga_desktop"] = true, ["j_toga_mswallet"] = true, ["j_toga_nonebattery"] = true,
		["j_toga_dragndrop"] = true, ["j_toga_repairdisk"] = true, ["j_toga_merlin"] = true,
		["j_toga_briefcase"] = true, ["j_toga_vga"] = true, ["j_toga_mshome"] = true,
		["j_toga_gamecontrollers"] = true, ["j_toga_wincatalog"] = true, ["j_toga_monitor"] = true,
		["j_toga_notsosmileyface"] = true, ["j_toga_rloctane"] = true, ["j_toga_wscript"] = true,
		["j_toga_toiletrock"] = true, ["j_toga_wishingstones"] = true, ["j_toga_stoneroad"] = true,
	}
}

G.FUNCS.togabalatro_startupsfx = function(args)
	if not args or args.to_key == nil then return end
	togabalatro.verifysfxconfig()
	togabalatro.config.StartUpSFX.Selected = args.to_key
	SMODS.save_mod_config(togabalatro)
end
G.FUNCS.togabalatro_playsfx = function()
	togabalatro.verifysfxconfig()
	play_sound(togabalatro.startupsfx[togabalatro.config.StartUpSFX.Selected], 1, 0.5)
end
G.FUNCS.togabalatro_sfxswapcfg = function(args)
	if not args or args.to_key == nil then return end
	togabalatro.config.SFXSwapLevel = args.to_key
	SMODS.save_mod_config(togabalatro)
end
G.FUNCS.togabalatro_jokeitems = function(args)
	if not args or args.to_key == nil then return end
	togabalatro.config.JokeJokersActive = args.to_key == 1 and true or false
	togabalatro.updatecollectionitems()
	SMODS.save_mod_config(togabalatro)
	G.FUNCS.openModUI_TOGAPack()
end
G.FUNCS.togabalatro_poweritems = function(args)
	if not args or args.to_key == nil then return end
	togabalatro.config.ShowPower = args.to_key == 1 and true or false
	togabalatro.updatecollectionitems()
	SMODS.save_mod_config(togabalatro)
	G.FUNCS.openModUI_TOGAPack()
end
G.FUNCS.togabalatro_themeselect = function(args)
	if not args or args.to_key == nil then return end
	togabalatro.config.WindowSFXTheme = args.to_key
	SMODS.save_mod_config(togabalatro)
end

togabalatro.updatecollectionitems = function()
	for _, t in ipairs{G.P_CENTERS, G.P_TAGS, G.P_SEALS} do
		for k, v in pairs(t) do
			if (v.original_mod or {}).id == 'TOGAPack' and not v.remainhidden then
				if v.jokeitem then
					if togabalatro.config.JokeJokersActive then v.no_collection = nil else v.no_collection = true end
				end
				if v.poweritem then
					if togabalatro.config.ShowPower then v.no_collection = nil else v.no_collection = true end
				end
			end
		end
	end
end

-- The window do be moving.
SMODS.Sound({key = "win95plusmin1", path = "plus95/Dangerous Creatures minimize.ogg"})
SMODS.Sound({key = "win95plusmax1", path = "plus95/Dangerous Creatures maximize.ogg"})

SMODS.Sound({key = "win95plusmin2", path = "plus95/Inside your Computer minimize.ogg"})
SMODS.Sound({key = "win95plusmax2", path = "plus95/Inside your Computer maximize.ogg"})
SMODS.Sound({key = "win95plusrestup2", path = "plus95/Inside your Computer restore up.ogg"})
SMODS.Sound({key = "win95plusrestdw2", path = "plus95/Inside your Computer restore down.ogg"})

SMODS.Sound({key = "win95plusmin3", path = "plus95/Jungle minimize.ogg"})
SMODS.Sound({key = "win95plusmax3", path = "plus95/Jungle maximize.ogg"})
SMODS.Sound({key = "win95plusrestup3", path = "plus95/Jungle restore up.ogg"})
SMODS.Sound({key = "win95plusrestdw3", path = "plus95/Jungle restore down.ogg"})

SMODS.Sound({key = "win95plusmin4", path = "plus95/Leonardo da Vinci minimize.ogg"})
SMODS.Sound({key = "win95plusmax4", path = "plus95/Leonardo da Vinci maximize.ogg"})
SMODS.Sound({key = "win95plusrestup4", path = "plus95/Leonardo da Vinci restore up.ogg"})
SMODS.Sound({key = "win95plusrestdw4", path = "plus95/Leonardo da Vinci restore down.ogg"})

SMODS.Sound({key = "win95plusmin5", path = "plus95/Mystery minimize.ogg"})
SMODS.Sound({key = "win95plusmax5", path = "plus95/Mystery maximize.ogg"})

SMODS.Sound({key = "win95plusmin6", path = "plus95/Nature minimize.ogg"})
SMODS.Sound({key = "win95plusmax6", path = "plus95/Nature maximize.ogg"})
SMODS.Sound({key = "win95plusrestup6", path = "plus95/Nature restore up.ogg"})
SMODS.Sound({key = "win95plusrestdw6", path = "plus95/Nature restore down.ogg"})

SMODS.Sound({key = "win95plusmin7", path = "plus95/Science minimize.ogg"})
SMODS.Sound({key = "win95plusmax7", path = "plus95/Science maximize.ogg"})
SMODS.Sound({key = "win95plusrestup7", path = "plus95/Science restore up.ogg"})
SMODS.Sound({key = "win95plusrestdw7", path = "plus95/Science restore down.ogg"})

SMODS.Sound({key = "win95plusmin8", path = "plus95/Space minimize.ogg"})
SMODS.Sound({key = "win95plusmax8", path = "plus95/Space maximize.ogg"})
SMODS.Sound({key = "win95plusrestup8", path = "plus95/Space restore up.ogg"})
SMODS.Sound({key = "win95plusrestdw8", path = "plus95/Space restore down.ogg"})

SMODS.Sound({key = "win95plusmin9", path = "plus95/Sports minimize.ogg"})
SMODS.Sound({key = "win95plusmax9", path = "plus95/Sports maximize.ogg"})

SMODS.Sound({key = "win95plusmin10", path = "plus95/The 60's USA minimize.ogg"})
SMODS.Sound({key = "win95plusmax10", path = "plus95/The 60's USA maximize.ogg"})
SMODS.Sound({key = "win95plusrestup10", path = "plus95/The 60's USA restore up.ogg"})
SMODS.Sound({key = "win95plusrestdw10", path = "plus95/The 60's USA restore down.ogg"})

SMODS.Sound({key = "win95plusmin11", path = "plus95/The Golden Era minimize.ogg"})
SMODS.Sound({key = "win95plusmax11", path = "plus95/The Golden Era maximize.ogg"})

SMODS.Sound({key = "win95plusmin12", path = "plus95/Travel minimize.ogg"})
SMODS.Sound({key = "win95plusmax12", path = "plus95/Travel maximize.ogg"})
SMODS.Sound({key = "win95plusrestup12", path = "plus95/Travel restore up.ogg"})
SMODS.Sound({key = "win95plusrestdw12", path = "plus95/Travel restore down.ogg"})

SMODS.Sound({key = "win95plusmin13", path = "plus95/Windows 95 minimize.ogg"})
SMODS.Sound({key = "win95plusmax13", path = "plus95/Windows 95 maximize.ogg"})
SMODS.Sound({key = "win95plusrestup13", path = "plus95/Windows 95 restore up.ogg"})
SMODS.Sound({key = "win95plusrestdw13", path = "plus95/Windows 95 restore down.ogg"})

togabalatro.plussfxthemes = {"Dangerous Creatures", "Inside Your Computer", "Jungle", "Leonardo Da Vinci", "Mystery", "Nature", "Science", "Space", "Sports", "The 60's USA", "The Golden Era", "Travel", "Windows 95"}
togabalatro.plussfxtype = { min = 1, max = 2, restup = 3, restdw = 4 }

togabalatro.plussfxtheme = {
	{"toga_win95plusmin1", "toga_win95plusmax1"},
	{"toga_win95plusmin2", "toga_win95plusmax2", "toga_win95plusrestup2", "toga_win95plusrestdw2"},
	{"toga_win95plusmin3", "toga_win95plusmax3", "toga_win95plusrestup3", "toga_win95plusrestdw3"},
	{"toga_win95plusmin4", "toga_win95plusmax4", "toga_win95plusrestup4", "toga_win95plusrestdw4"},
	{"toga_win95plusmin5", "toga_win95plusmax5"},
	{"toga_win95plusmin6", "toga_win95plusmax6", "toga_win95plusrestup6", "toga_win95plusrestdw6"},
	{"toga_win95plusmin7", "toga_win95plusmax7", "toga_win95plusrestup7", "toga_win95plusrestdw7"},
	{"toga_win95plusmin8", "toga_win95plusmax8", "toga_win95plusrestup8", "toga_win95plusrestdw8"},
	{"toga_win95plusmin9", "toga_win95plusmax9", "toga_win95plusrestup9", "toga_win95plusrestdw9"},
	{"toga_win95plusmin10", "toga_win95plusmax10", "toga_win95plusrestup10", "toga_win95plusrestdw10"},
	{"toga_win95plusmin11", "toga_win95plusmax11"},
	{"toga_win95plusmin12", "toga_win95plusmax12", "toga_win95plusrestup12", "toga_win95plusrestdw12"},
	{"toga_win95plusmin13", "toga_win95plusmax13", "toga_win95plusrestup13", "toga_win95plusrestdw13"},
}

togabalatro.playwindowsfx = function(_t)
	if type(togabalatro.config.WindowSFXUse) ~= 'boolean' then togabalatro.config.WindowSFXUse = false end
	if type(togabalatro.config.WindowSFXTheme) ~= 'number' then togabalatro.config.WindowSFXTheme = 1 end
	if not togabalatro.config.WindowSFXUse then return end
	if not togabalatro.plussfxtype[_t] then return end
	
	local sfxtype = togabalatro.plussfxtype[_t]
	local selectedsfx = togabalatro.plussfxtheme[togabalatro.config.WindowSFXTheme][togabalatro.plussfxtype[_t]]
	
	if sfxtype and selectedsfx and SMODS.Sounds[selectedsfx] then play_sound(selectedsfx) end
end

-- Yoinked from Aikoyori.
togabalatro.cagen = function(cardArea, desc_nodes, config)
    if not config then config = {} end
    local height = config.h or 1.25
    local width = config.w or 1
    local original_card = config.original_card or nil
    local speed_mul = config.speed
    local card_limit = config.card_limit or #config.cards or 1
    local override = config.override or false
    local cards = config.cards or {}
    local padding = config.padding or 0.07
    local func_after = config.func_after or nil
    local init_delay = config.init_delay or 1
    local func_list = config.func_list or nil
    local func_delay = config.func_delay or 0.2
    local margin_left = config.ml or 0.2
    local margin_top = config.mt or 0
    local alignment = config.alignment or "cm"
    local scale = config.scale or 1
    local type = config.type or "title"
    local box_height = config.box_height or 0
    local highlight_limit = config.highlight_limit or 0
    if override or not cardArea then
        cardArea = CardArea(
            G.ROOM.T.x + margin_left * G.ROOM.T.w, G.ROOM.T.h + margin_top
            , width * G.CARD_W, height * G.CARD_H,
            {card_limit = card_limit, type = type, highlight_limit = highlight_limit, collection = true, temporary = true}
        )
        for i, card in ipairs(cards) do
            card.T.w = card.T.w * scale
            card.T.h = card.T.h * scale
            card.VT.h = card.T.h
            card.VT.h = card.T.h
            local area = cardArea
            if (card.config.center) then
                card:set_sprites(card.config.center)
            end
            area:emplace(card)
        end
    end
    local uiEX = {
        n = G.UIT.R,
        config = { align = alignment , padding = padding, no_fill = true, minh = box_height },
        nodes = {
            {n = G.UIT.O, config = { object = cardArea }}
        }
    }
    if cardArea then
        if desc_nodes then
            desc_nodes[#desc_nodes+1] = {
                uiEX
            }
        end
    end
    return uiEX
end

-- File shenanigans.
local lastfilesizedropped, filedropref = 0, love.filedropped
function love.filedropped(file)
	togabalatro.updatelastfilesize(tonumber(file:getSize("r")))
	if filedropref then return filedropref(file) end
end

-- Return number of bytes of last dropped file.
togabalatro.lastfilesize = function()
	return lastfilesizedropped or 0
end

-- Update the aforementioned number above.
togabalatro.updatelastfilesize = function(val)
	lastfilesizedropped = tonumber(val) and val or lastfilesizedropped or 0
end

-- Check if our resolution is 4:3, like 320x240, 640x480, 800x600 and so on.
togabalatro.check43 = function(width, height)
	width, height = tonumber(width) or 1, tonumber(height) or 1
	return width/height == 4/3
end

-- Return a rounded up number.
togabalatro.round = function(num, dplaces)
	local m = 10^(dplaces or 0)
	return math.floor(num * m + 0.5) / m
end

togabalatro.checkbmp = function()
	return next(SMODS.find_mod('Multiplayer')) or false
end

togabalatro.checksiiva = function()
	return next(SMODS.find_mod('Qualatro')) or false
end

-- As Talisman is now optional and we have some items using this, best keep these.
to_big = to_big or function(a) return a end
to_number = to_number or function(a) return a end

-- Choose rank for drawing if meeting conditions for Solitaire Joker.
togabalatro.reset_solitaire = function(run_start)
	if run_start then G.GAME.current_round.togabalatro.solitaire = {} end
	G.GAME.current_round.togabalatro.solitaire.rank = 'Ace'
	G.GAME.current_round.togabalatro.solitaire.id = 14
	local valid_soli_cards = {}
	for k, v in ipairs(G.playing_cards) do
		if v.ability.effect ~= 'Stone Card' then
			if not SMODS.has_no_rank(v) then
				valid_soli_cards[#valid_soli_cards+1] = v
			end
		end
	end
	if valid_soli_cards[1] then
		local soli_card = pseudorandom_element(valid_soli_cards, pseudoseed('solitaire'..G.GAME.round_resets.ante))
		G.GAME.current_round.togabalatro.solitaire.rank = soli_card.base.value
		G.GAME.current_round.togabalatro.solitaire.id = soli_card.base.id
	end
end

-- Choose suit for Disk Cleanup Joker.
togabalatro.reset_diskcleanup = function(run_start)
	if run_start then G.GAME.current_round.togabalatro.diskcleanup = {}; G.GAME.current_round.togabalatro.diskcleanup.suit = 'Hearts' end
	local dc_suits = {}
	for k, v in ipairs(G.playing_cards) do
		if v.ability.effect ~= 'Stone Card' then
			if not SMODS.has_no_suit(v) and not dc_suits[v.base.suit] and SMODS.Suits[v.base.suit] then
				dc_suits[v.base.suit] = true
			end
		end
	end
	local valid_dc_suits = {}
	for k, v in pairs(dc_suits) do valid_dc_suits[#valid_dc_suits+1] = k end
	if next(valid_dc_suits) then G.GAME.current_round.togabalatro.diskcleanup.suit = pseudorandom_element(valid_dc_suits, pseudoseed('diskcleanup'..G.GAME.round_resets.ante)) end
end

-- Choose overriding suit for Registry Editor Joker.
togabalatro.reset_regedit = function(run_start)
	if run_start then G.GAME.current_round.togabalatro.regedit = {}; G.GAME.current_round.togabalatro.regedit.suit = 'Hearts' end
	local regedit_suits = {}
    for k, v in pairs(SMODS.Suits) do
        if k ~= G.GAME.current_round.togabalatro.regedit.suit then regedit_suits[#regedit_suits + 1] = k end
    end
    G.GAME.current_round.togabalatro.regedit.suit = pseudorandom_element(regedit_suits, pseudoseed('regedit'..G.GAME.round_resets.ante))
end

-- Choose overriding rank for Certificate Server Joker.
togabalatro.reset_certificateserver = function(run_start)
	if run_start then G.GAME.current_round.togabalatro.certserver = {} end
	G.GAME.current_round.togabalatro.certserver.rank = 'Ace'
	G.GAME.current_round.togabalatro.certserver.id = 14
	
	local rndrank = pseudorandom_element(SMODS.Ranks, pseudoseed('certserver'..G.GAME.round_resets.ante))
	if rndrank then
		G.GAME.current_round.togabalatro.certserver.rank = rndrank.key
		G.GAME.current_round.togabalatro.certserver.id = rndrank.id
		G.GAME.current_round.togabalatro.certserver.value = rndrank.value
	end
end

-- Per-round functions.
togabalatro.reset_game_globals = function(run_start)
	if run_start then G.GAME.current_round.togabalatro = {} end
	
	togabalatro.reset_solitaire(run_start)
	togabalatro.reset_diskcleanup(run_start)
	togabalatro.reset_regedit(run_start)
	togabalatro.reset_certificateserver(run_start)
	
	if togabalatro.config.DoMoreLogging then sendInfoMessage("Reset own round variables.", "TOGAPack") end
end

-- Random pitch...
togabalatro.randompitch = function()
	local genvalue = math.random(50, 150)/100
	if togabalatro.config.DoMoreLogging then sendInfoMessage("Random pitch of "..genvalue.." returned.", "TOGAPack") end
	return genvalue
end

-- Calculate cost of items in specified locations. Can be hooked for adding to the cost by other areas.
togabalatro.shopitemcost = function()
	local areas = {G.shop_jokers, G.shop_vouchers, G.shop_booster}
	local totalitemcost = to_big(0)
	for k, v in pairs(areas) do
		if v and v.cards then
			for i, c in pairs(v.cards or {}) do
				if c and c.cost then totalitemcost = totalitemcost + c.cost end
			end
		end
	end
	return totalitemcost
end

-- Count how many unique mods are in the currently owned Jokers, Consumables and Vouchers.
togabalatro.checkownedmoditems = function()
	local mods, modcount = {['TOGAPack'] = true}, 1 -- count ourselves.
	if G.jokers and G.consumeables and G.vouchers then
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i].config.center.original_mod and not mods[G.jokers.cards[i].config.center.original_mod.id] then
				mods[G.jokers.cards[i].config.center.original_mod.id] = true
				modcount = modcount + 1
			end
		end
		for i = 1, #G.consumeables.cards do
			if G.consumeables.cards[i].config.center.original_mod and not mods[G.consumeables.cards[i].config.center.original_mod.id] then
				mods[G.consumeables.cards[i].config.center.original_mod.id] = true
				modcount = modcount + 1
			end
		end
		for i = 1, #G.vouchers.cards do
			if G.vouchers.cards[i].config.center.original_mod and not mods[G.vouchers.cards[i].config.center.original_mod.id] then
				mods[G.vouchers.cards[i].config.center.original_mod.id] = true
				modcount = modcount + 1
			end
		end
	end
	return mods, modcount
end

-- Drawing of Notification cards...
togabalatro.drawextracards = function()
	local anycarddrawn = false
	
	local allnotifcards = {}
	for i = 1, #G.deck.cards do
		if SMODS.has_enhancement(G.deck.cards[i], 'm_toga_notification') then
			allnotifcards[#allnotifcards+1] = G.deck.cards[i]
		end
	end
	if #allnotifcards > 0 then
		for i = 1, #G.deck.cards do
			for v = 1, #allnotifcards do
				if SMODS.has_enhancement(G.deck.cards[i], 'm_toga_notification') and allnotifcards[v] == G.deck.cards[i] then
					if togabalatro.config.DoMoreLogging then sendInfoMessage("Additionally drawing Notification Card "..i.." ("..G.deck.cards[i].config.card.name..") from the deck...", "TOGAPack") end
					draw_card(G.deck, G.hand, i*100/#allnotifcards, 'up', true, G.deck.cards[i])
					anycarddrawn = true
				end
			end
		end
	end
	
	if anycarddrawn then
		G.E_MANAGER:add_event(Event({
			func = function()
				if togabalatro.config.DoMoreLogging then sendInfoMessage("save_run() so the additionally drawn cards are set...", "TOGAPack") end
				save_run() -- god.
				return true
			end}))
	end
end

function ReverseTable(t)
	local rt = {}
	for i = #t, 1, -1 do
		rt[#rt+1] = t[i]
	end
	return rt
end

function ShuffleMyTable(t, seed)
	seed = seed or 'shuffley'
	local rt = {}
	for i = 1, #t do
		rt[#rt+1] = t[i]
	end
	pseudoshuffle(rt, pseudoseed(seed))
	return rt
end

-- Hooking to do more funky scoring shenanigans.
-- This hook stays here due to functions calling the original function.
sendInfoMessage("Hooking SMODS.calculate_main_scoring...", "TOGAPack")
local calcmainscoreref = SMODS.calculate_main_scoring
function SMODS.calculate_main_scoring(context, scoring_hand)
	if togabalatro.canareascore(context.cardarea) then calcmainscoreref(context, scoring_hand) end
	togabalatro.kartsleevescoring(context, scoring_hand)
	togabalatro.extrascoring(context, scoring_hand)
	togabalatro.heldinhandscoring(context, scoring_hand)
end

-- Hooking to run it back.
-- This hook also stays here due to calling original function.
sendInfoMessage("Hooking SMODS.calculate_end_of_round_effects...", "TOGAPack")
local calcendroundref = SMODS.calculate_end_of_round_effects
function SMODS.calculate_end_of_round_effects(context)
	if togabalatro.canareascore(context.cardarea) then calcendroundref(context) end
	if G.GAME and G.GAME.modifiers and G.GAME.modifiers.toga_reversedscore_special_kart then
		togabalatro.forcereverse = true
		calcendroundref(context)
		togabalatro.forcereverse = false
	end
	
	if context.cardarea == G.hand and context.end_of_round then
		togabalatro.triggereof(context) -- initial end of round scoring of cards with Hyperlink Seals
		local clippitcalc = {}
		SMODS.calculate_context({clippitscore_eor = true, cardarea = context.cardarea}, clippitcalc)
		for _, eval in pairs(clippitcalc) do
			for key, eval2 in pairs(eval) do
				if eval2.card then
					for i = 1, math.floor(eval2.rescores or eval2.card.ability.extra and eval2.card.ability.extra.rescores or 1) do
						calcendroundref(context)
						togabalatro.triggereof(context) -- rescore...
					end
				end
			end
		end
	end
end

-- emem eht era uoy :VOP --
togabalatro.forcereverse = false
togabalatro.preprocess = function(context, input)
	local output = input or context.cardarea and context.cardarea.cards or nil
	if not output then
		if context.cardarea == G.play then output = context.full_hand
		elseif context.cardarea == G.hand then output = G.hand.cards
		elseif context.cardarea == 'unscored' then output = context.full_hand end
	end
	
	if not output then return end
	
	if G.GAME.modifiers.toga_reversedscore then output = ReverseTable(output) end
	if G.GAME.modifiers.toga_reversedscore_sleeve then output = ReverseTable(output) end
	if togabalatro.forcereverse then output = ReverseTable(output) end
	if G.GAME.modifiers.toga_randomscore then output = ShuffleMyTable(output, 'whotouchmygun') end
	
	return output
end

togabalatro.areaprocess = function(t)
	t = t or {}
	
	local output = t
	
	if G.GAME.modifiers.toga_reversedscore then output = ReverseTable(output) end
	if G.GAME.modifiers.toga_reversedscore_sleeve then output = ReverseTable(output) end
	if G.GAME.modifiers.toga_randomscore then output = ShuffleMyTable(output, 'whotouchmygun') end
	
	return output
end

togabalatro.areaorderprocess = function(t)
	return togabalatro.areaprocess(t)
end

togabalatro.spacecadetsfx = {'toga_pinballsfx8', 'toga_pinballsfx14', 'toga_pinballsfx16', 'toga_pinballsfx21', 'toga_pinballsfx24', 'toga_pinballsfx26', 'toga_pinballsfx43', 'toga_pinballsfx49', 'toga_pinballsfx53', 'toga_pinballsfx55'}
togabalatro.spacecadetrndsfx = function()
	return togabalatro.spacecadetsfx[math.random(1, #togabalatro.spacecadetsfx)]
end

-- Any additional scoring with chips and what not.
togabalatro.extrascoring = function(context, scoring_hand)
	if context.cardarea == G.play then
		-- Space Cadet scoring.
		local spacecadetcalc = {}
		SMODS.calculate_context({spacecadetscore = true}, spacecadetcalc)
		for _, eval in pairs(spacecadetcalc) do
			for key, eval2 in pairs(eval) do
				local notyetscored = true
				if eval2.card and not (eval2.retrigger_flag or eval2.retrigger_card) then -- prevent unintended extra execution when retriggering.
					for i = 1, math.floor(to_number(tonumber(eval2.spacecadet)) or eval2.card and to_number(eval2.card.ability.extra.alltrig) or 1) do
						if (SMODS.pseudorandom_probability(card, "toga_spacecadetpinball", 1, 3, 'spacecadetpinball') or eval2.card.ability.cry_rigged) and scoring_hand then
							if notyetscored then notyetscored = false; card_eval_status_text(eval2.card, 'extra', nil, nil, nil, {message = localize('toga_pinballing'), sound = not silent and togabalatro.config.SFXWhenTriggered and togabalatro.spacecadetrndsfx()}) end
							SMODS.score_card(pseudorandom_element(context.scoring_hand, pseudoseed('spacecadet')), context)
						end
					end
				end
			end
		end
		-- Hammer scoring.
		local hammercalc = {}
		SMODS.calculate_context({hammerscore = true}, hammercalc)
		for _, eval in pairs(hammercalc) do
			for key, eval2 in pairs(eval) do
				local notyetscored = true
				if eval2.card and not (eval2.retrigger_flag or eval2.retrigger_card) then -- prevent unintended extra execution when retriggering.
					for i = 1, #G.hand.cards do
						if SMODS.has_enhancement(G.hand.cards[i], "m_glass") and G.hand.cards[i]:can_calculate() then
							if notyetscored then notyetscored = false; card_eval_status_text(eval2.card, 'extra', nil, nil, nil, {message = localize('toga_hammersmash')}) end
							SMODS.score_card(G.hand.cards[i], context)
							local smashchance = G.hand.cards[i].ability.name == 'Glass Card' and G.hand.cards[i].ability.extra or G.P_CENTERS.m_glass.config.extra
							if SMODS.pseudorandom_probability(G.hand.cards[i], 'glass', 1, smashchance/2, 'atomsmashererrorgenerator') then G.hand.cards[i].atomsmashed = true end
						end
					end
				end
			end
		end
		-- Rover scoring.
		local rovercalc = {}
		SMODS.calculate_context({roverscore = true}, rovercalc)
		for _, eval in pairs(rovercalc) do
			for key, eval2 in pairs(eval) do
				local notyetscored = true
				if eval2.card and not (eval2.retrigger_flag or eval2.retrigger_card) then -- prevent unintended extra execution when retriggering.
					for i = 1, #G.deck.cards do
						if (SMODS.pseudorandom_probability(card, "toga_rover", 1, (eval2.rover or eval2.card.ability.extra and eval2.card.ability.extra.odds or 8), 'searchwithrover') or eval2.card.ability.cry_rigged) then
							if notyetscored then notyetscored = false; card_eval_status_text(eval2.card, 'extra', nil, nil, nil, {message = localize('toga_roverwoof'), sound = not silent and togabalatro.config.SFXWhenTriggered and "toga_roverbark"}) end
							SMODS.score_card(G.deck.cards[i], context)
						end
					end
				end
			end
		end
	end
end

-- Custom scoring of held in hand abilities.
togabalatro.heldinhandscoring = function(context, scoring_hand)
	if context.cardarea == G.hand then
		context.main_scoring = true
		if togabalatro.canareascore(context.cardarea) then togabalatro.scoreheldinhand(context) end
		
		-- Clippit rescore.
		local clippitcalc = {}
		SMODS.calculate_context({clippitscore = true, cardarea = context.cardarea}, clippitcalc)
		
		for _, eval in pairs(clippitcalc) do
			for key, eval2 in pairs(eval) do
				if eval2.card then
					for i = 1, math.floor(eval2.rescores or eval2.card.ability.extra and eval2.card.ability.extra.rescores or 1) do
						togabalatro.scoreheldinhand(context, true)
					end
				end
			end
		end
		context.main_scoring = nil
	end
end

togabalatro.scoreheldinhand = function(context, handrescore)
	local allcards = {}
	
	for i = 1, #G.playing_cards do
		if G.playing_cards[i] then allcards[#allcards+1] = G.playing_cards[i] end
	end
	
	allcards = togabalatro.preprocess(context, allcards)
	
	for i = 1, #allcards do
		local card, area = allcards[i], allcards[i].area
		if card then
			if area == G.hand and handrescore then
				SMODS.score_card(card, context)
			end
			if area ~= G.hand and card.seal == 'toga_urlseal' then
				SMODS.score_card(card, context)
			end
		end
	end
end

-- Special case for the sleeve scoring.
togabalatro.kartsleevescoring = function(context, scoring_hand)
	if G.GAME and G.GAME.modifiers and G.GAME.modifiers.toga_reversedscore_special_kart then
		togabalatro.forcereverse = true
		context.main_scoring = true
		calcmainscoreref(context, scoring_hand)
		togabalatro.forcereverse = false
		context.main_scoring = nil
	end
end

-- Check if a given CardArea can score.
togabalatro.canareascore = function(cardarea)
	local can = true
	if cardarea then
		if cardarea == G.play and G.GAME.modifiers.toga_noplayedscore then can = false end
		if cardarea == G.hand and G.GAME.modifiers.toga_nohandscore then can = false end
	end
	return can
end

-- Yoinked from original SMODS.calculate_end_of_round_effects, but edited to target specific cards.
-- 100% hacky, there should be a better way for doing this...
togabalatro.eorproc = function(area, card, context, i)
	local reps = {1}
	local j = 1
	while j <= #reps do
		percent = percent or (i-0.999)/(#area.cards-0.998) + (j-1)*0.1
		if reps[j] ~= 1 then
			local _, eff = next(reps[j])
			SMODS.calculate_effect(eff, eff.card)
			percent = percent + 0.08
		end

		context.playing_card_end_of_round = true
		local effects = {eval_card(card, context)}
		SMODS.calculate_quantum_enhancements(card, effects, context)

		context.playing_card_end_of_round = nil
		context.individual = true
		context.other_card = card

		SMODS.calculate_card_areas('jokers', context, effects, { main_scoring = true })
		SMODS.calculate_card_areas('individual', context, effects, { main_scoring = true })

		local flags = SMODS.trigger_effects(effects, card)

		context.individual = nil
		context.repetition = true
		context.card_effects = effects
		if reps[j] == 1 then
			SMODS.calculate_repetitions(card, context, reps)
		end

		context.repetition = nil
		context.card_effects = nil
		context.other_card = nil
		j = j + (flags.calculated and 1 or #reps)
	end
end

-- This bit is 100% experimental... there should be a better way for doing this, right?
togabalatro.triggereof = function(context)
	local contextcopy = context
	contextcopy.cardarea = G.hand
	
	local allcards = {}
	
	for i = 1, #G.playing_cards do
		if G.playing_cards[i] then allcards[#allcards+1] = G.playing_cards[i] end
	end
	
	allcards = togabalatro.preprocess(context, allcards)
	
	for i = 1, #allcards do
		local card, area = allcards[i], allcards[i].area
		if area ~= G.hand and card.seal == 'toga_urlseal' then
			togabalatro.eorproc(area, card, contextcopy, i)
		end
	end
end

-- Check for HandLimitAPI...
togabalatro.handlimitapi = function()
	return (SMODS.change_play_limit and SMODS.change_discard_limit and SMODS.update_hand_limit_text) or false
end

-- Using HandLimitAPI if possible.
togabalatro.handlimitchange = function(val, set_to)
	val = val or 0
	if togabalatro.handlimitapi() then
		if togabalatro.config.DoMoreLogging then sendInfoMessage("Using HandLimitAPI. "..tostring(set_to).." "..val, "TOGAPack") end
		SMODS.change_play_limit(set_to and G.GAME.starting_params.play_limit - val or val)
		SMODS.change_discard_limit(set_to and G.GAME.starting_params.discard_limit - val or val)
	else
		if togabalatro.config.DoMoreLogging then sendInfoMessage("How did you even trigger this? "..val, "TOGAPack") end
		G.hand.config.highlighted_limit = math.max(G.hand.config.highlighted_limit + val, val < 0 and 1 or 5)
	end
end

-- Do additional stuff when playing a hand.
togabalatro.playextracards = function()
	-- SMS enhancement.
	local sms_deck = {}
	if G.deck.cards and #G.deck.cards > 0 then
		for i = 1, #G.deck.cards do
			if SMODS.has_enhancement(G.deck.cards[i], 'm_toga_sms') then
				sms_deck[#sms_deck+1] = G.deck.cards[i]
			end
		end
	end
	if #sms_deck > 0 then
		for i = 1, #G.deck.cards do
			for v = 1, #sms_deck do
				if SMODS.has_enhancement(G.deck.cards[i], 'm_toga_sms') and sms_deck[v] == G.deck.cards[i] then
					if G.deck.cards[i]:is_face() then inc_career_stat('c_face_cards_played', 1) end
					G.deck.cards[i].base.times_played = G.deck.cards[i].base.times_played + 1
					G.deck.cards[i].ability.played_this_ante = true
					G.GAME.round_scores.cards_played.amt = G.GAME.round_scores.cards_played.amt + 1
					draw_card(G.deck, G.play, i*100/#sms_deck, 'up', nil, G.deck.cards[i])
				end
			end
		end
	end
	-- Draw cards to hand by Solitaire Joker... if we actually have a Straight.
	if next(SMODS.find_card('j_toga_solitairejoker')) then
		local _, _, pokerhands = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
		if next(pokerhands['Straight']) then
			local curcards = {}
			for i = 1, #G.deck.cards do
				if G.deck.cards[i]:get_id() == G.GAME.current_round.togabalatro.solitaire.id then curcards[#curcards+1] = G.deck.cards[i] end
			end
			for c = 1, #curcards do
				if curcards[c] then draw_card(G.deck, G.hand, c*100/#curcards, 'up', true, curcards[c]) end
			end
		end
	end
	-- Draw cards to hand by (attempting to be) played Redstone cards.
	for i = 1, #G.hand.highlighted do
		if not G.hand.highlighted[i].debuff and SMODS.has_enhancement(G.hand.highlighted[i], 'm_toga_redstone') then draw_card(G.deck, G.hand, 1, 'up') end
	end
end

-- Count how many consumables we are holding, including stacked if present.
togabalatro.getconscount = function()
	local count = 0
	if G.consumeables and G.consumeables.cards then
		for i = 1, #G.consumeables.cards do
			local stack, stackamount = togabalatro.stackingcompat(G.consumeables.cards[i])
			if stack then count = count + stackamount else count = count + 1 end
		end
	end
	return count
end

-- Check for Overflow or Incantation...
togabalatro.stackingcompat = function(consumable)
	-- The new and shiny Overflow!
	if Overflow and consumable and consumable.ability and consumable.ability.immutable and consumable.ability.immutable.overflow_amount then
		return true, consumable.ability.immutable.overflow_amount
	-- ...though, backwards compatibility wouldn't hurt...
	elseif Incantation and consumable and consumable.ability and consumable.ability.qty then
		return true, consumable.ability.qty
	end
end

togabalatro.stjcheck = function()
	return SMODS.Mods['SlayTheJokers'] and SMODS.Mods['SlayTheJokers'].can_load or false
end

-- In case Incantation is used, check if it is the specific fork version so that the consumeables don't do unintended things...
if SMODS.Mods['incantation'] and SMODS.Mods['incantation'].can_load and not SMODS.Mods['incantation'].togafork and not string.find(SMODS.Mods['incantation'].version, '-TOGA_fork') then
	error([[
	Please obtain TheOneGoofAli's fork of Incantation to prevent unintended behaviour of the consumeables
	added by TOGA's Stuff at https://github.com/TheOneGoofAli/JensBalatroCollection in order to continue.
	Otherwise, remove it or add a '.lovelyignore' file into its' folder to disable it.
	Alternatively, why not check out Overflow at https://github.com/lord-ruby/Overflow for stacking too?
	]], 0)
end

-- I've not done such loading since making Windows for SRB2, but as the content is split off from this main file, gotta do it!
-- This loads the actual content...
for _, file in ipairs{"hooks.lua", "joker.lua", "deck.lua", "quips.lua", "voucher.lua", "enhancement.lua", "consumables.lua", "seal.lua", "booster.lua", "tag.lua", "deckskin.lua", "blind.lua", "challenges.lua", "stakes.lua", "crossmod.lua"} do
	sendDebugMessage("Executing items/"..file, "TOGAPack")
	assert(SMODS.load_file("items/"..file))()
end

-- Load other UI stuff.
sendDebugMessage("Executing miscui.lua", "TOGAPack")
assert(SMODS.load_file("miscui.lua"))()