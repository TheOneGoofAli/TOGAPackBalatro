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
					"{C:inactive,s:0.8}Another what-if that became an actual thing...{}"
				}
			}
		},
        Back = {
			b_toga_frogdeck = {
				name = 'Frog Deck',
				text = {
					"{C:attention}+#3#{} Joker slot",
					"{C:attention}+#4#{} Consumable slot",
					"{C:attention}+#6#{} hand size",
					"{C:red}#1#{} hand, {C:red}#2#{} discard",
					"{C:red}X#5#{} Blind size",
					"Start with {C:money}$6{} more",
					"{C:inactive,s:0.8}What {C:spectral,s:0.8}secrets{C:inactive,s:0.8} does the frog hold?{}"
				}
			},
			b_toga_spacedeck = {
				name = 'Space Deck',
				text = {
					"Start the run",
					"with a {C:planet}Space Joker{}",
					"{C:planet}Planet Merchant{},",
					"{C:planet}Planet Tycoon{}",
					"{C:spectral,s:0.8}Spectral{s:0.8} cards",
					"{s:0.8}may appear in shop"
				}
			}
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
					"{C:attention}all{} discarded cards."
				}
			},
			-- Old Task Manager ability, tweaked.
			j_toga_useraccounts = {
				name = 'User Accounts',
				text = {
					"{C:green}#2# in #3#{} chance for scoring cards to",
					"give {X:mult,C:white}XMult{} based on calculated average of",
					"current {C:attention}Joker{} & {C:attention}Consumable{} slots and",
					"{C:chips}hands{} & {C:red}discards{} left.",
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
					"{C:attention}+#1#{} hand size",
					"{C:chips}+#2#{} Chips",
					"{C:chips}-#3#{} hand per round",
					"{C:inactive,s:0.8}An Office regular.{}"
				}
			},
			j_toga_drivespace = {
				name = 'DriveSpace',
				text = {
					"{X:attention,C:white}X#1#{} Blind requirement",
					"when a card {C:attention}scores{}."
				}
			},
			j_toga_win95 = {
				name = 'Windows 95',
				text = {
					"{C:chips}+#1#{} hand(s) & {C:red}+#2#{} discard(s)",
					"upon selecting a {C:attention}Blind{}.",
					"Earn {C:money}$#3#{} at end of round.",
					"If there are {C:attention}#5#{} or fewer",
					"Jokers, get {X:money,C:white}X#4#{} the amount."
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
					"Each {C:attention}Joker{} held gives {C:chips}+#1#{} Chips.",
					"Increase {C:attention}individual{} Joker bonus by {C:chips}+#2#{} Chips",
					"for every {C:attention}unique Voucher{} redeemed.",
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
					"Balances",
					"{C:chips}Chips{} and {C:mult}Mult{}",
				}
			},
			j_toga_jokersrb2kart = {
				name = 'Karting Joker',
				text = {
					"Gains {X:mult,C:white}XMult{} when",
					"performing {C:attention}certain actions{}.",
					"{C:red,s:0.8}Self debuffs if {X:mult,C:white,s:0.8}XMult{C:red,s:0.8} goes below {X:mult,C:white,s:0.8}X1{}{C:red,s:0.8}.{}",
					"{C:inactive}(Currently {}{X:mult,C:white}X#1#{}{C:inactive}){}",
					"{C:inactive,s:0.7}I am literally a racer, what's your excuse?{}"
				}
			},
			j_toga_whatisthis = {
				name = '65 52 72 6F 52',
				text = {
					-- "{X:dark_edition,C:white}???^^#1#{}"
					"Held {C:attention}Consumables{} give",
					"{X:dark_edition,C:white}^^#1#{} Mult each.",
					"{C:inactive,s:0.8}What is this?!{}"
				}
			},
			j_toga_quacksoft = {
				name = 'Duck?',
				text = {
					--"{X:dark_edition,C:white}Quack^#1#{}"
					"{X:dark_edition,C:white}^0.01{} Chips for each",
					"remaining card in the {C:attention}deck{}",
					"{C:inactive,s:0.8}(Currently {}{X:dark_edition,C:white,s:0.8}^#2#{} {C:inactive,s:0.8}Chips){}"
				}
			},
			j_toga_winupdate = {
				name = 'Joker Update',
				text = {
					"{C:attention}Numerical{} values of a random Joker",
					"are increased by {C:attention}#1#%{} when a card",
					"is {C:money}sold{} while active.",
					"{s:0.9}Becomes active after defeating a {C:attention,s:0.9}Blind{s:0.9}.{}",
					"{C:inactive}#2#{}",
					"{C:inactive,s:0.8}Cannot affect self or copies of self.{}"
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
					"When a {C:attention}playing card{} is destroyed, increase",
					"{X:chips,C:white}XChips{} by {X:chips,C:white}X#1#{} or {X:chips,C:white}X#3#{} if destroyed",
					"card is {C:attention}enhanced{}."
				}
			},
			j_toga_clippit = {
				name = 'Clippit',
				text = {
					"Retrigger all card",
					"{C:attention}held in hand{}",
					"abilities {C:attention}#1#{} times."
					--"{C:attention,s:0.9}Warning: {C:legendary,s:0.9}this Joker is slightly janky.{}",
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
					"{C:inactive}(Currently {}{C:chips}+#1#{}{C:inactive}){}"
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
				}
			},
			j_toga_pso2ironwill = {
				name = 'Skill: Iron Will',
				text = {
					"When ready and if you have at least {C:money}$1{},",
					"lose all held {C:money}money{}, prevents death and",
					"becomes {C:attention}inactive{}. Recharges after",
					"defeating a {C:attention}Boss Blind{}.",
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
					"{C:green}#3# in 3{} chance to {C:attention}rescore{}",
                    "a random scoring card.",
					"For every {C:money}$#1#{} held,",
					"try to {C:attention}rescore{} again.",
					"{C:inactive,s:0.8}Currently #2# attempts.{}",
				}
			},
			j_toga_heartyspades = {
				name = 'Hearty Spades',
				text = {
					"{C:hearts}Hearts{} and {C:spades}Spades{}",
					"count as the same suit"
				}
			},
			j_toga_rover = {
				name = 'Rover',
				text = {
					"Each card in the {C:attention}deck{} has a",
					"{C:green}#1# in #2#{} chance to be {C:attention}scored{}",
					"by this Joker"
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
			j_toga_michaelrosen = {
				name = 'Michael Rosen',
				text = {
					"{C:attention}Each effect{} has a {C:green}#1# in #2#{} chance",
					"to be given by cards {C:attention}held in hand{}.",
					"{C:inactive,s:0.8}*click* Nice.{}"
				}
			},
        },
        Enhanced = {
            -- oops, nothing!
        },
        Tarot = {
            -- oops, nothing!
        },
        Spectral = {
			c_toga_selfpropelledbomb = {
				name = "Self-Propelled Bomb",
				text = {
					"Destroys up to #1# cards",
					"in the {C:attention}deck{}.",
					"If sold or destroyed, {C:green}#3# in #2#{}",
					"chance to trigger anyway.",
				}
			},
        },
        Packet = {
            -- oops, nothing!
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
			tag_toga_controlexe = {
				name = "Settings Tag",
                text = {
                    "Applies a random {C:dark_edition}edition{}",
                    "to a random {C:attention}Joker{}",
					"{C:inactive,s:0.8}Will replace current edition{}",
					"{C:inactive,s:0.8}if one is present.{}"
                },
			},
			tag_toga_thelegend = {
				name = "Dragon Tag",
                text = {
                    "Shop has a",
                    "{C:dark_edition}Legendary{} Joker",
                },
			},
        },
        Sleeve = {
			-- oops, nothing!
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
                    "Doubles all {C:attention}listed{} {E:1,C:green}probabilities{}",
					"for the rest of the run",
					"{C:inactive}(ex: {}{C:green}1 in 3{}{C:inactive} -> {}{C:green}2 in 3{}{C:inactive}){}"
                },
            },
			v_toga_hardwarewizardxp = {
                name = "Hardware Wizard (XP)",
                text = {
                    "Doubles all {C:attention}listed{} {E:1,C:green}probabilities{}",
					"for the rest of the run again",
					"{C:inactive}(ex: {}{C:green}2 in 3{}{C:inactive} -> {}{C:green}4 in 3{}{C:inactive}){}"
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
					"{C:red}-#2#{} {C:attention}Joker{} slot",
                    "Right most {C:attention}held in hand{}",
					"cards give {X:dark_edition,C:white}^#1#{} Chips",
					"this run"
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
					-- "Joker and Consumable {C:attention}slots{}, as well",
					-- "as {C:attention}hand size{} and {C:attention}card selection limit{}",
					-- "are set to their {E:1,C:attention}calculated average{}.",
					"Even the scales.",
					"{C:inactive,s:0.8}Use wisely.{}"
                },
            },
		},
        Other = {
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
					"{C:attention}#2#{} random Jokers",
				},
			},
			toga_clippyorigin = {
                name = "Clippit?",
                text = {
                    "That's his original",
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
					"of currently accumulated {X:mult,C:white}XMult{}."
                },
			},
			toga_useraccountsinfo = {
				name = "Formula",
                text = {
                    "({C:attention}Joker slots{} + {C:attention}Consumable{} slots",
					"+ {C:blue}hands{} left + {C:red}discards{} left) / 4"
                },
			},
			toga_roseneffects = {
				name = "Possible effects:",
                text = {
                    "{C:money}$#1#{}, {X:chips,C:white}X#2#{} Chips, {X:mult,C:white}X#3#{} Mult"
                },
			},
			toga_rosentalismanextra = {
				name = "With Talisman installed",
                text = {
                    "{X:dark_edition,C:white}^#1#{} Chips, {X:dark_edition,C:white}^^#2#{} Chips, {X:dark_edition,C:white}^^^#3#{} Chips",
					"{X:dark_edition,C:white}^#4#{} Mult, {X:dark_edition,C:white}^^#5#{} Mult, {X:dark_edition,C:white}^^^#6#{} Mult",
					"{C:inactive,s:0.7}(10x, 20x and 40x less likely to be rolled respectively.){}",
                },
				-- text = {
					-- "{E:1,C:dark_edition,s:4}:3"
				-- },
			},
			toga_scales1 = {
				name = "Averages:",
                text = {
                    "Joker & Consumable {C:attention}slots{},",
					"{C:attention}hand size{} and {C:attention}card selection limit{}."
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
                    "{C:blue}Hands{} and {C:red}discards{}."
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
			toga_kartouch = "Ouch!",
			toga_karteliminated = "Eliminated!",
			toga_pagefileuse = "Swapped!",
			toga_active = "Active!",
			toga_inactive = "Inactive.",
			toga_updated = "Update!",
			toga_updateready = "Ready!",
			toga_pso2ironwillready = "Ready!",
			toga_pso2ironwillproc = "Procced!",
			toga_pso2ironwillrecharge = "Recharging...",
			toga_pso2ironwillsave = "Iron Will was triggered.",
			toga_systemrestore1 = "Duplicated!",
			-- toga_recyclebinclean = "Trashing...",
			toga_userlocked = "Locked!",
			toga_userunlocked = "Unlocked!",
			toga_spbavoidfail = "Hit!",
			toga_spbavoidsuccess = "Safe!",
			toga_bonusapply = "Bonus!",
			toga_anviltrigger = "Hit it!",
			toga_32bits = "32-bit!",
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
        },
        labels = {
			-- oops, nothing!
        },
        v_dictionary = {
			toga_Echip = {"^#1# Chips"},
			toga_EEchip = {"^^#1# Chips"},
			toga_EEEchip = {"^^^#1# Chips"},
			toga_Emult = {"^#1# Mult"},
			toga_EEmult = {"^^#1# Mult"},
			toga_EEEmult = {"^^^#1# Mult"},
        }
    }
}
