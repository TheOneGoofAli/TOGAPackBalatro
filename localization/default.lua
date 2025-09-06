return {
	descriptions = {
		Mod = {
			TOGAPack = {
				name = "TOGA's Stuff",
				text = {
					"Personal timewaster project",
					"with a few {C:dark_edition}references{}",
					"here and there.",
					" ",
					"{C:inactive,s:0.8,E:1}Another what-if that became an actual thing...{}"
				}
			}
		},
		Back = {
			b_toga_frogdeck = {
				name = 'Frog Deck',
				text = {
					"{C:attention}+#3#{} {C:attention}Joker{} slot",
					"{C:attention}+#4#{} Consumable slot",
					"{C:attention}+#6#{} hand size, +{C:money}$6{} on start",
					"{C:red}#1#{} hand, {C:red}#2#{} discard",
					"{C:red}X#5#{} base Blind size",
					--"Start with {C:money}$6{} more",
					"{C:inactive,s:0.8}What {C:spectral,s:0.8}secrets{C:inactive,s:0.8} does the frog hold?{}"
				}
			},
			b_toga_spacedeck = {
				name = 'Spaceman Deck',
				text = {
					"Start the run",
					"with a {C:planet,T:j_space}Space Joker{}",
					"{C:planet,T:v_planet_merchant}Planet Merchant{},",
					"{C:planet,T:v_planet_tycoon}Planet Tycoon{}",
					"{C:spectral,s:0.8}Spectral{s:0.8} cards",
					"{s:0.8}may appear in shop"
				}
			},
			b_toga_srb2kartdeck = {
				name = 'Karting Deck',
				text = {
					"Start run with",
					"a special {C:attention,T:j_toga_jokersrb2kart}Karting Joker{}",
					"{C:red}#2#{} {C:attention}Joker{} slots",
					"{C:spectral,s:0.8}Spectral{s:0.8} cards",
					"{s:0.8}may appear in shop"
				}
			},
			b_toga_againdeck = {
				name = 'Deck! Deck! Deck!',
				text = {
					"{C:attention}Retrigger{} scoring cards",
					"once for every {C:attention}Joker{} held.",
					"{C:red}#2#{} {C:attention}Joker{} slots",
					"{C:red}X#1#{} base Blind size"
				}
			},
			b_toga_311deck = {
				name = 'WinDeck 3.11',
				text = {
					"{C:attention}+#2#{} hand size, +{C:money}$#1#{} on start",
					"{C:planet}+#5#{} level to all {C:attention}poker hands{}",
					"{C:red}#3#{} card selection limit",
					"{C:attention}+#4#{} Ante to win"
				}
			},
			b_toga_screamingdeck = {
				name = 'AAAAAAAAAAA',
				text = {
					"Start run with only",
					"{C:attention}Aces{} left in the deck",
					"and a {C:attention,T:tag_coupon}Coupon{} Tag.",
					"{C:red}X#1#{} base Blind size"
				}
			},
			b_toga_drunkdeck = {
				name = 'Drunk',
				text = {
					"Scoring is triggered",
					"in reverse order.",
				}
			},
			b_toga_waitthatsillegaldeck = {
				name = "Wait. That's Illegal.",
				text = {
					"Scoring is triggered",
					"in random order.",
				}
			},
			b_toga_blissful = {
				name = "Blissful Deck",
				text = {
					"{C:attention}Enhancements{} are {C:dark_edition}shared{}",
					"between {C:attention}playing cards{}",
					"{C:red}X#5#{} base Blind size",
					"{C:red,s:0.8}#1# {s:0.8}hand, {C:red,s:0.8}#2# {s:0.8}discard, {C:attention,s:0.8}+#6#{s:0.8} Ante to win",
					"{C:red,s:0.8}#3# {s:0.8}Joker slot, {C:red,s:0.8}#4# {s:0.8}Consumable slot",
					"{C:inactive,s:0.9}Can get quite laggy, be warned!{}",
					"{C:inactive,s:0.8}Animation skipping mods recommended.{}",
				}
			},
			b_toga_prairie = {
				name = "Prairie Deck",
				text = {
					"{C:attention}Vanilla{} scoring of",
					"{C:attention}played{} cards",
					"does not occur."
				}
			},
			b_toga_betafish = {
				name = "Betafish Deck",
				text = {
					"{C:attention}Vanilla{} scoring of",
					"{C:attention}held in hand{} cards",
					"does not occur."
				}
			},
		},
		Blind = {
			bl_toga_dialupmodem = {
				name = "The Dial-Up",
				text = {
					"#1# card selection limit"
				}
			},
			bl_toga_worldwideweb = {
				name = "The World Wide Web",
				text = {
					"+#1# card selection limit",
					"and hand size"
				}
			},
			bl_toga_worldwideweb_collection = {
				name = "The World Wide Web",
				text = {
					"The world is at your fingertips",
					"{s:0.8}(Appears if The Dial-Up is cleared){}"
				}
			},
			bl_toga_joystick = {
				name = "The Joystick",
				text = {
					"First hand drawn is",
					"automatically played"
				}
			},
			bl_toga_xpboss = {
				name = "The Experience",
				text = {
					"The Experience",
				}
			},
		},
		Joker = {
			j_toga_y2kbug = {
				name = 'Y2K Bug',
				text = {
					"If the played hand contains a",
					"{C:attention}2{} and a {C:attention}King{}, scoring cards",
					"give {C:chips}+#1#{} Chips and {C:red}+#2#{} Mult",
					"{C:inactive,s:0.8}Have you updated your system yet?{}",
				}
			},
			j_toga_controlpanel = {
				name = 'Control Panel',
				text = {
					"Gives {C:money}$#1#{} for every Joker and",
					"Consumable slots at end of round.",
					"Defeating {C:attention}Boss Blinds{} upgrades",
					"individual slot payout by {C:money}$#2#{}.",
					"{C:inactive,s:0.8}(Currently {}{C:money,s:0.8}$#3#{}{C:inactive,s:0.8}){}",
					"{C:inactive,s:0.8}Look at all them settings!{}"
				}
			},
			j_toga_mcanvil = {
				name = 'Anvil',
				text = {
					"Retrigger a scoring card",
					"#1# time(s) per {C:attention}4 Steel Cards{}",
					"in your {C:important}full deck{}.",
					"{C:inactive,s:0.8}(Currently #2#){}"
				}
			},
			j_toga_taskmgr = {
				name = 'Task Manager',
				text = {
					"On {C:attention}last discard{}, {C:red}destroy{}",
					"{C:attention}all{} discarded cards.",
					"{C:inactive,s:0.8}I want to speak to your Manager!{}"
				}
			},
			-- Old Task Manager ability, tweaked.
			j_toga_useraccounts = {
				name = 'User Accounts',
				text = {
					"{C:green}#2# in #3#{} chance for scoring cards to",
					"give {X:mult,C:white}XMult{} based on half of calculated",
					"average of current {C:chips}hands{} & {C:red}discards{} left",
					"and {C:attention}Joker{} & {C:attention}Consumable{} slots.",
					"{C:inactive,s:0.8}(Currently {}{X:mult,C:white,s:0.8}X#1#{}{C:inactive,s:0.8}){}",
				}
			},
			j_toga_jimbo95 = {
				name = 'Start Menu',
				text = {
					"{C:attention}+#1#{} hand size",
					"Retrigger all Jokers #2# time(s).",
					"{X:chips,C:white} X#3# {} Chips, {X:mult,C:white} X#4# {} Mult",
					"{C:inactive,s:0.8}Start Me Up.{}"
				}
			},
			j_toga_solitairejoker = {
				name = 'Solitaire Joker',
				text = {
					"When playing a hand {C:attention}containing{} a {C:attention}Straight{},",
					"draw remaining {C:attention}#2#s{} in the deck to hand.",
					"Rank changes every round.",
					"{C:inactive,s:0.8}An Office regular.{}"
				}
			},
			j_toga_drivespace = {
				name = 'DriveSpace',
				text = {
					"{X:attention,C:white}X#1#{} Blind requirement",
					"when a card {C:attention}scores{}.",
					"{C:inactive,s:0.8}Back when hard drives were{}",
					"{C:inactive,s:0.8}smaller than CDs...{}"
				}
			},
			j_toga_win95 = {
				name = 'Windows 95',
				text = {
					"{C:chips}+#1#{} hand(s) & {C:red}+#2#{} discard(s)",
					"upon selecting a {C:attention}Blind{}.",
					"If there are {C:attention}#4#{} or fewer",
					"Jokers, get {C:attention}X#3#{} the amount."
				}
			},
			j_toga_win98 = {
				name = 'Windows 98',
				text = {
					"When a card {C:attention}scores{}, {C:attention}#3#%{} of total sell value",
					"of all current Jokers is given as {C:red}Mult{}. {C:inactive,s:0.8}(Currently {C:money,s:0.8}$#4#{C:inactive,s:0.8}){}",
					"Held {C:attention}Consumables{} increase given {C:red}Mult{} by {C:attention}#1#%{} each.",
					"{C:inactive,s:0.8}(Currently #2#%){}"
				}
			},
			j_toga_winmillenium = {
				name = 'Windows ME',
				text = {
					"Each {C:attention}Joker{} held gives {C:chips}+#1#{} Chips, with",
					"additional {C:chips}+#2#{} Chips per {C:attention}Voucher{} redeemed.",
					"{C:inactive,s:0.8}(Currently {}{C:chips,s:0.8}+#3#{}{C:inactive,s:0.8} per Joker){}"
				}
			},
			j_toga_winnt4 = {
				name = 'Windows NT4',
				text = {
					"Retrigger all",
					"played {C:attention}non-face{} cards",
					"#1# time(s).",
					"{C:inactive,s:0.6}Hang on, this is just a{}",
					"{C:inactive,s:0.6}backwards Sock and Buskin!{}"
				}
			},
			j_toga_win2000 = {
				name = 'Windows 2000',
				text = {
					"Generates a random {C:attention}Tag{}",
					"when completing {C:attention}Blinds{}"
				}
			},
			j_toga_winxp = {
				name = 'Windows XP',
				text = {
					"{C:green}#1# in #2#{} chance to {C:attention}double{}",
					"leveling amount before",
					"{C:attention}upgrading{} a poker hand"
				}
			},
			j_toga_jokersrb2kart = {
				name = 'Karting Joker',
				text = {
					"Gains {X:mult,C:white}XMult{} when",
					"performing {C:attention}actions{}.",
					"{C:red,s:0.8}Self debuffs if {X:mult,C:white,s:0.8}XMult{C:red,s:0.8} goes below {X:mult,C:white,s:0.8}X1{}{C:red,s:0.8}.{}",
					"{C:inactive}(Currently {}{X:mult,C:white}X#1#{}{C:inactive}){}",
					"{C:inactive,s:0.7}I am literally a racer, what's your excuse?{}"
				}
			},
			j_toga_whatisthis = {
				name = '65 52 72 6F 52',
				text = {
					"Held {C:attention}Consumables{} give",
					"{X:dark_edition,C:white}^^#1#{} Mult each.",
					"{C:inactive,s:0.8}What is this?!{}"
				}
			},
			j_toga_quacksoft = {
				name = 'Duck?',
				text = {
					"{X:dark_edition,C:white}^#1#{} Chips per card",
					"in the {C:attention}full deck{}",
					"{C:inactive,s:0.8}(Currently {}{X:dark_edition,C:white,s:0.8}^#2#{} {C:inactive,s:0.8}Chips){}",
					"{C:inactive,s:0.8,E:1}Quack.{}"
				}
			},
			j_toga_winupdate = {
				name = 'Joker Update',
				text = {
					"When {C:attention}entering shop{}, {C:attention}add{} a random",
					"{C:attention}Voucher{} and {C:attention}Booster Pack{} to shop",
					"{C:inactive,s:0.8}Upgrades, upgrades!{}"
				}
			},
			j_toga_virtualmemory = {
				name = 'Virtual Memory',
				text = {
					"{C:green}#1# in #2#{} chance for each ",
					"scored card to swap currently",
					"scored {C:chips}Chips{} and {C:mult}Mult{}",
					"{C:inactive,s:0.8}Download more RAM, they said...{}"
				}
			},
			j_toga_recyclebin = {
				name = 'Recycle Bin',
				text = {
					"Right most {C:attention}scoring{} card gives {X:chips,C:white}X#2#{} Chips.",
					"Destroying {C:attention}playing cards{} increases {X:chips,C:white}XChips{}",
					"by {X:chips,C:white}X#1#{} or {X:chips,C:white}X#3#{} if destroyed",
					"card is {C:attention}enhanced{}.",
					"{C:inactive,s:0.8}Taking out the trash...{}"
				}
			},
			j_toga_clippit = {
				name = 'Clippit',
				text = {
					{
						"Rescore all {C:attention}held in hand{}",
						"card abilities {C:attention}#1#{} time(s).",
					},
					{
						"{C:inactive,s:0.8}It looks like you're trying to naneinf.{}",
						"{C:inactive,s:0.8}Would you like help?{}"
					}
				}
			},
			j_toga_asterism = {
				name = 'Asterism',
				text = {
					"{C:mult}+#2#{} Mult per",
					"{C:planet}Planet{} card",
					"used this run",
					"{C:inactive}(Currently {}{C:mult}+#1#{}{C:inactive}){}"
				}
			},
			j_toga_theinternet = {
				name = 'The Internet',
				text = {
					"{C:chips}+#2#{} Chips per",
					"any {C:dark_edition}Consumable{}",
					"used this run",
					"{C:inactive}(Currently {}{C:chips}+#1#{}{C:inactive}){}",
					'{C:inactive,s:0.8}"the internet is{}',
					'{C:inactive,s:0.8}gaming right now"'
				}
			},
			j_toga_computerlock = {
				name = 'Computer Lock',
				text = {
					"When sold, adjacent",
					"{C:attention}Jokers{} become {C:dark_edition}Eternal{}.",
					"If {C:attention}already{} {C:dark_edition}Eternal{},",
					"remove instead."
				}
			},
			j_toga_bonusducks = {
				name = 'Bonus Ducks',
				text = {
					"All played {C:attention}face{}",
					"cards become",
					"{C:chips}Bonus{} cards",
					"when scored",
					"{C:inactive,s:0.8}Merasmus!{}"
				}
			},
			j_toga_pso2ironwill = {
				name = 'Skill: Iron Will',
				text = {
					"Prevents death if active and at",
					"least {C:money}$1{} is held, sets money to {C:money}$0{}",
					"and becomes inactive. {C:attention}Recharges{}",
					"upon {C:attention}defeating{} a Boss Blind.",
					"{C:inactive,s:0.8}Currently: #2#{}"
				}
			},
			j_toga_systemrestore = {
				name = 'System Restore',
				text = {
					"When {C:attention}playing cards{} are {C:red}destroyed{}, copy the",
					"{C:attention}first{} destroyed card into the deck with",
					"additional duplicates of it for",
					"{C:attention}each{} other destroyed card.",
				}
			},
			j_toga_spacecadetpinball = {
				name = 'Space Cadet',
				text = {
					"After the played cards are {C:attention}scored{},",
					"{C:green}#3# in 3{} chance to perform {C:attention}additional scoring{}",
					"of a {C:attention}random{} card in the scoring hand.",
					"{s:0.9}For every {C:money,s:0.9}$20{s:0.9} held, this is done {C:attention,s:0.9}once{s:0.9} more.",
					"{C:inactive,s:0.8}Currently #2# attempts.{}"
				}
			},
			j_toga_heartyspades = {
				name = 'Hearty Spades',
				text = {
					"{C:hearts}Hearts{} and {C:spades}Spades{}",
					"count as the same suit",
					"{C:inactive,s:0.8}Hearty meal...{}"
				}
			},
			j_toga_rover = {
				name = 'Rover',
				text = {
					"After scoring of {C:attention}played{} cards,",
					"each card in the {C:attention}deck{} has a",
					"{C:green}#1# in #2#{} chance to be {C:attention}scored{}",
					"as well",
					"{C:inactive,s:0.8}woof.{}"
				}
			},
			j_toga_binaryjkr = {
				name = 'Binary Joker',
				text = {
					"{C:attention}10s{} are",
					"considered as {C:attention}2s{}"
				}
			},
			j_toga_hexadecimaljkr = {
				name = 'Hexadecimal Joker',
				text = {
					"{C:attention}Aces{} are",
					"considered as {C:attention}10s{}"
				}
			},
			j_toga_y2ksticker = {
				name = 'Y2K Sticker',
				text = {
					"{C:attention}2s{} are",
					"considered as",
					"{C:attention}face cards{}"
				}
			},
			j_toga_michaelrosen = {
				name = 'Michael Rosen',
				text = {
					"{C:attention}Each effect{} has a {C:green}#1# in #2#{} chance",
					"to be given by cards {C:attention}held in hand{}.",
					"{C:inactive,s:0.8}*click* Nice.{}"
				}
			},
			j_toga_jimboplus = {
				name = 'JimboPlus!',
				text = {
					"When playing a hand, {C:attention}leech{} {X:attention,C:white}X#1#{}",
					"of {C:attention}Blind requirements{} to",
					"currently scored chips."
				}
			},
			j_toga_speedsneakers = {
				name = 'Speed Shoes',
				text = {
					"{X:mult,C:white}X#1#{} Mult for every {C:money}$#2#{} you have",
					"{C:inactive}(Currently {}{X:mult,C:white}X#3#{} {C:inactive}Mult){}",
					"{C:inactive,s:0.8,E:1}Gotta go fast!{}"
				}
			},
			j_toga_tomscott = {
				name = 'Tom Scott',
				text = {
					{
						"Gives {X:mult,C:white}X#1#{} Mult for every",
						"{C:attention}copy{} of itself held",
						"{C:inactive}(Currently {}{X:mult,C:white}X#2#{} {C:inactive}Mult){}",
						"{C:inactive,s:0.8}Stacks multiplicatively.{}",
					},
					{
						"{C:inactive,s:0.8}I am currently a Joker{}",
						"{C:inactive,s:0.8}in the Balatro video game.{}"
					}
				}
			},
			j_toga_megasxlr = {
				name = 'Megas XLR',
				text = {
					"{C:attention}8s{} are",
					"considered",
					"as {C:attention}Kings{}"
				}
			},
			j_toga_jarate = {
				name = 'Jarate',
				text = {
					{
						"{C:attention}#1#% Blind{} requirements",
						"when selecting a {C:attention}Boss Blind{}.",
						"Scored cards {C:attention}lose{} their",
						"enhancements, editions and seals.",
						"Recharges when {C:attention}entering{} shop.",
						"{C:inactive,s:0.8}#2#",
					},
					{
						"{C:inactive}Ah... {C:inactive,E:1}piss!{}"
					}
				}
			},
			j_toga_goldenwrench = {
				name = 'Golden Wrench',
				text = {
					"Does nothing...",
					"{C:inactive,s:0.8}Wonder what happens if this{}",
					"{C:inactive,s:0.8}were to be destroyed...{}",
				}
			},
			j_toga_virtualpc = {
				name = 'Virtual PC',
				text = {
					"When {C:attention}scoring starts{}, current",
					"{C:blue}Chips{} and {C:red}Mult{} are {C:attention}added{}",
					"to this Joker",
					"{C:inactive,s:0.85}(Currently {C:blue,s:0.85}#1#{C:inactive,s:0.85} Chips / {C:red,s:0.85}#2#{C:inactive,s:0.85} Mult)"
				}
			},
			j_toga_ie = {
				name = 'Internet Explorer',
				text = {
					"When {C:attention}leaving{} shop, {C:attention}upgrade per-level{} {C:blue}Chips{} and {C:red}Mult{}",
					"of a {C:attention}random{} poker hand by {C:blue}#1#%{} and {C:red}#2#%{} of {C:attention}base{}",
					"{C:blue}Chips{} and {C:red}Mult{} of said poker hand respectively.",
				}
			},
			j_toga_winvista = {
				name = 'Windows Vista',
				text = {
					"If the played hand contains",
					"a single {C:attention}6{}, {C:red}destroy{} it and",
					"convert the existing {C:attention}Edition{} of",
					"a {C:attention}random{} Joker to {C:dark_edition}Negative{}",
					"{C:inactive,s:0.8}(Cannot target already {C:dark_edition,s:0.8}Negative{C:inactive,s:0.8} Jokers.){}",
				}
			},
			j_toga_win7 = {
				name = 'Windows 7',
				text = {
					"Cards {C:attention}held in hand{}",
					"give {X:mult,C:white}X#1#{} Mult for",
					"every {C:blue}Common{} Joker held",
				}
			},
			j_toga_win8 = {
				name = 'Windows 8',
				text = {
					-- "Each {C:attention}8{} {C:red}discarded{} this round",
					-- "or in the remaining {C:attention}deck{}",
					-- "gives {X:mult,C:white}X#1#{} Mult",
					"Played {C:attention}8s{} gain",
					"{C:attention}held in hand{}",
					"{X:mult,C:white}X#1#{} Mult"
				}
			},
			j_toga_penwheel = {
				name = 'Pen Wheel',
				text = {
					"Each {C:colourcard}Colour{} card held",
					"gives {C:money}$#1#{} at end of round",
				}
			},
			j_toga_displayproperties = {
				name = 'Display Properties',
				text = {
					"At end of round, {C:attention}round increase{} of",
					"held {C:colourcard}Colour{} cards is triggered again",
				}
			},
			j_toga_colourfulprinter = {
				name = 'Colourful Printer',
				text = {
					"When {C:attention}Blind{} is selected,",
					"print a {C:colourcard}Colour{} card",
				}
			},
			j_toga_internetspades = {
				name = 'Internet Spades',
				text = {
					"If {C:attention}played hand{} contains",
					"only {C:spades}Spades{}, each held",
					"{C:attention}Consumeable{} gives {X:chips,C:white}X#1#{} Chips",
					"per {C:attention}Ahead Joker{} held."
				}
			},
			j_toga_spiceoflife = {
				name = 'Spice of Life',
				text = {
					"For every {C:attention}unique{} {C:bakery}Bakery{} good",
					"held, retrigger each one {C:attention}once{}."
				}
			},
			j_toga_spiceoflife_rtrg = {
				name = 'Spice of Life',
				text = {
					"For every {C:attention}unique{} {C:bakery}Bakery{} good",
					"held, retrigger each one {C:attention}once{}.",
					"{C:inactive}(Retriggers: {C:attention}#1#{C:inactive})"
				}
			},
			j_toga_skype = {
				name = 'Skype',
				text = {
					"{X:mult,C:white}X#1#{} Mult per {C:attention}each mod{} among",
					"redeemed {C:attention}Vouchers{}, held {C:attention}Jokers{}",
					"and {C:attention}Consumeables{}.",
					"{C:inactive}(Currently {}{X:mult,C:white}X#2#{}{C:inactive}, #3# mod.){}",
					"{C:inactive,s:0.7}RIP Skype (2003 - 2025){}"
				}
			},
			j_toga_skype_moremod = {
				name = 'Skype',
				text = {
					"{X:mult,C:white}X#1#{} Mult per {C:attention}each mod{} among",
					"held {C:attention}Jokers{} and {C:attention}Consumeables{}.",
					"{C:inactive}(Currently {}{X:mult,C:white}X#2#{}{C:inactive}, #3# mods.){}",
					"{C:inactive,s:0.7}RIP Skype (2003 - 2025){}"
				}
			},
			j_toga_msn = {
				name = 'MSN',
				text = {
					"This Joker gives",
					"{C:attention}stacking{} {X:mult,C:white}X#1#{} Mult",
					"per {C:attention}unique{} enhancement",
					"in the {C:attention}full{} deck.",
					"{C:inactive}(Currently {}{X:mult,C:white}X#2#{}{C:inactive}){}",
				}
			},
			j_toga_albanianvirus = {
				name = 'Albanian Virus',
				text = {
					"{s:0.9}Hi, I am an Albanian virus but because of poor technology in",
					"{s:0.9}my country unfortunately I am not able to harm your run.",
					"{s:0.9}Please be so kind to destroy one of your important",
					"{s:0.9}cards yourself and then forward me to other users. Many thanks",
					"{s:0.9}for your cooperation! Best regards,Albanian virus"
				}
			},
			j_toga_mac_os_9 = {
				name = 'Mac OS 9',
				text = {
					"Held in hand {C:clubs}Clubs{}",
					"give {X:mult,C:white}X#1#{} Mult"
				}
			},
			j_toga_mac_os_x = {
				name = 'Mac OS X',
				text = {
					"Held in hand {C:attention}10s{}",
					"give {X:chips,C:white}X#1#{} Chips"
				}
			},
			j_toga_linux_ubuntu = {
				name = 'Ubuntu',
				text = {
					"{C:attention}Jokers{} and {C:attention}Consumeables{} give {C:attention}#1#%{}",
					"of their {C:money}sell value{} as {X:mult,C:white}XMult{}."
				}
			},
			j_toga_linux_debian = {
				name = 'Debian',
				text = {
					"Halves all {C:attention}listed",
					"{C:green,E:1,s:1.1}probabilities",
					"{C:inactive}(ex: {C:green}1 in 3{C:inactive} -> {C:green}0.5 in 3{C:inactive})",
				},
			},
			j_toga_linux_slackware = {
				name = 'Slackware Linux',
				text = {
					"If more than 2 suits are {C:attention}played{},",
					"scoring cards give {X:mult,C:white}X#1#{} Mult per",
					"{C:attention}additional{} base suit in played hand.",
					"{C:inactive,s:0.8}(Ignores Wild Card, Smeared Joker, etc.){}"
				}
			},
			j_toga_linux_slackware_cardsel = {
				name = 'Slackware Linux',
				text = {
					"If more than 2 suits are {C:attention}played{},",
					"scoring cards give {X:mult,C:white}X#1#{} Mult per",
					"{C:attention}additional{} suit in played hand.",
					"{C:inactive,s:0.9}(Current card selection gives {}{X:mult,C:white,s:0.9}X#2#{}{C:inactive,s:0.9}){}",
					"{C:inactive,s:0.8}(Ignores Wild Card, Hearty Spades, etc.){}"
				}
			},
			j_toga_linux_redhat = {
				name = 'Red Hat Linux',
				text = {
					"For every {C:attention}poker hand{} in",
					"played hand, gain {X:mult,C:white}X#1#{} Mult.",
					"{C:inactive}(Currently {}{X:mult,C:white}X#2#{}{C:inactive}){}",
					"{C:inactive,s:0.8}(High Card excluded.){}"
				}
			},
			j_toga_linux_redhat_cardsel = {
				name = 'Red Hat Linux',
				text = {
					"For every {C:attention}poker hand{} in",
					"played hand, gain {X:mult,C:white}X#1#{} Mult.",
					"{C:inactive}(Currently {}{X:mult,C:white}X#2#{}{C:inactive}){}",
					"{C:inactive,s:0.8}(Poker hands: #3#, High Card excluded.){}"
				}
			},
			j_toga_horseconch = {
				name = 'The Horse Conch',
				text = {
					"Held cards with {C:attention}Horse Seals{}",
					"give {X:mult,C:white}X#1#{} Mult and {C:money}$#2#{}",
				}
			},
			j_toga_gatosorrindo = {
				name = 'Gato Sorrindo',
				text = {
					"Each held {C:attention}Cat Joker{}",
					"gives {X:chips,C:white}X#1#{} Chips",
					"{C:inactive,s:0.75}(Excluding self and copies of self.){}"
				}
			},
			j_toga_tempinternetfiles = {
				name = 'Downloaded Program Files',
				text = {
					"Gains {X:mult,C:white}X#2#{} Mult when a card is drawn.",
					"Resets if {C:blue}played{}/{C:red}discarded{} hand contains a {C:attention}Flush{}.",
					"{C:inactive}(Currently {}{X:mult,C:white}X#1#{}{C:inactive}){}",
				}
			},
			j_toga_google = {
				name = 'Google',
				text = {
					"Adds a {C:attention}6{} to deck",
					"when {C:attention}Blind{} is selected",
					"{C:inactive,s:0.8}Don't be evil.{}"
				},
			},
			j_toga_bonzibuddy = {
				name = 'Bonzi Buddy',
				text = {
					"{C:attention}Strength{}-like effects",
					"are inverted"
				},
			},
			j_toga_netscapenavigator = {
				name = 'Netscape Navigator',
				text = {
					"{C:dark_edition}Holographic{} {C:attention}Jokers{}",
					"or {C:attention}held in hand{} cards",
					"give {X:mult,C:white}X#1#{} Mult",
				},
			},
			j_toga_diskcleanup = {
				name = 'Disk Cleanup',
				text = {
					"Gain {C:money}$#1#{} per {C:red}destroyed{}",
					"{C:attention}#2#{} card",
					"{C:inactive,s:0.8}Suit changes every round.{}",
				},
			},
			j_toga_regedit = {
				name = 'Registry Editor',
				text = {
					"{C:attention}Overrides{} suit change to {C:attention}#1#{}.",
					"Suit changes every round.",
					"{C:inactive,s:0.9}Does not affect card copying.{}"
				},
			},
			j_toga_msagent = {
				name = 'Microsoft Agent',
				text = {
					"{C:dark_edition}Unbalances{}",
					"{C:blue}Chips{} and {C:red}Mult{}",
				},
			},
			j_toga_drwatson = {
				name = 'Dr. Watson',
				text = {
					"After a hand is played, {C:red}destroy{}",
					"debuffed {C:attention}played{}/{C:attention}held in hand{} cards",
				},
			},
			j_toga_fontsfolder = {
				name = 'Fonts',
				text = {
					"{X:mult,C:white}X#1#{} Mult for every",
					"custom font loaded",
					"{C:inactive,s:0.9}(Currently #2#, {X:mult,C:white,s:0.8}X#3#{C:inactive,s:0.8})",
				},
			},
			j_toga_fontsfolder_inactive = {
				name = 'Fonts',
				text = {
					"{E:2,s:1.2}Does nothing.{}",
					"{C:inactive,s:0.85}Load some fonts, will ya?{}"
				},
			},
			j_toga_pcmcia = {
				name = 'PCMCIA Card',
				text = {
					"{X:mult,C:white}X#1#{} Mult..?",
				},
			},
			j_toga_scsi = {
				name = 'SCSI',
				text = {
					"{C:attention}#1#{} hand size",
					"Increase hand size by {C:attention}1{}",
					"when {C:attention}redeeming{} a Voucher",
				},
			},
			j_toga_visualstudio = {
				name = 'Visual Studio',
				text = {
					"Rank of {C:attention}Strength{}-like effects",
					"is increased by {C:attention}#1#{}",
				},
			},
			j_toga_printershare = {
				name = 'Printer Sharing',
				text = {
					"{C:green}#2# in #3#{} chance for held",
					"{C:attention}Printers{} to give {X:mult,C:white}X#1#{} Mult",
				},
			},
			j_toga_netshow = {
				name = 'NetShow',
				text = {
					"When playing a hand, gain {X:mult,C:white}X#1#{} Mult",
					"for every {C:attention}unique{} movie genre held",
					"{C:inactive}(Currently #3#, {}{X:mult,C:white}X#2#{}{C:inactive}){}",
				},
			},
			j_toga_certserver = {
				name = 'Certificate Server',
				text = {
					"{C:attention}Overrides{} rank change to {C:attention}#1#s{}.",
					"Rank changes every round.",
					"{C:inactive,s:0.9}Does not affect card copying.{}",
				}
			},
			j_toga_cpu = {
				name = 'CPU',
				text = {
					"{C:red}+#1#{} Mult per {C:dark_edition}logical{} processor",
					"on current device",
					"{C:inactive}(Currently #2#, {C:red}+#3#{C:inactive} Mult)",
					"{C:inactive,s:0.8}P2W Joker?{}"
				}
			},
			j_toga_ups = {
				name = 'Uninterruptable Power Supply',
				text = {
					"When a {C:attention}card{} is {C:red}debuffed{}, gain {X:mult,C:white}X#1#{} Mult",
					"{C:inactive}(Currently {}{X:mult,C:white}X#2#{}{C:inactive}){}",
				}
			},
			j_toga_hammer = {
				name = 'Hammer',
				text = {
					"{C:attention}Held in hand Glass{} cards",
					"are also {C:attention}scored{} as if they",
					"had been {C:attention}played{} but their",
					"{C:green}chance{} to {C:red}break{} is {C:attention}doubled{}",
					"{C:inactive,s:0.8}Anyone remember Atom Smasher?{}"
				}
			},
			j_toga_joker203 = {
				name = 'Joker 2.03',
				text = {
					"{X:attention,C:white}X#1#{} Blind requirements",
					"{X:purple,C:white}=0{} Score if {C:attention}scored hand{}",
					"{C:red}does not{} beat the Blind.",
				}
			},
			j_toga_activesync = {
				name = 'ActiveSync',
				text = {
					"{C:green}#1# in #2#{} chance to {C:attention}swap{} any",
					"{C:attention}operations{} on {C:blue}Chips{} or {C:red}Mult{}",
					"to the {C:attention}other{} instead",
				}
			},
			j_toga_chrome = {
				name = 'Chrome',
				text = {
					"{X:mult,C:white}X#1#{} Mult per {C:attention}process{} with '{C:attention}#4#{}'",
					"in the {C:attention}name{} currently running.",
					"{C:attention,s:0.8}Additional{s:0.8} processes give {C:red,s:0.8}diminishing{s:0.8} returns.{}",
					"{C:inactive}(Currently {C:attention}#3#{}, {X:mult,C:white}X#2#{}{C:inactive}){}",
				}
			},
			j_toga_firefox = {
				name = 'Firefox',
				text = {
					"{X:chips,C:white}X#1#{} Chips per {C:attention}process{} with '{C:attention}#4#{}'",
					"in the {C:attention}name{} currently running.",
					"{C:attention,s:0.8}Additional{s:0.8} processes give {C:red,s:0.8}diminishing{s:0.8} returns.{}",
					"{C:inactive}(Currently {C:attention}#3#{}, {X:chips,C:white}X#2#{}{C:inactive}){}",
				}
			},
			j_toga_cavingjkr = {
				name = 'Caving Joker',
				text = {
					{
						"All played {C:attention}non-face{} cards",
						"become {C:attention}Stone{} cards",
						"afterwards",
					},
					{
						"{C:inactive,s:0.75}May reveal rank or suit{}",
						"{C:inactive,s:0.75}of certain cards...{}",
					}
				},
			},
			j_toga_miningjkr = {
				name = 'Mining Joker',
				text = {
					"{C:attention}Unenhanced{} cards played on the",
					"{C:attention}first hand{} of round are {C:attention}converted{}",
					"to {C:attention}Mineral{} cards afterwards.",
					"{C:inactive,s:0.8}Hold Left SHIFT before hovering over{}",
					"{C:inactive,s:0.8}this card to show the Mineral pool.{}"
				}
			},
			j_toga_miningjkr_showminerals = {
				name = 'Mining Joker',
				text = {
					"{C:attention}Unenhanced{} cards played on the",
					"{C:attention}first hand{} of round are {C:attention}converted{}",
					"to {C:attention}Mineral{} cards afterwards.",
				}
			},
			j_toga_tuneupwizard = {
				name = 'Tune-up Wizard',
				text = {
					"{C:attention}Inverts{} face card",
					"consideration"
				}
			},
		},
		Enhanced = {
			m_toga_notification = {
				name = "Notification Card",
				text = {
					"{s:0.9}Wherever applicable,",
					"{C:attention,s:0.9}always{s:0.9} gets drawn",
					"{s:0.9}to hand.{}",
				},
			},
			m_toga_sms = {
				name = "SMS Card",
				text = {
					"{s:0.9}Deprioritized when {C:attention,s:0.9}drawing{s:0.9} cards.",
					"{s:0.9}If in {C:attention,s:0.9}deck{s:0.9} and playing a hand,",
					"{s:0.9}this card is {C:attention,s:0.9}forced{s:0.9} into play.",
				},
			},
			m_toga_coalcoke = {
				name = "Coal Coke Card",
				text = {
					"{C:chips}+#1#{} Chips",
					"while this card",
					"stays in hand",
					"No rank or suit"
				},
			},
			m_toga_iron = {
				name = "Iron Card",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
					"while this card",
					"stays in hand",
				},
			},
			m_toga_silver = {
				name = "Silver Card",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
				},
			},
			m_toga_electrum = {
				name = "Electrum Card",
				text = {
					"Earn {C:money}$#1#{} and",
					"{X:mult,C:white}X#2#{} Mult",
					"when scored"
				},
			},
			m_toga_copper = {
				name = "Copper Card",
				text = {
					"{X:chips,C:white}X#1#{} Chips",
					"while this card",
					"stays in hand",
				},
			},
			m_toga_tin = {
				name = "Tin Card",
				text = {
					"Always scores",
				},
			},
			m_toga_bronze = {
				name = "Bronze Card",
				text = {
					"{X:chips,C:white}X#1#{} Chips",
					"while this card",
					"stays in hand",
				},
			},
			m_toga_osmium = {
				name = "Osmium Card",
				text = {
					"{X:chips,C:white}X#1#{} Chips",
				},
			},
			m_toga_redstone = {
				name = "Redstone Card",
				text = {
					"If {C:attention}played{}, draw a card",
					"to {C:attention}hand{} from deck",
				},
			},
			m_toga_nickel = {
				name = "Nickel Card",
				text = {
					"Can't be debuffed"
				},
			},
			m_toga_invar = {
				name = "Invar Card",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
					"while this card",
					"stays in hand",
				},
			},
			m_toga_signalum = {
				name = "Signalum Card",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
				},
			},
			m_toga_glowstone = {
				name = "Glowstone Card",
				text = {
					"Does not count",
					"as base rank",
				},
			},
			m_toga_lumium = {
				name = "Lumium Card",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
					"while this card",
					"stays in hand",
				},
			},
			m_toga_refinedglowstone = {
				name = "Refined Glowstone Card",
				text = {
					"{X:chips,C:white}X#1#{} Chips",
					"{X:mult,C:white}X#2#{} Mult",
				},
			},
		},
		Tarot = {
			c_toga_furnace = {
				name = "Smeltery",
				text = {
					"Processes specific recipes",
					"depending on cards selected",
					"Cost per use: {C:money}$#2#{}",
					"{C:inactive,s:0.8}If you can pay for another{}",
					"{C:inactive,s:0.8}use, keep on use.{}",
					"{C:inactive,s:0.8}(To see recipes, hold Left Shift{}",
					"{C:inactive,s:0.8}before hovering over the card.){}",
				}
			},
			c_toga_furnace_ready = {
				name = "Smeltery",
				text = {
					"Processes specific recipes",
					"depending on cards selected",
					"Current recipe found:",
					"{C:attention,s:0.9}#1#{}",
					" ",
					"Cost per use: {C:money}$#2#{}",
					"{C:inactive,s:0.8}If you can pay for another{}",
					"{C:inactive,s:0.8}use, keep on use.{}"
				}
			},
			c_toga_furnace_novalidrecipe = {
				name = "Smeltery",
				text = {
					"Processes specific recipes",
					"depending on cards selected",
					"{C:inactive,s:0.9}#1#{}",
					"{C:inactive,s:0.8}If you can pay for another{}",
					"{C:inactive,s:0.8}use, keep on use.{}",
					"{C:inactive,s:0.8}(To see recipes, hold Left Shift{}",
					"{C:inactive,s:0.8}before hovering over the card.){}",
				}
			},
			c_toga_miningprospect = {
				name = "Prospect",
				text = {
					"Destroys {T:m_stone,C:attention}Stone Cards{} in the {C:attention}full deck{}.",
					"{C:green}#1# in #2#{} chance for a {T:m_stone,C:attention}Stone Card{} to",
					"convert into a {C:attention}Mineral{} card instead.",
					"{C:inactive,s:0.8}Hold Left SHIFT before hovering over{}",
					"{C:inactive,s:0.8}this card to show the Mineral pool.{}"
				}
			},
			c_toga_miningprospect_showminerals = {
				name = "Prospect",
				text = {
					"Destroys {T:m_stone,C:attention}Stone Cards{} in the {C:attention}full deck{}.",
					"{C:green}#1# in #2#{} chance for a {T:m_stone,C:attention}Stone Card{} to",
					"convert into a {C:attention}Mineral{} card instead.",
				}
			},
			c_toga_inbox = {
				name = "Inbox",
				text = {
					"Destroy up to",
					"{C:attention}#1# SMS Cards{}",
					"in the {C:attention}full deck{}"
				}
			},
			c_toga_bombshee = {
				name = "Bomb?",
				text = {
					"Get him off?"
				}
			},
			c_toga_bombshee_n = {
				name = "Bomb?",
				text = {
					"Hi."
				}
			},
		},
		Spectral = {
			c_toga_selfpropelledbomb = {
				name = "Self-Propelled Bomb",
				text = {
					"Destroys up to {C:attention}#1#{} cards in the {C:attention}deck{}.",
					"{C:inactive,s:0.8}({C:attention,s:0.8}#4#{C:inactive,s:0.8} cards or {C:attention,s:0.8}#5#%{C:inactive,s:0.8} of the deck, whichever is larger.)",
					"If sold or destroyed, {C:green}#3# in #2#{}",
					"chance to trigger anyway.",
				}
			},
			c_toga_sealingaround = {
				name = "Sealing Around",
				text = {
					"Add a {C:attention}Seal^2{}",
					"to {C:attention}#1#{} selected",
					"card in your hand"
				}
			},
			c_toga_filesource = {
				name = "File Source",
				text = {
					"Enhances {C:attention}#1#{} selected cards",
					"to {C:attention}Notification{} cards",
				}
			},
			c_toga_mobilephone = {
				name = "Phone",
				text = {
					"Enhances {C:attention}#1#{} selected cards",
					"to {C:attention}SMS{} cards",
				}
			},
			c_toga_hyperlink = {
				name = "Hyperlink",
				text = {
					"Add a {C:attention}Hyperlink Seal{}",
					"to {C:attention}#1#{} selected",
					"card in your hand"
				}
			},
			c_toga_alloyer = {
				name = "Alloy",
				text = {
					"{C:green}#2# in #3#{} chance to enhance",
					"{C:attention}#1#{} card to an {C:attention}Alloy{} card.",
					"{C:inactive,s:0.8}Hold Left SHIFT before hovering over{}",
					"{C:inactive,s:0.8}this card to show the Alloy pool.{}"
				}
			},
			c_toga_alloyer_showalloys = {
				name = "Alloy",
				text = {
					"{C:green}#2# in #3#{} chance to enhance",
					"{C:attention}#1#{} card to an {C:attention}Alloy{} card.",
				}
			},
		},
		Tag = {
			tag_toga_togajokershop = {
				name = "Spare CD Tag",
				text = {
					"Shop has a free",
					"{C:attention}TOGA Joker{}",
				},
			},
			tag_toga_togajokerbooster = {
				name = "Application Tag",
				text = {
					"Gives a free",
					"{C:attention}ZIP Package{}",
				},
			},
			tag_toga_togajokerziparchive = {
				name = "Joker.ZIP Tag",
				text = {
					"Gives a free",
					"{C:attention}Joker.ZIP{}",
				},
			},
			tag_toga_thespbroll = {
				name = "SPB Tag",
				text = {
					"Get a",
					"{C:attention}Self-Propelled{}",
					"{C:attention}Bomb{}"
				},
			},
			tag_toga_guaranteedice = {
				name = "D20 Tag",
				text = {
					"Shop has an",
					"{C:attention}Oops, all 6s{}",
				},
			},
			tag_toga_thenet = {
				name = "Globe Tag",
				text = {
					"Gives a free",
					"{C:spectral}Black Hole{}",
				},
			},
			tag_toga_thenet_cryptid = {
				name = "Globe Tag",
				text = {
					"Gives a free {C:spectral}Black Hole{}",
					"{C:green,s:0.75}#1# in #2# {C:inactive,s:0.75}chance for {C:spectral,s:0.75}White Hole{C:inactive,s:0.75} instead",
				},
			},
			tag_toga_controlexe = {
				name = "Settings Tag",
				text = {
					"Applies a {C:attention}random{} {C:dark_edition}edition{}",
					"to a random {C:attention}Joker{}",
					"{C:attention}without{} an {C:dark_edition}edition{}",
				},
			},
			tag_toga_thelegend = {
				name = "Dragon Tag",
				text = {
					"Shop has a",
					"{C:dark_edition}Legendary{} Joker",
				},
			},
			tag_toga_togarararchive = {
				name = "RAR Tag",
				text = {
					"Gives a free",
					"{C:attention}CONSUMAB.RAR{}",
				},
			},
			tag_toga_togacardcabarchive = {
				name = "Solitaire Tag",
				text = {
					"Gives a free",
					"{C:attention}PLAYCARD.CAB{}",
				},
			},
			tag_toga_togaxcopydnaarchive = {
				name = "XCOPY Tag",
				text = {
					"Gives a free",
					"{C:attention}XCOPY.DNA{}",
				},
			},
		},
		Voucher = {
			v_toga_fat32 = {
				name = "FAT32 Converter",
				text = {
					"{C:attention}+#1#%{} {C:inactive}(of current){} hand size",
					"{C:inactive,s:0.8}(Rounded up.){}"
				},
			},
			v_toga_hardwarewizard = {
				name = "Hardware Wizard",
				text = {
					"Multiplies all {C:attention}listed{} {E:1,C:green}probabilities{}",
					"for the rest of the run by {X:attention,C:white}X#1#{}",
					"{C:inactive}(ex: {}{C:green}1 in 3{}{C:inactive} -> {}{C:green}#1# in 3{}{C:inactive}){}"
				},
			},
			v_toga_hardwarewizardxp = {
				name = "Hardware Wizard (XP)",
				text = {
					"Multiplies all {C:attention}listed{} {E:1,C:green}probabilities{}",
					"for the rest of the run by {X:attention,C:white}X#1#{}",
					"{C:inactive}(ex: {}{C:green}1 in 3{}{C:inactive} -> {}{C:green}#1# in 3{}{C:inactive}){}"
				},
			},
			v_toga_diskdefrag = {
				name = "Disk Defragmenter",
				text = {
					"{C:red}-#1#{} discard each round.",
					"{C:red}+#1#{} discard after",
					"playing any hand."
				},
			},
			v_toga_mspaint = {
				name = "Microsoft Paint",
				text = {
					"{C:red}#2#{} {C:attention}Joker{} slots",
					"{C:attention}Held in hand{} cards give",
					"{X:dark_edition,C:white}^#1#{} Chips this run"
				},
			},
			v_toga_dataflush = {
				name = "ipconfig /flushdns",
				text = {
					"Discarding hands containing a {C:attention}Flush{}",
					"creates a {C:dark_edition}Negative{} copy of a random",
					"{C:attention}consumable{} card currently held."
				},
			},
			v_toga_dataflush_multiple = {
				name = "ipconfig /flushdns",
				text = {
					"Discarding hands containing a {C:attention}Flush{}",
					"creates #1# {C:dark_edition}Negative{} copies of a random",
					"{C:attention}consumable{} card currently held."
				},
			},
			v_toga_wormsninjarope = {
				name = "Ninja Rope",
				text = {
					"{C:attention}+#1#{} card selection limit",
					"{C:inactive,s:0.8}Hey, this is familiar...{}",
				},
			},
			v_toga_wormsscalesofjustice = {
				name = "Scales of Justice",
				text = {
					"Even the scales.",
					"{C:inactive,s:0.8}Use wisely.{}"
				},
			},
			v_toga_sealegg = {
				name = "Sealing Egg",
				text = {
					"{C:attention,T:j_egg}Eggs{} created by {C:attention,T:toga_sealseal_seal}Seal^2{} have a",
					"{C:green}#1# in #2#{} chance to be {C:dark_edition}Negative{}.",
				},
			},
			v_toga_caniofferyouanegg = {
				name = "Can I Offer You An Egg In These Times",
				text = {
					"{C:attention,T:j_egg}Eggs{} created by {C:attention,T:toga_sealseal_seal}Seal^2{} {E:1,C:green}will{} be {C:dark_edition}Negative{}.",
				},
			},
			v_toga_spectralzipper = {
				name = "Spectral Zipper",
				text = {
					"{C:attention}Joker.ZIP{} and {C:attention}CONSUMAB.RAR{}",
					"have a {C:green}#1# in #2#{} chance to",
					"contain {C:dark_edition}Legendary{} items."
				},
			},
			v_toga_auroramatter = {
				name = "Aurora Matter",
				text = {
					"{C:dark_edition}Negative{} cards are {X:attention,C:white}#1#X{}",
					"more likely to appear"
				},
			},
			v_toga_quantummatter = {
				name = "Quantum Matter",
				text = {
					"{C:dark_edition}Negative{} cards are {X:dark_edition,C:white}#1#X{}",
					"more likely to appear"
				},
			},
		},
		Other = {
			toga_sealseal = {
				name = "Seal^2",
				text = {
					"Creates an {C:attention,T:j_egg}Egg",
					"when scored",
					"{C:inactive}(Must have room){}"
				},
			},
			toga_sealseal_alt1 = {
				name = "Seal^2 - Upgraded",
				text = {
					"Creates an {C:attention,T:j_egg}Egg{} when scored",
					"{C:green}#1# in #2#{} chance to be {C:dark_edition}Negative{}",
					"{C:inactive}(Must have room){}",
				},
			},
			toga_sealseal_alt2 = {
				name = "Seal^2 - Upgraded",
				text = {
					"Creates a {C:dark_edition}Negative{}",
					"{C:attention,T:j_egg}Egg{} when scored",
				},
			},
			toga_urlseal_seal = {
				name = "Hyperlink Seal",
				text = {
					"{C:attention}Held in hand{} abilities",
					"of this card trigger",
					"{C:attention}even{} if {C:attention}not{} in hand."
				},
			},
			toga_albavirusinfo = {
				name = "Heads up!",
				text = {
					"Selling or destroying this card",
					"without selling or destroying",
					"a different one will actually",
					"lose the run. If this tooltip",
					"does not appear, it is",
					"safe to remove."
				},
			},
			p_toga_togazipboosterpack = {
				name = "ZIP Package",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{} TOGA Jokers",
				},
			},
			p_toga_togaziparchivepack = {
				name = "Joker.ZIP",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{} random {C:attention}Jokers{}",
				},
			},
			p_toga_togararpack = {
				name = "CONSUMAB.RAR",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{} random {C:attention}Consumables{}",
				},
			},
			p_toga_togacardcabpack = {
				name = "PLAYCARD.CAB",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{} {C:attention}Playing{} cards to",
					"add to your deck"
				},
			},
			p_toga_togaxcopydnapack = {
				name = "XCOPY.DNA",
				text = {
					"Choose {C:attention}#1#{} of up to {C:attention}#2#{} {C:attention}copies{} of",
					"{C:attention}Playing{} cards in your deck"
				},
			},
			toga_clippyorigin = {
				name = "Clippit?",
				text = {
					"That's his {C:attention}original{}",
					"name, yes.",
				},
			},
			toga_kartjokerlist = {
				name = "Eligible Actions:",
				text = {
					"{C:attention}Buying{}, {C:money}selling{}, {C:attention}using{},",
					"{C:attention}adding{} cards to deck;",
					"{C:attention}opening{} booster packs;",
					"{C:attention}rerolling{} shop; ({X:mult,C:white}X#1#{})",
					"{C:attention}leaving{} shop. ({X:mult,C:white}X#2#{})",
				},
			},
			toga_kartjokershortcut = {
				name = "Shortcut:",
				text = {
					"Skipping {C:attention}blinds{} or {C:attention}booster packs{}",
					"has a {C:green}#1# in #2#{} chance to gain",
					"{X:mult,C:white}X#3#{} instead of {C:attention}losing{} {C:red}#4#%{}",
					"of currently accumulated {X:mult,C:white}XMult{}.",
				},
			},
			toga_kartjokershortcutspecial = {
				name = "Cutting ahead:",
				text = {
					"Gain {X:mult,C:white}X#1#{} when skipping",
					"{C:attention}blinds{} or {C:attention}booster packs{}",
					"{E:1,C:inactive,s:0.8}Careful to not hit that tree!",
				},
			},
			toga_useraccountsinfo = {
				name = "Formula",
				text = {
					"({C:attention}Joker slots{} + {C:attention}Consumable{} slots",
					"+ {C:blue}hands{} left + {C:red}discards{} left) / 8",
				},
			},
			toga_roseneffects = {
				name = "Possible effects:",
				text = {
					"{C:money}$#1#{}, {X:chips,C:white}X#2#{} Chips, {X:mult,C:white}X#3#{} Mult",
				},
			},
			toga_rosentalismanextra = {
				name = "With Talisman installed",
				text = {
					"{X:dark_edition,C:white}^#1#{} Chips, {X:dark_edition,C:white}^^#2#{} Chips, {X:dark_edition,C:white}^^^#3#{} Chips",
					"{X:dark_edition,C:white}^#4#{} Mult, {X:dark_edition,C:white}^^#5#{} Mult, {X:dark_edition,C:white}^^^#6#{} Mult",
					"{C:inactive,s:0.7}(10x, 20x and 40x less likely to be rolled respectively.){}",
				},
			},
			toga_jokerzipupgrade = {
				name = "Spectral Zipper",
				text = {
					"{C:green}#1# in #2#{} chance to have a",
					"{C:dark_edition}Legendary{} {C:attention}Joker{}.",
				},
			},
			toga_consumabrarupgrade = {
				name = "Spectral Zipper",
				text = {
					"{C:green}#1# in #2#{} chance",
					"to contain {C:dark_edition}The Soul{}.",
				},
			},
			toga_scales1 = {
				name = "Averages:",
				text = {
					"Joker & Consumable {C:attention}slots{},",
					"{C:attention}hand size{} and {C:attention}card selection limit{}.",
				},
			},
			toga_scales2 = {
				name = "Averages:",
				text = {
					"{C:attention}Poker hand{} {C:planet}levels{}.",
				},
			},
			toga_scales3 = {
				name = "Averages:",
				text = {
					"{C:blue}Hands{} and {C:red}discards{}.",
				},
			},
			toga_alloysteel = {
				name = "Steel Card Recipe",
				text = {
					"1x Iron",
					"+ 1x Coal Coke (consumed)",
					"= 1x Steel",
				},
			},
			toga_alloyelectrum = {
				name = "Electrum Card Recipe",
				text = {
					"1x Gold + 1x Silver",
					"= 2x Electrum",
				},
			},
			toga_alloybronze = {
				name = "Bronze Card Recipe",
				text = {
					"3x Copper + 1x Tin",
					"= 4x Bronze",
				},
			},
			toga_alloysignalum = {
				name = "Signalum Card Recipe",
				text = {
					"3x Copper + 1x Silver",
					"+ 1x Redstone (consumed)",
					"= 4x Signalum",
				},
			},
			toga_alloyinvar = {
				name = "Invar Card Recipe",
				text = {
					"2x Copper + 1x Nickel",
					"= 3x Invar",
				},
			},
			toga_alloylumium = {
				name = "Lumium Card Recipe",
				text = {
					"3x Tin + 1x Silver",
					"+ 1x Glowstone (consumed)",
					"= 4x Lumium",
				},
			},
			toga_alloyrefglowstone = {
				name = "Refined Glowstone Card Recipe",
				text = {
					"1x Osmium",
					"+ 1x Glowstone (consumed)",
					"= 1x Refined Glowstone",
				},
			},
		},
		Partner = {
			pnr_toga_startupdisk={
				name = "Startup Diskette",
				text = {
					"Reduces {C:attention}Blind requirements{} by {C:attention}#2#%{}",
					"when {C:attention}Blind{} is selected.",
				},
				unlock={
					"Used a {C:attention}Windows OS{} Joker",
					"to win on {C:attention}Gold",
					"{C:attention}Stake{} difficulty",
				},
			},
			pnr_toga_startupdisk_buff={
				name = "Startup Diskette",
				text = {
					"Reduces {C:attention}Blind requirements{} by {C:attention}#2#%{}",
					"when {C:attention}Blind{} is selected, with additional {C:attention}#3#%{}",
					"provided by currently held {C:attention}Windows OS Jokers{}.",
					"{C:inactive}(Currently {C:attention}#1#%{C:inactive})"
				},
				unlock={
					"Used a {C:attention}Windows OS{} Joker",
					"to win on {C:attention}Gold",
					"{C:attention}Stake{} difficulty",
				},
			},
			pnr_toga_amongusplushie={
				name = "Among Us Plushie",
				text = {
					"{C:green}#1# in #2#{} chance to give {C:attention}bonus{}",
					"{C:money}money{} at end of round.",
					"{C:inactive,s:0.8}#3#% of currently held money or $10,{}",
					"{C:inactive,s:0.8}whichever is higher.{}",
					"{C:inactive,s:0.75}Spin speed is tied to money held.{}"
				},
			},
		},
		Colour = {
			c_toga_classic = {
				name = "Classic",
				text = {
					"Create a {C:attention,t:tag_toga_togajokerziparchive}Joker.ZIP Tag{}",
					"for every {C:attention}#4#{} rounds",
					"this has been held",
					"{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
					next(SMODS.find_mod('MoreFluff')) and togabalatro and togabalatro.mf_art_credit("Multi")
				},
			},
			c_toga_professional = {
				name = "Professional",
				text = {
					"Create a {C:attention,t:tag_toga_togarararchive}RAR Tag{}",
					"for every {C:attention}#4#{} rounds",
					"this has been held",
					"{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
					next(SMODS.find_mod('MoreFluff')) and togabalatro and togabalatro.mf_art_credit("Multi")
				},
			},
			c_toga_luna = {
				name = "Luna",
				text = {
					"Create a {C:attention,t:tag_toga_togacardcabarchive}Solitaire Tag{}",
					"for every {C:attention}#4#{} rounds",
					"this has been held",
					"{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
					next(SMODS.find_mod('MoreFluff')) and togabalatro and togabalatro.mf_art_credit("Multi")
				},
			},
			c_toga_aero = {
				name = "Aero",
				text = {
					"Create a {C:attention,t:tag_toga_togaxcopydnaarchive}XCOPY Tag{}",
					"for every {C:attention}#4#{} rounds",
					"this has been held",
					"{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
					next(SMODS.find_mod('MoreFluff')) and togabalatro and togabalatro.mf_art_credit("Multi")
				},
			},
		},
		Sleeve = {
			sleeve_toga_frog = {
				name = "Frog Sleeve",
				text = {
					"{C:blue}+#1#{} hand, {C:red}+#2#{} discard,",
					"{C:red}#3#{} hand size"
				},
			},
			sleeve_toga_bluemountain = {
				name = "Blue Mountain Sleeve",
				text = {
					"Scoring is triggered",
					"in reverse order.",
				},
			},
			sleeve_toga_bluemountain_kart = {
				name = "Run It Back Mountain Sleeve",
				text = {
					"Playing cards are also",
					"triggered in reverse order.",
					"{C:inactive,s:0.8}'Run it back!'{}",
				},
			},
			sleeve_toga_bluemountain_drunk = {
				name = "Blue Mountain Sleeve",
				text = {
					"Scoring is triggered",
					"in normal order.",
					"{C:inactive,s:0.8}Wait...{}"
				},
			},
		}
	},
	misc = {
		suits_singular = {
			-- oops, nothing!
		},
		suits_plural = {
			-- oops, nothing!
		},
		dictionary = {
			togazipboosterpack = "ZIP Package",
			togaziparchivepack = "Joker.ZIP",
			togararpack = "CONSUMAB.RAR",
			togacardcabpack = "PLAYCARD.CAB",
			togaxcopydnapack = "XCOPY.DNA",
			toga_kartouch = "Ouch!",
			toga_karteliminated = "Eliminated!",
			toga_pagefileuse = "Swapped!",
			toga_activesyncchip = "Chips!",
			toga_activesyncmult = "Mult!",
			toga_active = "Active!",
			toga_inactive = "Inactive.",
			toga_updated = "Update!",
			toga_updateready = "Ready!",
			toga_pso2ironwillready = "Ready!",
			toga_pso2ironwillproc = "Procced!",
			toga_pso2ironwillrecharge = "Recharging...",
			toga_pso2ironwillsave = "Iron Will was triggered.",
			toga_systemrestore1 = "Duplicated!",
			toga_userlocked = "Locked!",
			toga_userunlocked = "Unlocked!",
			toga_spbavoidfail = "Hit!",
			toga_spbavoidsuccess = "Safe!",
			toga_bonusapply = "Bonus!",
			toga_anviltrigger = "Hit it!",
			toga_colourful = "Colourful!",
			toga_floppypartner = "Floppy!",
			toga_suspartner = "amogus.",
			--
			toga_furnaceprocess = "Smelted...",
			toga_novalidrecipe = "No recipes match selected cards.",
			toga_unknownvalidrecipe = "Unknown valid recipe.",
			toga_steelrecipe = "1x Iron + 1x Coal Coke (consumed) = 1x Steel",
			toga_electrumrecipe = "1x Gold + 1x Silver = 2x Electrum",
			toga_bronzerecipe = "3x Copper + 1x Tin = 4x Bronze",
			toga_signalumrecipe = "3x Copper + 1x Silver + 1x Redstone (consumed) = 4x Signalum",
			toga_invarrecipe = "2x Iron + 1x Nickel = 3x Invar",
			toga_lumiumrecipe = "3x Tin + 1x Silver + 1x Glowstone (consumed) = 4x Lumium",
			toga_refglowstonerecipe = "1x Osmium + 1x Glowstone (consumed) = 1x Refined Glowstone",
			toga_alloy = "Alloy",
			toga_crafttarot = "Crafting Tarot",
			toga_minetarot = "Mining Tarot",
			toga_stonenothing = "Nothing...",
			toga_stonefound = "!",
			--
			toga_unbalanced = "Unbalanced",
			toga_pluscard = "+1 Card",
			toga_solitairedraw = "Drawing...",
			toga_32bits = "32-bit!",
			toga_jimbo = "...",
			toga_jimbo95txt1 = "Run!",
			toga_jimbo95txt2 = "Again?",
			toga_jimbo95txt3 = "Another one!",
			toga_jimbo95txt4 = "Thread!",
			toga_Echipmod = "^#1# Chips",
			toga_EEchipmod = "^^#1# Chips",
			toga_EEEchipmod = "^^^#1# Chips",
			toga_Emultmod = "^#1# Mult",
			toga_EEmultmod = "^^#1# Mult",
			toga_EEEmultmod = "^^^#1# Mult",
			toga_jaraterecharging = "Waiting for resupply...",
			toga_jaraterestocked = "Resupplied!",
			toga_jarateready = "Ready!",
			toga_jarated = "Washed!",
			toga_perlevel = "per-level",
			toga_pinballing = "Score!",
			toga_roverwoof = "Woof.",
			toga_leech = "Leech",
			toga_bonziinvert = "Inverted",
			toga_hammersmash = "Smash!",
			toga_configtab = "Mod Settings",
			toga_logtab = "Logging Settings",
			toga_startsfxtab = "Misc. Audio Options",
			toga_startsfxoptions = "Sound:",
			toga_sfxwhenadd = "SFX when getting some of the mods' items",
			toga_sfxwhendel = "SFX when removing some of the mods' items",
			toga_sfxwhenuse = "SFX when some of the mods' items trigger",
			toga_musicpacks = "MIDI-fied music for own Booster Packs",
			toga_jokejokers = "Allow 'Joke' items to appear in pool",
			toga_verboselog = "Enable extra logs - [INFO]",
			toga_extraverboselog = "Increase log verbosity - [DEBUG]",
			toga_extraverboselogwarn = "Warning: including [DEBUG] messages may lag your game!",
			toga_mainmenumusicswap = "MIDI-fy the Main Menu music",
			toga_modtabmusicswap = "Custom music for own mod config menu",
			toga_startupsfx = "Enable mod startup sound on initial load",
			toga_startupsfxuse = "Use selected SFX for next game startup",
			toga_crashsfxuse = "Play a sound when game crashes",
			toga_qestuff = "Enable quantum enhancement deck (restart required)",
			toga_sfxswaptext = "SFX Swap Level:",
			toga_sfxswapnone = "None",
			toga_sfxswapdefault = "Default",
			toga_sfxswapall = "All",
			toga_startupsfxtest = "Test",
		},
		labels = {
			toga_sealseal_seal = "Seal^2",
			toga_urlseal_seal = "Hyperlink Seal"
		},
		v_dictionary = {
			toga_Echip = {"^#1# Chips"},
			toga_EEchip = {"^^#1# Chips"},
			toga_EEEchip = {"^^^#1# Chips"},
			toga_Emult = {"^#1# Mult"},
			toga_EEmult = {"^^#1# Mult"},
			toga_EEEmult = {"^^^#1# Mult"},
		},
		challenge_names = {
			c_toga_jokerful = "Jokerful..?"
		},
		v_text = {
			ch_c_toga_noplayedscore = {
				"{C:attention}Vanilla{} scoring of {C:attention}played{} cards does not occur",
			},
			ch_c_toga_nohandscore = {
				"{C:attention}Vanilla{} scoring of {C:attention}held in hand{} cards does not occur",
			},
		},
		collab_palettes = {
			toga_oldschool_Spades = { "Original", "Low Contrast (Recoloured)", "High Contrast (Recoloured)", },
			toga_oldschool_Hearts = { "Original", "Low Contrast (Recoloured)", "High Contrast (Recoloured)", },
			toga_oldschool_Clubs = { "Original", "Low Contrast (Recoloured)", "High Contrast (Recoloured)", },
			toga_oldschool_Diamonds = { "Original", "Low Contrast (Recoloured)", "High Contrast (Recoloured)", },
			toga_oldschool_bunc_Fleurons = { "Low Contrast (Recoloured)", "High Contrast (Recoloured)", },
			toga_oldschool_bunc_Halberds = { "Low Contrast (Recoloured)", "High Contrast (Recoloured)", },
			toga_modern_Spades = { "Classic", "Hearts Deck", "Seasons Deck", "Large Print Deck", },
			toga_modern_Hearts = { "Classic", "Hearts Deck", "Seasons Deck", "Large Print Deck", },
			toga_modern_Clubs = { "Classic", "Hearts Deck", "Seasons Deck", "Large Print Deck", },
			toga_modern_Diamonds = { "Classic", "Hearts Deck", "Seasons Deck", "Large Print Deck", },
		}
	}
}
