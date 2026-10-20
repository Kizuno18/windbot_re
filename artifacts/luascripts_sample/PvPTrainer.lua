init start
	-- local SCRIPT_VERSION = '1.0.4'
	
    local trainplayername = 'Bubble'
    local hptostart = {75,85}
    local hptostop = {35,45}
    local mustbeinparty = false
    local weapons = {
                        train = {id = 'dagger', mode = {'defensive', 'stand'}}, -- this is the weapon you want to use while you train with the monk
                        bloodhit = {id = 'dagger', mode = {'defensive', 'stand'}, hittime = {15000, 25000}}, -- this is the weapon you want to use if you haven't dealed any hit to the monk in the last 15-25 seconds (default time)
                    }
    --dont change things below
    local lasthittime = $timems+math.random(unpack(weapons.bloodhit.hittime))
    for i,j in pairs(weapons) do
        weapons[i].id = itemid(weapons[i].id)
    end
	local hpattack,hpstop = randomize(hptostart),randomize(hptostop)
	local trainplayer = nil
init end
 
auto(100)
if type(trainplayer) == 'userdata' and trainplayer.updated and trainplayer.name == trainplayername then
	if mustbeinparty and trainplayer.party < 3 then
		listas("Player is not on party.")
	elseif not mustbeinparty and $pvpsecurity == 'secure' then
		listas("Adjust your combat settings to attack this player.")
	elseif $pzone then
		listas("You are inside a protection zone.")
	else
	   foreach newmessage m do
		  if m.type == MSG_STATUSLOG then
			 if m.content:attackmsg().dealer.name == $name then
				lasthittime = $timems+math.random(unpack(weapons.bloodhit.hittime))
			 end
		  end
	   end
	   if $attacked == trainplayer then
		  listas('Training with: '..trainplayer.name..' ('..trainplayer.hppc..'%)')
		  if trainplayer.hppc < hpstop then
			 stopattack()
			 hpstart = randomize(hptostart)
		  end
		  
		  local temp = 'train'
		  if lasthittime < $timems then
			 temp = 'bloodhit'
		  end
		  setattackmode(unpack(weapons[temp].mode))
		  for i=1,5 do
			  if $rhand.id ~= weapons[temp].id then
				  equipitem(weapons[temp].id, 'rhand', 'backpack', 100) waitping()
			  end
		  end
	   else
		  if trainplayer.hppc >= hpattack then
			attack(trainplayer)
			hpstop = randomize(hptostop)
		  else
		    listas('Waiting: '..trainplayer.name..' ('..trainplayer.hppc..'%) to get more healthy')
		  end
	   end
	end
else
   local t = findcreature(trainplayername)
   if t then
       trainplayer = t
   else
       listas('Didn\'t find player to train, change the player name in script setup.')
   end
end