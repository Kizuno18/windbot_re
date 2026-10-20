init start
	-- local SCRIPT_VERSION = '1.0.0'
	
    local weapons = {
       train = {id = 'dagger', mode = {'defensive', 'stand'}}, --the weapon you want to use to train
       bloodhit = {id = 'serpent sword', mode = {'defensive', 'stand'}, hittime = {15000, 25000}}, --the weapon you want to use to deal a small hit to the train monster when you are a long time without deal a hit, by default from 15 seconds to 25 seconds (randomized)
       semistrong = {id = 'magic sword', mode = {'offensive', 'stand'}, monsters = {'Troll', 'Rotworm', 'Wolf'}}, -- the weapon you want to use to kill these monsters on the monsters table
       strong = {id = 'magic sword', mode = {'offensive', 'stand'}}, -- the weapon you want to use to kill any other monster that appears on your screen and try to kill you, or you want to use when you are in danger
                    } 
    local monstersetup = {name = 'Gargoyle', minimumhp = {40, 50}} -- minimum hp is the HP% to stop attacking the training monster, it's randomized, in the example it's from 30 to 40
    local trainpos = {12345, 54321, 7} --this is the location where you want to train, so the bot will kill a monster that appears on the screen and then get back to this position
    local getbacktotrainpos = true --set it to false if you don't want to get back to your train position
    local safekill = {hppc = 40, dmg = 300, food = 2, logout = false} -- it will kill the gargoyles if it's hitting more than 60 or you have less than 40% of HP or you have less than 2 foods, it will also logout after killing everything
    --setup end, dont change things below
    monstersetup.name = monstersetup.name:capitalizeall()
    local killeverything = false
    local trainnamelower = monstersetup.name:lower()
    if not getbacktotrainpos or math.abs(trainpos[1]-$posx) > 10 or math.abs(trainpos[2]-$posy) > 8 or $posz-trainpos[3] ~= 0 then
        trainpos = nil
    end
    for i,j in pairs(weapons) do
        weapons[i].id = itemid(weapons[i].id)
    end
    local curpos, timepos
    local lasthittime = $timems+math.random(unpack(weapons.bloodhit.hittime))
    local trainhppc = math.random(unpack(monstersetup.minimumhp))
init end
 
auto(1500,2500)
local monsters = {training = {}, others = {}}
foreach creature m 'ms' do
    if m.name == monstersetup.name then
        table.insertsorted(monsters.training,m,{{'dist', 'asc'}, {'hppc','desc'}})
    elseif m.lastattacked < 3000 then
        table.insertsorted(monsters.others,m,{{'dist', 'asc'}, {'hppc','asc'}})
    end
end
while monsters.training[3] do
    if monsters.training[3].dist <= 1 then
        table.insertsorted(monsters.others, monsters.training[3],{{'dist', 'asc'}, {'hppc','asc'}})
    end
    table.remove(monsters.training, 3)
end
if not killeverything then
    if $hppc < safekill.hppc or foodcount() < safekill.food then
        killeverything = true
    else
        foreach newmessage m do
            if m.type == MSG_STATUSLOG then
                local temp = m.content:attackmsg()
                if temp.dealer.name == trainnamelower and temp.target.name == $name and temp.dmg > safekill.dmg then
                    killeverything = true
                end
                if temp.dealer.name == $name then
                    lasthittime = $timems+math.random(unpack(weapons.bloodhit.hittime))
                end
            end
        end
    end
elseif safekill.logout and not $battlesigned then
    logout() waitping()
    closeclient()
    os.exit()
end
local toattack, waitingheal
local temp
if #monsters.others > 0 then
    for i,j in ipairs(monsters.others) do
        if j.dist <= 1 or iscreaturereachable(j) then
            toattack = j
            temp = 'strong'
            if table.find(weapons.semistrong.monsters, j.name:lower()) then
                temp = 'semistrong'
            end
            listas('Killing a danger monster')
            break
        end
    end
end
if not toattack and #monsters.training > 0 then
    if not killeverything then
        if monsters.training[1].hppc > trainhppc then
            toattack = monsters.training[1]
            if lasthittime > $timems then
                temp = 'train'
            else
                temp = 'bloodhit'
            end
            if not trainpos and getbacktotrainpos then
                curpos = curpos or {$posx, $posy, $posz}
                if curpos[1] == $posx and curpos[2] == $posy and curpos[3] == $posz then
                    timepos = timepos or $timems
                    if $timems-timepos > 60000 then
                        trainpos = curpos
                    end
                else
                    curpos = nil
                end
            end
            listas('Training with a '..trainnamelower)
        else
            listas('Waiting for the '..trainnamelower..' to heal his life up')
            waitingheal = true
        end
    else
        for i,j in ipairs(monsters.training) do
            if j.dist <= 1 or iscreaturereachable(j) then
                toattack = j
                temp = 'strong'
                listas('Killing the '..trainnamelower..', as you are in danger')
                break
            end
        end
    end
end
if $attacked.name == monstersetup.name and $attacked.hppc < trainhppc then
    stopattack()
end
if toattack then
    setattackmode(unpack(weapons[temp].mode))
    for i=1, 5 do
        if $rhand.id ~= weapons[temp].id then
            equipitem(weapons[temp].id, 'rhand', 'backpack', 100) waitping()
        end
    end
    if $attacked ~= toattack then attack(toattack) trainhppc = math.random(unpack(monstersetup.minimumhp)) end
    if temp ~= 'train' and temp ~= 'bloodhit' then
        local time = $timems
        while $attacked.hppc > 0 and $timems-time < 20000 do
            pausewalking(1000)
            wait(500)
        end
        if $timems-time > 20000 then
            playsoundflash('playeronscreen.wav')
        end
    elseif trainpos and $posz == trainpos[3] and (trainpos[1] ~= $posx or trainpos[2] ~= $posy) then
        moveto(unpack(trainpos))
    end
elseif not waitingheal then
    listas('Waiting for a '..trainnamelower)
end