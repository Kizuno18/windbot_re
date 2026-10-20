init start
	-- local SCRIPT_VERSION = '1.0.0'
	
	local waterloots = {281, 282, 3026, 3029, 3032, 9303}
init end
auto(200)

--fish only if there are no bodies to be looted on the screen and you're not currently targeting anything
if $lootsaround == 0 and $targetingtarget.hppc == 0 then
	--count how many of each item you have currently
	local count = {}
	for index,id in ipairs(waterloots) do
		count[index] = itemcount(id)
	end
	
	if fishspots(9582) > 0 then
		fish(9582)
		wait(800) --if fished a body, it gets here... wait 1 second, to give time for the item to arrive in your backpack
			
		--make a new count, and compare the new count with the previous values
		for index,id in ipairs(waterloots) do
			local newcount = itemcount(id)
			if (newcount > count[index]) then
				--if the value changed, increase the amount looted on loot counter
				increaseamountlooted(id, newcount-count[index])
			end
		end
	else
		--pauses the walker if there are any water elementals on the screen
		while fishspots(4037) > 0 do
			pausewalking(500)
			wait(300)
		end
		pausewalking(0)
	end
end