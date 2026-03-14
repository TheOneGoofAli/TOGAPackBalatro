-- Out-of-the-Box crossmod content.
local basecrossmod = {
	next(SMODS.find_mod('Bunco')) and 'bunco.lua',
	next(SMODS.find_mod('MoreFluff')) and 'morefluff.lua',
	next(SMODS.find_mod('ortalab')) and 'ortalab.lua',
	next(SMODS.find_mod('partner')) and Partner_API and 'partners.lua',
	next(SMODS.find_mod('reverse_tarot')) and 'reversetarot.lua',
	next(SMODS.find_mod('RevosVault')) and 'revosvault.lua',
	next(SMODS.find_mod('jammbo')) and 'jambatro.lua',
	next(SMODS.find_mod('pta_saka')) and 'pta.lua',
	next(SMODS.find_mod('sdm0sstuff')) and 'sdm0.lua',
	next(SMODS.find_mod('Yahimod')) and 'yahi.lua',
	next(SMODS.find_mod('CardSleeves')) and CardSleeves and 'sleeve.lua',
	next(SMODS.find_mod('kino')) and 'kino.lua',
	next(SMODS.find_mod('GSPhanta')) and 'phanta.lua',
	next(SMODS.find_mod('aikoyorisshenanigans')) and 'aiko.lua',
	next(SMODS.find_mod('JokerDisplay')) and JokerDisplay and 'jokerdisplay.lua',
	next(SMODS.find_mod('HotPotato')) and HPTN and 'hotpotato.lua',
}

-- If none of these are valid, stop here.
if not next(basecrossmod) then sendInfoMessage("No eligible mods found, aborting...", "TOGAPack"); return end

sendInfoMessage("Loading Cross-Mod content...", "TOGAPack")
for _, file in pairs(basecrossmod) do
	sendDebugMessage("Executing items/crossmod/"..file, "TOGAPack - Crossmod")
	assert(SMODS.load_file("items/crossmod/"..file))()
end