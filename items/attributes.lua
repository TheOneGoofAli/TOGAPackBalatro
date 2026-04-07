sendInfoMessage("Loading Attributes...", "TOGAPack")

local toga_attrib = {
	{ 'meta', {}, {} },
	{ 'shop', {}, {} },
	{ 'booster', {}, {} },
	{ 'custom_score_card', {}, {} },
	{ 'rarity', {}, {} },
	{ 'skip', {}, {} },
	{ 'non_face', {}, {} },
	{ 'level_up', {}, {} },
	{ 'modify_joker', {}, {} },
	{ 'prevent_debuff', {}, {} },
	{ 'chipoperatormod', {}, {} },
	{ 'multoperatormod', {}, {} },
	{ 'voucher', {}, { 'vouchers' } },
	{ 'upgrade_poker_hand', {}, { 'level_up' } },
	{ 'blind_requirement', {}, { 'blind_requirements' } },
	{ 'on_debuff', {}, {} },
	{ 'on_destroy', {}, {} },
	{ 'echips', {}, { 'e_chips' } },
	{ 'eechips', {}, { 'ee_chips' } },
	{ 'eeechips', {}, { 'eee_chips' } },
	{ 'emult', {}, { 'e_mult' } },
	{ 'eemult', {}, { 'ee_mult' } },
	{ 'eeemult', {}, { 'eee_mult' } },
}

for k, v in ipairs(toga_attrib) do
	local key, keys, alias = v[1], v[2], v[3]
	if type(key) == 'string' then
		sendDebugMessage("Registering "..key, "TOGAPack")
		SMODS.Attribute({
			key = key,
			keys = type(keys) == 'table' and next(keys) and keys or nil,
			alias = type(alias) == 'alias' and next(alias) and alias or nil
		})
	else
		error("TOGA - Invalid input for registering attribute.")
	end
end