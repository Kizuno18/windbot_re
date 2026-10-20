init start
	-- local SCRIPT_VERSION = '1.0.0'
	
    local trainname = 'Slime'
    local amount = 1 -- this is the amount of mother slimes you want to use
    local dist = 1 -- it will only consider slimes in this distance range. Useful for paladins, lets say you are training with small stones, so you should set this distance to 3.
    local weapons = {
       train = {id = 'dagger', mode = {'defensive', 'stand'}}, -- this is the weapon you want to use while you train with the slime
       bloodhit = {id = 'dagger', mode = {'defensive', 'stand'}, hittime = {15000, 25000}}, -- this is the weapon you want to use to deal a bloodhit when you are more than 15-25 (default, you may change) seconds without dealing any damage
       strong = {id = 'dagger', mode = {'defensive', 'stand'}},
                    }
    local killmother = {hppc = 40, dmg = 60, food = 2, logout = false} -- it will kill the mother if you have 40% of HP or the slimes are dealing more than 50 or your food amount is lower than 3. It will also logout after killing the mother
    local trainpos = {12345, 54321, 7} -- this is the location where you want to stay to train
    local getbacktotrainpos = true -- set it to false if you don't want the bot to send you back to your train position if you got moved
    --dont change things below
	
    local mothers = {}
    local danger,trainstarted = false,false
    local trainnamelower = trainname:lower()
    for i,j in pairs(weapons) do
        weapons[i].id = itemid(weapons[i].id)
    end
    if not getbacktotrainpos or math.abs(trainpos[1]-$posx) > 10 or math.abs(trainpos[2]-$posy) > 8 or $posz-trainpos[3] ~= 0 then
        trainpos = nil
    end
    local lasthittime = $timems+math.random(unpack(weapons.bloodhit.hittime))
    local curpos, timepos
init end
auto(400,700)
if #mothers < amount and not danger then
    listas('Follow the mother '..trainnamelower..' to start training')
    if $followed.id > 0 and not table.find(mothers, $followed) then
        table.insert(mothers, $followed)
    end
    if trainstarted then
        playsoundflash('monster.wav')
    end
else
    trainstarted = true
    local i = 1
    while (i <= #mothers) do
        if (mothers[i].hppc == 0) then
            table.remove(mothers, i)
        else
            i = i+1
        end
    end
    local others = {}
    local slimesclose = {}
    foreach creature m 'ms' do
        if not table.find(mothers, m) then
            if m.name == trainname then
                if m.dist <= dist then
                    table.insertsorted(slimesclose, m, {{'hppc', 'asc'}})
                end
            elseif m.lastattacked <= 3000 then
                table.insertsorted(others, m, {{'dist', 'asc'}, {'hppc', 'asc'}})
            end
        end
    end
    local toattack, temp
    if danger and #mothers > 0 then
        listas('Killing the mother '..trainnamelower..', as you are in danger')
        toattack = mothers[1]
        temp = 'strong'
    elseif #others > 0 or maround(1) >= 3 then
        for i,j in ipairs(others) do
            if j.dist <= 1 or iscreaturereachable(j) then
                toattack = j
                temp = 'strong'
                break
            end
        end
        if not toattack and maround(1) >= 3 then
            for i,j in ipairs(slimesclose) do
                if j.dist <= 1 or iscreaturereachable(j) then
                    toattack = j
                    temp = 'strong'
                    break
                end
            end
        end
        if not toattack then
            playsoundflash('playeronscreen.wav')
        end
    else
        toattack = slimesclose[1]
        if $timems > lasthittime then
            temp = 'bloodhit'
        else
            temp = 'train'
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
    end
    if toattack then
        setattackmode(unpack(weapons[temp].mode))
        for i=1, 5 do
            if $rhand.id ~= weapons[temp].id then
                equipitem(weapons[temp].id, 'rhand', 'backpack', 100) waitping()
            end
        end
        if $attacked ~= toattack then attack(toattack) end
        if temp == 'strong' then
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
    else
        listas('Waiting for a '..trainnamelower)
    end
end
if not danger then
    if $hppc < killmother.hppc or foodcount() < killmother.food then
        danger = true
    else
        foreach newmessage m do
            if m.type == MSG_STATUSLOG then
                local t = m.content:attackmsg()
                if t.dealer.name:lower() == trainnamelower and t.target.name == $name and t.dmg > killmother.dmg then
                    danger = true
                end
                if t.dealer.name == $name then
                    lasthittime = $timems+math.random(unpack(weapons.bloodhit.hittime))
                end
            end
        end
    end
elseif killmother.logout and not $battlesigned then
    logout() waitping()
    closeclient()
    os.exit()
end