init start
	-- local SCRIPT_VERSION = '1.0.1'
	
    local boots = 'boots of haste' -- this is the alternative boots, to equip while you are in pz, or you have enough mana
    local softnumbers = {consider = 'mppc', equip = {65,75}, unequip = {85,95}} -- check this, it's randomized, in this example it will equip soft if you have less than 40~60% of MP, and equip soft boots if you have more than 80~90% of MP.
    local alertifnosoft = true -- this will play an alert if a soft wasn't found on your backpacks.
    local soundfile = 'monster.wav' -- this is the sound you want to use play when you have no soft
    -- dont change anything below.
	
    local soft = {id = 6529, use = 3549, worn = 6530}
    local firewalker = {id = 9019, use = 9018, worn = 9020, enchantid = 676}
    boots = itemid(boots)
    if boots == 6529 then
        boots = {id = boots, use = 3549, worn = 6530}
    elseif boots == 9019 then
        boots = {id = boots, use = 9018, worn = 9020}
    else
        boots = {id = boots, use = boots, worn = boots}
    end
    local ntype,nequip,nunequip = softnumbers.consider:lower(), math.random(unpack(softnumbers.equip)), math.random(unpack(softnumbers.unequip))
    local warningmsgtime = 0
    if getsetting('Settings/MouseMode') == 'Simulate Mouse' then
        warningmsgtime = $timems+20000
    end

    setpriority(100, 0, 1000, 10000, false)
init end
 
auto(300,700)
if $timems < warningmsgtime then
    listas('BE CAREFUL!! If you do a left click on your screen while the script is trying to move the boots you may lose your item!')
else
    listas('Soft Boots Changer')
end

local cur = {mppc = $mppc, hppc = $hppc, mp = $mp, hp = $hp}
if $feet.id == soft.use then
    if $pzone or cur[ntype] > nunequip then
        if itemcount(boots.id, 'backpack') > 0 then
            equipitem(boots.id, 'feet', 'backpack', 100) waitping()
        else
            moveitems(soft.use, 'backpack', 'feet', 100) waitping()
        end
        nunequip = math.random(unpack(softnumbers.unequip))
    end
elseif $feet.id == soft.worn or $feet.id == 0 then
    if cur[ntype] < nequip and not $pzone and itemcount(soft.id, 'backpack') > 0 then
        equipitem(soft.id, 'feet', 'backpack', 100) waitping()
        nequip = math.random(unpack(softnumbers.equip))
    else
        if itemcount(boots.id) > 0 then
            equipitem(boots.id, 'feet', 'backpack', 100) waitping()
        elseif $feet.id > 0 then
            moveitems(soft.worn, 'backpack', 'feet', 100) waitping()
        end
        nunequip = math.random(unpack(softnumbers.unequip))
    end
elseif $feet.id == boots.id then
    if cur[ntype] < nequip and not $pzone and itemcount(soft.id, 'backpack') > 0 then
        equipitem(soft.id, 'feet', 'backpack', 100) waitping()
        nequip = math.random(unpack(softnumbers.equip))
    end
end

if alertifnosoft and $feet.id ~= soft.use and itemcount(soft.id) == 0 and itemcount(soft.worn) > 0 then
    playsoundflash(soundfile) 
end