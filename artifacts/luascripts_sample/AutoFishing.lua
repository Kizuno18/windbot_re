init start
	-- local SCRIPT_VERSION = '1.0.1'

	local fishwithnoworms = false
	local maxfish = {from = 5, to = 10}
	maxfish.current = math.random(maxfish.from, maxfish.to)
init end

auto(400,600) listas('dontlist')
if $cap > itemweight('fish') then
	if not fishwithnoworms and itemcount('worms') == 0 then
		listas('Please, open the backpack containing worms')
	elseif itemcount('fish') <= maxfish.current then
		fish(30)
		maxfish.current = math.random(maxfish.from, maxfish.to)
	end
end