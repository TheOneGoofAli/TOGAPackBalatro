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

function togabalatro.metainit()
	togabalatro.processcounts = togabalatro.processcounts or {}
	if hasinit then
		sendInfoMessage("Process count table is already initialized. Restart the game to reinitialize.", "TOGAPack - Meta Items")
		return
	end
	-- Initialize the process information during load of this mod into a local table. Previously, this was active
	-- in a constant loop, which could cause excessive unfocusing of the game as the system executed the function.
	-- Now, we do it just once here instead.
	local tasktable = {}
	if type(togabalatro.config.AllowMoreMeta) == 'boolean' and togabalatro.config.AllowMoreMeta then
		-- We're given permission, so execute the system-dependant program to get the process list.
		if togabalatro.curos == 'Windows' then tasktable = togabalatro.mlineproc(os.capture('tasklist', true))
		elseif togabalatro.curos == 'UNIX' then tasktable = togabalatro.mlineproc(os.capture('ps -e', true)) end

		-- If we still got nothing, just make the table blank.
		if not tasktable then tasktable = {} end
	else
		sendInfoMessage("Config does not allow gathering of additional system information, skipping.", "TOGAPack - Meta Items")
	end
	
	-- Check for specific process name.
	local function getprocessamount(process)
		process = string.lower(process) or 'whereismysupersuit'
		local count = 0
		for k, v in pairs(tasktable or {}) do
			if string.find(v, process) then count = count + 1 end
		end
		return count
	end
	
	togabalatro.processcounts.chrome = getprocessamount('Chrome')
	togabalatro.processcounts.firefox = getprocessamount('Firefox')

	-- Ensure table is gone.
	tasktable = nil
	hasinit = true
end