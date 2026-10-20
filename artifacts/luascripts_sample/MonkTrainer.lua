init start
	-- local SCRIPT_VERSION = '1.0.0'
	
    local monster = {dist = 1, hptostop = 30, hptoattack = 80, name = 'Monk'}
    local weapons = {
                        train = {id = 'dagger', mode = {'defensive', 'stand'}}, -- this is the weapon you want to use while you train with the monk
                        bloodhit = {id = 'dagger', mode = {'defensive', 'stand'}, hittime = {15000, 25000}}, -- this is the weapon you want to use if you haven't dealed any hit to the monk in the last 15-25 seconds (default time)
                    }
    --dont change things below
    local lasthittime = $timems+math.random(unpack(weapons.bloodhit.hittime))
    for i,j in pairs(weapons) do
        weapons[i].id = itemid(weapons[i].id)
    end
init end
 
auto(1500,2500)
listas("Monk Trainer Enabled.")
foreach newmessage m do
    if m.type == MSG_STATUSLOG then
        if m.content:attackmsg().dealer.name == $name then
            lasthittime = $timems+math.random(unpack(weapons.bloodhit.hittime))
        end
    end
end
local highest,toattack = 0
if not toattack then
    foreach creature m 'ms' do
        if m.hppc > highest and m.name == monster.name and m.dist <= monster.dist and m.hppc > monster.hptostop and m.isshootable then
            highest = m.hppc
            toattack = m
        end
    end
end
if toattack then
    local temp = 'train'
    if $timems > lasthittime then
        temp = 'bloodhit'
    end
    setattackmode(unpack(weapons[temp].mode))
    for i=1,5 do
        if $rhand.id ~= weapons[temp].id then
            equipitem(weapons[temp].id, 'rhand', 'backpack', 100) waitping()
        end
    end
    if ($attacked.hppc == 0 and toattack.hppc >= monster.hptoattack) or (($attacked.hppc <= monster.hptostop or $attacked.dist > monster.dist or not $attacked.isshootable) and $attacked.name == monster.name) then
        if $attacked ~= toattack then attack(toattack) wait(500,1000) end
    end
elseif $attacked.id ~= 0 then
    stopattack()
end