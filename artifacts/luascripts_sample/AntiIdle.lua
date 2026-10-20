init start
	-- local SCRIPT_VERSION = '1.0.2'
	local idletime = {from = 180000, to = 600000}

	-- Do not change anything below
	local alldirs = {'n', 'e', 'w', 's'}
	local lastmove = 0
	idletime.current = math.random(idletime.from, idletime.to)
init end

auto(200)

local isidle = ($standtime >= idletime.current and ($timems - lastmove) >= idletime.current)
foreach newmessage m do
	if m.type == MSG_RED and m.content:match('disconnected') then
		isidle = true
	end
end

if $connected and isidle then
	local selfdir = $self.dir

	local dirs = {}
	for _, j in ipairs(alldirs) do
		if j ~= selfdir then
			table.insert(dirs, j)
		end
	end

	turn(dirs[math.random(1, #dirs)])
	turn(selfdir)

	idletime.current = math.random(idletime.from, idletime.to)
	lastmove = $timems
end