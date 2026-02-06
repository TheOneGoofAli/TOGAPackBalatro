sendInfoMessage("Initializing assets...", "TOGAPack")

-- Define thy map.
SMODS.Atlas{key = "TOGAJokersMain", path = "togajokers.png", px = 72, py = 95}
SMODS.Atlas{key = "TOGAJokersMainW", path = "togajokersw.png", px = 91, py = 95}
SMODS.Atlas{key = "TOGAJokersOther", path = "togajokersother.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGAJokersOtherDiffSize", path = "togajokersothersize.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGAJokersWindows", path = "togajokerswinos.png", px = 72, py = 95}
SMODS.Atlas{key = "TOGAJokersMac", path = "togamacos.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGAJokersLinux", path = "togalinuxos.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGAJokersBeOS", path = "togabeos.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGAJokersUpdate", path = "togajokerupdate.png", px = 71, py = 95, atlas_table = 'ANIMATION_ATLAS', frames = 10, fps = 4}
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
SMODS.Atlas{key = "TOGAJokersPSO2", path = "togapso2.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGASonic", path = "togasonic.png", px = 75, py = 95}
SMODS.Atlas{key = "TOGASuperSonic", path = "togasupersonic.png", px = 75, py = 95, atlas_table = 'ANIMATION_ATLAS', frames = 3, fps = 4}
SMODS.Atlas{key = "TOGAHyperSonic", path = "togahypersonic.png", px = 75, py = 95, atlas_table = 'ANIMATION_ATLAS', frames = 12, fps = 4}
SMODS.Atlas{key = "TOGAJokerMoth", path = "togajokersm.png", px = 116, py = 95}
SMODS.Atlas{key = "modicon", path = "togaicon.png", px = 34, py = 34, atlas_table = 'ANIMATION_ATLAS', frames = 6, fps = 3}

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
SMODS.Sound({key = "officehammer", path = "HAMMER.WAV"}) -- hammer.wav from Microsoft Office sounds
SMODS.Sound({key = "glassbreak", path = "GLASS.WAV"}) -- glass.wav from Microsoft Office sounds
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
SMODS.Sound({key = "bummer", path = "bummer.wav"}) -- bummer.wav (Chip's Challenge)
SMODS.Sound({key = "sonicring", path = "sonicring.ogg"}) -- Ring Collect, Sonic games on Sega Genesis/Mega Drive
SMODS.Sound({key = "sonicringloss", path = "sonicringloss.ogg"}) -- Losing Rings, Sonic games on Sega Genesis/Mega Drive
SMODS.Sound({key = "sonictransform", path = "sonictransform.ogg"}) -- Transformation, Sonic games on Sega Genesis/Mega Drive
SMODS.Sound({key = "soniccheckpoint", path = "soniccheckpoint.ogg"}) -- Checkpoint, Sonic games on Sega Genesis/Mega Drive
SMODS.Sound({key = "sonictally", path = "sonictally.ogg"}) -- Score tally complete, Sonic games on Sega Genesis/Mega Drive
SMODS.Sound({key = "awwcrap", path = "awwcrap.ogg"}) -- *boom* Awww, crap!

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
		and SMODS.OPENED_BOOSTER.config.center.kind == 'TOGABoostPack' and 2
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
		return togabalatro.config.UseCustomModTabMusic and SMODS.LAST_SELECTED_MOD_TAB and G.ACTIVE_MOD_UI and G.ACTIVE_MOD_UI.id == "TOGAPack" and not togabalatro.checksiiva() and 2007
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