sendInfoMessage("Initializing OreDict...", "TOGAPack")

-- Initialize recipe table...
togabalatro.validsmeltrecipes = {}

-- Initialize our "OreDictionary".
togabalatro.oredict = {}

-- Vanilla...
togabalatro.oredict.steel = {'m_steel'}
togabalatro.oredict.gold = {'m_gold'}
togabalatro.oredict.stone = {'m_stone'}

-- Even these also count for OreDictionary.
togabalatro.oredict.bonus = {'m_bonus'}
togabalatro.oredict.mult = {'m_mult'}
togabalatro.oredict.wild = {'m_wild'}
togabalatro.oredict.glass = {'m_glass'}
togabalatro.oredict.lucky = {'m_lucky'}

-- Populate modded stuff...
togabalatro.oredict.notification = {'m_toga_notification'}
togabalatro.oredict.sms = {'m_toga_sms'}
togabalatro.oredict.copper = {'m_toga_copper'}
togabalatro.oredict.tin = {'m_toga_tin'}
togabalatro.oredict.iron = {'m_toga_iron'}
togabalatro.oredict.coalcoke = {'m_toga_coalcoke'}
togabalatro.oredict.silver = {'m_toga_silver'}
togabalatro.oredict.osmium = {'m_toga_osmium'}
togabalatro.oredict.electrum = {'m_toga_electrum'}
togabalatro.oredict.bronze = {'m_toga_bronze'}
togabalatro.oredict.redstone = {'m_toga_redstone'}
togabalatro.oredict.signalum = {'m_toga_signalum'}
togabalatro.oredict.nickel = {'m_toga_nickel'}
togabalatro.oredict.invar = {'m_toga_invar'}
togabalatro.oredict.glowstone = {'m_toga_glowstone'}
togabalatro.oredict.lumium = {'m_toga_lumium'}
togabalatro.oredict.chocolate = {'m_toga_chocolate'}
togabalatro.oredict.constantan = {'m_toga_constantan'}
togabalatro.oredict.lead = {'m_toga_lead'}
togabalatro.oredict.zinc = {'m_toga_zinc'}
togabalatro.oredict.brass = {'m_toga_brass'}
togabalatro.oredict.enderium = {'m_toga_enderium'}
togabalatro.oredict.platinum = {'m_toga_platinum'}
togabalatro.oredict.conductivealloy = {'m_toga_conductivealloy'}
togabalatro.oredict.energeticalloy = {'m_toga_energeticalloy'}
togabalatro.oredict.montus = {'m_toga_montus'}
togabalatro.oredict.cobalt = {'m_toga_cobalt'}
togabalatro.oredict.ardite = {'m_toga_ardite'}
togabalatro.oredict.manyullyn = {'m_toga_manyullyn'}

-- Set up a global pool of 'minerals' in our OreDictionary.
togabalatro.oredict.minerals = {
	'm_gold', 'm_toga_coalcoke', 'm_toga_iron', 'm_toga_copper', 'm_toga_tin', 'm_toga_silver', 'm_toga_osmium', 'm_toga_redstone',
	'm_toga_nickel', 'm_toga_glowstone', 'm_toga_lead', 'm_toga_zinc', 'm_toga_platinum', 'm_toga_cobalt'
}
-- ...and one for alloys.
togabalatro.oredict.alloys = {
	'm_toga_montus', 'm_toga_electrum', 'm_toga_bronze', 'm_toga_signalum', 'm_toga_invar', 'm_toga_lumium', 'm_toga_refinedglowstone',
	'm_toga_constantan', 'm_toga_brass', 'm_toga_enderium', 'm_toga_conductivealloy', 'm_toga_energeticalloy', 'm_toga_manyullyn'
}

togabalatro.is_mineral = function(card, montus)
	if not card then return false end
	for k, v in pairs(togabalatro.oredict.minerals) do
		if v and SMODS.has_enhancement(card, v) then return true end
	end
	if montus then
		for k, v in pairs({ 'm_bonus', 'm_mult' }) do
			if v and SMODS.has_enhancement(card, v) then return true end
		end
	end
	return false
end

togabalatro.is_alloy = function(card)
	if not card then return false end
	for k, v in pairs(togabalatro.oredict.alloys) do
		if v and SMODS.has_enhancement(card, v) then return true end
	end
	return false
end

togabalatro.has_mineral = function(montus)
	if G.playing_cards then
		for i = 1, #G.playing_cards do
			if togabalatro.is_mineral(G.playing_cards[i], montus) then return true end
		end
	end
	return false
end

togabalatro.has_alloy = function()
	if G.playing_cards then
		for i = 1, #G.playing_cards do
			if togabalatro.is_alloy(G.playing_cards[i]) then return true end
		end
	end
	return false
end

togabalatro.add_to_oredict = function(key, material, quiet)
	quiet = quiet or false
	if not (key or material) then sendErrorMessage("Key or material not defined: ["..tostring(key).."] ["..tostring(material).."]", "TOGAPack - OreDictionary"); return end
	if type(key) ~= 'string' then sendErrorMessage("Key is not a string.", "TOGAPack - OreDictionary"); return end
	if type(material) ~= 'string' then sendErrorMessage("Material is not a string.", "TOGAPack - OreDictionary"); return end
	key, material = string.lower(key), string.lower(material)
	if not togabalatro.oredict[material] then
		if not quiet then sendInfoMessage("Registering new '"..material.."' type...", "TOGAPack - OreDictionary") end
		togabalatro.oredict[material] = {}
	end
	if not quiet then sendInfoMessage("Adding '"..material.."' entry: "..key, "TOGAPack - OreDictionary") end
	
	table.insert(togabalatro.oredict[material], key)
end

-- Check if card matches specific OreDictionary entries...
togabalatro.oredictcheck = function(card, pool)
	if not (card or pool) then return end
	if type(pool) == 'string' then pool = togabalatro.oredict[pool] end
	if type(pool) ~= 'table' then return end
	for i, v in ipairs(pool) do
		if type(v) == 'string' and SMODS.has_enhancement(card, v) then return true end
	end
end