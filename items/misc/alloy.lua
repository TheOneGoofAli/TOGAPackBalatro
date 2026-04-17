sendInfoMessage("Loading Alloy recipes...", "TOGAPack")

-- 1x Iron + 1x Coal Coke (consumed) = 1x Steel (vanilla)
-- ...why would you go this route for Steel?
togabalatro.validsmeltrecipes[#togabalatro.validsmeltrecipes+1] = function(selcards)
	selcards = selcards or {}
	local coalcoke, iron = nil, nil
	for i, v in ipairs(selcards) do
		if togabalatro.oredictcheck(v, togabalatro.oredict.coalcoke) then coalcoke = v end
		if togabalatro.oredictcheck(v, togabalatro.oredict.iron) then iron = v end
	end
	return iron and coalcoke and iron ~= coalcoke, { cards = { iron }, destroycard = { coalcoke }, allcards = { iron, coalcoke } }, 'm_steel', "toga_alloysteel"
end

-- 1x Gold + 1x Silver = 2x Electrum
togabalatro.validsmeltrecipes[#togabalatro.validsmeltrecipes+1] = function(selcards)
	selcards = selcards or {}
	local gold, silver = nil, nil
	for i, v in ipairs(selcards) do
		if togabalatro.oredictcheck(v, togabalatro.oredict.gold) then gold = v end
		if togabalatro.oredictcheck(v, togabalatro.oredict.silver) then silver = v end
	end
	return gold and silver and gold ~= silver, { cards = { gold, silver } }, 'm_toga_electrum', "toga_alloyelectrum"
end

-- 3x Copper + 1x Tin = 4x Bronze
togabalatro.validsmeltrecipes[#togabalatro.validsmeltrecipes+1] = function(selcards)
	selcards = selcards or {}
	local copper1, copper2, copper3, tin = nil, nil, nil, nil
	local copper1ok, copper2ok, copper3ok, tinok = false, false, false, false
	local iter, iterlimit = 0, 100
	for i, v in ipairs(selcards) do
		repeat -- scary jank, but works.
			iter = iter + 1
			if not copper1ok and togabalatro.oredictcheck(v, togabalatro.oredict.copper) then copper1 = v; copper1ok = true; break end
			if not copper2ok and togabalatro.oredictcheck(v, togabalatro.oredict.copper) then copper2 = v; copper2ok = true; break end
			if not copper3ok and togabalatro.oredictcheck(v, togabalatro.oredict.copper) then copper3 = v; copper3ok = true; break end
			if not tinok and togabalatro.oredictcheck(v, togabalatro.oredict.tin) then tin = v; break end
		until (copper1ok and copper2ok and copper3ok and tinok) or iter > iterlimit
	end
	return copper1 and copper2 and copper3 and tin and copper1 ~= tin and copper1 ~= copper2 and copper2 ~= copper3 and copper1 ~= copper3, { cards = { copper1, copper2, copper3, tin } }, 'm_toga_bronze', "toga_alloybronze"
end

-- 3x Copper + 1x Silver + 1 Redstone (consumed) = 4x Signalum
togabalatro.validsmeltrecipes[#togabalatro.validsmeltrecipes+1] = function(selcards)
	selcards = selcards or {}
	local copper1, copper2, copper3, silver, redstone = nil, nil, nil, nil, nil
	local copper1ok, copper2ok, copper3ok, silverok, redstoneok = false, false, false, false, false
	local iter, iterlimit = 0, 100
	for i, v in ipairs(selcards) do
		repeat -- scary jank, but works.
			iter = iter + 1
			if not copper1ok and togabalatro.oredictcheck(v, togabalatro.oredict.copper) then copper1 = v; copper1ok = true; break end
			if not copper2ok and togabalatro.oredictcheck(v, togabalatro.oredict.copper) then copper2 = v; copper2ok = true; break end
			if not copper3ok and togabalatro.oredictcheck(v, togabalatro.oredict.copper) then copper3 = v; copper3ok = true; break end
			if not silverok and togabalatro.oredictcheck(v, togabalatro.oredict.silver) then silver = v; break end
			if not redstoneok and togabalatro.oredictcheck(v, togabalatro.oredict.redstone) then redstone = v; break end
		until (copper1ok and copper2ok and copper3ok and silverok and redstoneok) or iter > iterlimit
	end
	return copper1 and copper2 and copper3 and silver and redstone and copper1 ~= silver and copper1 ~= redstone and copper1 ~= copper2 and copper2 ~= copper3 and copper1 ~= copper3,
		 { cards = { copper1, copper2, copper3, silver }, destroycard = { redstone }, allcards = { copper1, copper2, copper3, silver, redstone } }, 'm_toga_signalum', "toga_alloysignalum"
end

-- 2x Iron + 1x Nickel = 3x Invar
togabalatro.validsmeltrecipes[#togabalatro.validsmeltrecipes+1] = function(selcards)
	selcards = selcards or {}
	local iron1, iron2, nickel = nil, nil, nil
	local iron1ok, iron2ok, nickelok = false, false, false
	local iter, iterlimit = 0, 100
	for i, v in ipairs(selcards) do
		repeat -- scary jank, but works.
			iter = iter + 1
			if not iron1ok and togabalatro.oredictcheck(v, togabalatro.oredict.iron) then iron1 = v; iron1ok = true; break end
			if not iron2ok and togabalatro.oredictcheck(v, togabalatro.oredict.iron) then iron2 = v; iron2ok = true; break end
			if not nickelok and togabalatro.oredictcheck(v, togabalatro.oredict.nickel) then nickel = v; break end
		until (iron1ok and iron2ok and nickelok) or iter > iterlimit
	end
	return iron1 and iron2 and nickel and iron1 ~= nickel and iron1 ~= iron2, { cards = { iron1, iron2, nickel } }, 'm_toga_invar', "toga_alloyinvar"
end

-- 3x Tin + 1x Silver + 1x Glowstone = 4x Lumium
togabalatro.validsmeltrecipes[#togabalatro.validsmeltrecipes+1] = function(selcards)
	selcards = selcards or {}
	local tin1, tin2, tin3, silver, glowstone = nil, nil, nil, nil, nil
	local tin1ok, tin2ok, tin3ok, silverok, glowstoneok = false, false, false, false, false
	local iter, iterlimit = 0, 100
	for i, v in ipairs(selcards) do
		repeat -- scary jank, but works.
			iter = iter + 1
			if not tin1ok and togabalatro.oredictcheck(v, togabalatro.oredict.tin) then tin1 = v; tin1ok = true; break end
			if not tin2ok and togabalatro.oredictcheck(v, togabalatro.oredict.tin) then tin2 = v; tin2ok = true; break end
			if not tin3ok and togabalatro.oredictcheck(v, togabalatro.oredict.tin) then tin3 = v; tin3ok = true; break end
			if not silverok and togabalatro.oredictcheck(v, togabalatro.oredict.silver) then silver = v; break end
			if not glowstoneok and togabalatro.oredictcheck(v, togabalatro.oredict.glowstone) then glowstone = v; break end
		until (tin1ok and tin2ok and tin3ok and silverok and glowstoneok) or iter > iterlimit
	end
	return tin1 and tin2 and tin3 and silver and glowstone and tin1 ~= silver and tin1 ~= glowstone and tin1 ~= tin2 and tin2 ~= tin3 and tin1 ~= tin3,
		 { cards = { tin1, tin2, tin3, silver }, destroycard = { glowstone }, allcards = { tin1, tin2, tin3, silver, glowstone } }, 'm_toga_lumium', "toga_alloylumium"
end

-- 1x Osmium + 1 Glowstone (consumed) = 1x Refined Glowstone
togabalatro.validsmeltrecipes[#togabalatro.validsmeltrecipes+1] = function(selcards)
	selcards = selcards or {}
	local glowstone, osmium = nil, nil
	for i, v in ipairs(selcards) do
		if togabalatro.oredictcheck(v, togabalatro.oredict.glowstone) then glowstone = v end
		if togabalatro.oredictcheck(v, togabalatro.oredict.osmium) then osmium = v end
	end
	return osmium and glowstone and osmium ~= glowstone, { cards = { osmium }, destroycard = { glowstone }, allcards = { osmium, glowstone } }, 'm_toga_refinedglowstone', "toga_alloyrefglowstone"
end

-- 1x Copper + 1x Nickel = 2x Constantan
togabalatro.validsmeltrecipes[#togabalatro.validsmeltrecipes+1] = function(selcards)
	selcards = selcards or {}
	local copper, nickel = nil, nil
	for i, v in ipairs(selcards) do
		if togabalatro.oredictcheck(v, togabalatro.oredict.copper) then copper = v end
		if togabalatro.oredictcheck(v, togabalatro.oredict.nickel) then nickel = v end
	end
	return copper and nickel and copper ~= nickel, { cards = { copper, nickel } }, 'm_toga_constantan', "toga_alloyconstantan"
end

-- 1x Copper + 1x Zinc = 2x Brass
togabalatro.validsmeltrecipes[#togabalatro.validsmeltrecipes+1] = function(selcards)
	selcards = selcards or {}
	local copper, zinc = nil, nil
	for i, v in ipairs(selcards) do
		if togabalatro.oredictcheck(v, togabalatro.oredict.copper) then copper = v end
		if togabalatro.oredictcheck(v, togabalatro.oredict.zinc) then zinc = v end
	end
	return copper and zinc and copper ~= zinc, { cards = { copper, zinc } }, 'm_toga_brass', "toga_alloybrass"
end

-- 3x Lead + 1x Platinum = 4x Enderium (must also hold a Spectral card in Consumeables)
togabalatro.validsmeltrecipes[#togabalatro.validsmeltrecipes+1] = function(selcards)
	local spectral
	for k, v in ipairs((G.consumeables or {}).cards) do
		if v.ability.set == 'Spectral' then spectral = v; break end
	end
	if not spectral then return end
	
	selcards = selcards or {}
	local lead1, lead2, lead3, platinum = nil, nil, nil, nil
	local lead1ok, lead2ok, lead3ok, platinumok = false, false, false, false
	local iter, iterlimit = 0, 100
	for i, v in ipairs(selcards) do
		repeat -- scary jank, but works.
			iter = iter + 1
			if not lead1ok and togabalatro.oredictcheck(v, togabalatro.oredict.lead) then lead1 = v; lead1ok = true; break end
			if not lead2ok and togabalatro.oredictcheck(v, togabalatro.oredict.lead) then lead2 = v; lead2ok = true; break end
			if not lead3ok and togabalatro.oredictcheck(v, togabalatro.oredict.lead) then lead3 = v; lead3ok = true; break end
			if not platinumok and togabalatro.oredictcheck(v, togabalatro.oredict.platinum) then platinum = v; break end
		until (lead1ok and lead2ok and lead3ok and platinumok) or iter > iterlimit
	end
	
	return lead1 and lead2 and lead3 and platinum and spectral and lead1 ~= platinum and lead1 ~= spectral and lead1 ~= lead2 and lead2 ~= lead3 and lead1 ~= lead3,
		 { cards = { lead1, lead2, lead3, platinum }, destroycard = { spectral }, allcards = { lead1, lead2, lead3, platinum, spectral } }, 'm_toga_enderium', "toga_alloyenderium"
end

-- 1x Iron + 1x Copper (consumed) = 1x Conductive Alloy
togabalatro.validsmeltrecipes[#togabalatro.validsmeltrecipes+1] = function(selcards)
	selcards = selcards or {}
	local copper, iron = nil, nil
	for i, v in ipairs(selcards) do
		if togabalatro.oredictcheck(v, togabalatro.oredict.iron) then iron = v end
		if togabalatro.oredictcheck(v, togabalatro.oredict.copper) then copper = v end
	end
	return iron and copper and iron ~= copper, { cards = { iron }, destroycard = { copper }, allcards = { iron, copper } }, 'm_toga_conductivealloy', "toga_alloyconductivealloy"
end

-- 1x Redstone (consumed) + 1x Conductive Alloy + 1x Glowstone (consumed) = 1x Conductive Alloy
togabalatro.validsmeltrecipes[#togabalatro.validsmeltrecipes+1] = function(selcards)
	selcards = selcards or {}
	local redstone, calloy, glowstone = nil, nil, nil
	local redstoneok, calloyok, glowstoneok = false, false, false
	local iter, iterlimit = 0, 100
	for i, v in ipairs(selcards) do
		repeat -- scary jank, but works.
			iter = iter + 1
			if not redstoneok and togabalatro.oredictcheck(v, togabalatro.oredict.redstone) then redstone = v; redstoneok = true; break end
			if not calloyok and togabalatro.oredictcheck(v, togabalatro.oredict.conductivealloy) then calloy = v; calloyok = true; break end
			if not glowstoneok and togabalatro.oredictcheck(v, togabalatro.oredict.glowstone) then glowstone = v; break end
		until (redstoneok and calloyok and glowstoneok) or iter > iterlimit
	end
	return redstone and calloy and glowstone and redstone ~= glowstone and redstone ~= calloy, { cards = { calloy }, destroycard = { redstone, glowstone }, allcards = { redstone, calloy, glowstone } }, 'm_toga_energeticalloy', "toga_alloyenergeticalloy"
end

-- Check recipe.
togabalatro.checkvalidrecipe = function()
	local recipekey, userecipetxt = nil, false
	local cando, cardtable, enhancement, found = false, {}, "", false
	if G.hand and G.hand.highlighted then
		for i = 1, #togabalatro.validsmeltrecipes do
			if found then break end
			
			cando, cardtable, enhancement, recipekey = togabalatro.validsmeltrecipes[i](G.hand.highlighted)
			if cando and cardtable and enhancement and G.P_CENTERS[enhancement] then found = true; userecipetxt = true end
		end
	end
	return cando, found and userecipetxt and recipekey or nil
end

-- Valid recipe text stuff.
togabalatro.currentrecipetxt = {
	"toga_alloysteel", "toga_alloyelectrum", "toga_alloybronze", "toga_alloysignalum", "toga_alloyinvar", "toga_alloylumium", "toga_alloyrefglowstone", "toga_alloyconstantan", "toga_alloybrass", "toga_alloyenderium",
	"toga_alloyconductivealloy", "toga_alloyenergeticalloy"
}