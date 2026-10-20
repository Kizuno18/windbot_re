# Lua API catalog (WindBot classic)

Source of names/signatures: public community docs repo [rmobis/WindBot-Docs](https://github.com/rmobis/WindBot-Docs) (linked, not copied; descriptions omitted). `in binary` = the bare identifier appears as a string in WindBot 2.8.30 `code$MyConst.exe` (registration tables survive outside VMProtect), i.e. statically confirmed as natively exported.

**801 documented entries; 785 confirmed in binary (98%).** Tibia-11 subtree excluded.


## events/character

| entry | signature | in binary |
|---|---|---|
| `cast` | `cast(message)` | yes |
| `closeclient` | `closeclient(dontshowalert)` | yes |
| `connect` | `connect(account, password, charname)` | yes |
| `dismount` | `dismount()` | yes |
| `logout` | `logout()` | yes |
| `mount` | `mount()` | yes |
| `move` | `move(direction)` | yes |
| `moveto` | `moveto(x, y, z)` | yes |
| `npcsay` | `npcsay(message)` | yes |
| `reachlocation` | `reachlocation(x, y, z, dist)` | yes |
| `reconnect` | `reconnect(usectrlg); reconnect(charname, usectrlg)` | yes |
| `say` | `say(channel, message)` | yes |
| `setattackmode` | `setattackmode(attackmode, chasemode)` | yes |
| `setpvpmode` | `setpvpmode(security, pvpmode)` | yes |
| `turn` | `turn(direction)` | yes |
| `xlog` | `xlog(dontshowalert)` | yes |

## events/creature

| entry | signature | in binary |
|---|---|---|
| `attack` | `attack(creaturename); attack(creatureid)` | yes |
| `follow` | `follow(creaturename); follow(creatureid)` | yes |
| `reachcreature` | `reachcreature(creaturename, dist); reachcreature(creatureid, dist)` | yes |

## events/item

| entry | signature | in binary |
|---|---|---|
| `browsefield` | `browsefield(x, y, z)` | — |
| `buyitems` | `buyitems(itemname, count); buyitems(itemid, count)` | yes |
| `buyitemsmarket` | `buyitemsmarket(itemname, price, amount, createoffer, offeranonymous); buyitemsmarket(itemname, price, amount, character)` | yes |
| `changepage` | `changepage(containername, pagenum); changepage(containerid, pagenum)` | yes |
| `closewindows` | `closewindows(locationname, onlyone)` | yes |
| `contextmenu` | `contextmenu(menuitem, itemid, locationfrom, index); contextmenu(menuitem, creaturepointer, usebattlelist)` | yes |
| `crosshair` | `crosshair(itemid, liquidtype)` | yes |
| `eatfood` | `eatfood()` | yes |
| `equipitem` | `equipitem(itemname, equipslot, locationfrom, count); equipitem(itemid, equipslot, locationfrom, count)` | yes |
| `higherwindows` | `higherwindows(locationname, onlyone)` | yes |
| `minimizewindows` | `minimizewindows(locationname, onlyone)` | yes |
| `moveitems` | `moveitems(itemname, locationto, locationfrom, count); moveitems(itemid, locationto, locationfrom, count)` | yes |
| `moveitemsonto` | `moveitemsonto(itemname, ontoid, index, locationto, locationfrom, amount); moveitemsonto(itemid, ontoid, index, locationto, locationfrom, amount)` | yes |
| `nextpage` | `nextpage(containername); nextpage(containerid)` | yes |
| `openbattlelist` | `openbattlelist(close)` | yes |
| `openitem` | `openitem(itemname, locationfrom, opennew, index); openitem(itemid, locationfrom, opennew, index)` | yes |
| `previouspage` | `previouspage(containername); previouspage(containerid)` | yes |
| `reachgrounditem` | `reachgrounditem(itemid, dist); reachgrounditem('depot')` | yes |
| `reopenwindows` | `reopenwindows(opentype)` | yes |
| `resizewindows` | `resizewindows(size, locationname, onlyone)` | yes |
| `restorewindows` | `restorewindows(locationname, onlyone)` | yes |
| `sellitems` | `sellitems(itemname, count); sellitems(itemid, count)` | yes |
| `sellitemsmarket` | `sellitemsmarket(itemname, price, amount, createoffer, offeranonymous); sellitemsmarket(itemname, price, amount, character)` | yes |
| `useitem` | `useitem(itemname, locationitem); useitem(itemid, locationitem)` | yes |
| `useitemon` | `useitemon(idused, idusedon, locationusedon, locationused); useitemon(itemusedname, idusedon, locationusedon, locationused)` | yes |
| `useoncreature` | `useoncreature(itemname, creaturepointer); useoncreature(itemid, creaturepointer)` | yes |
| `writetext` | `writetext(itemid, text, locationfrom, index)` | yes |

## functions/access

| entry | signature | in binary |
|---|---|---|
| `creatureinfo` | `creatureinfo(creaturename)` | yes |
| `effectinfo` | `effectinfo(effectid)` | yes |
| `emptycount` | `emptycount(locationname)` | yes |
| `exptolevel` | `exptolevel(level)` | yes |
| `itemcost` | `itemcost(itemname); itemcost(itemid)` | yes |
| `itemcount` | `itemcount(itemid, locationname); itemcount(itemname, locationname)` | yes |
| `itemflags` | `itemflags(itemname)` | yes |
| `itemid` | `itemid(itemname)` | yes |
| `iteminfo` | `iteminfo(itemid); iteminfo(itemname)` | yes |
| `itemname` | `itemname(itemid)` | yes |
| `itemproperty` | `itemproperty(itemname, flagtocheck)` | yes |
| `itemvalue` | `itemvalue(itemname); itemvalue(itemid)` | yes |
| `itemweight` | `itemweight(itemname); itemweight(itemid)` | yes |
| `outfitinfo` | `outfitinfo(outfitid)` | yes |
| `runeinfo` | `runeinfo(rune)` | yes |
| `servercount` | `servercount(itemname)` | yes |
| `serverusedcount` | `serverusedcount(itemname)` | yes |
| `spellinfo` | `spellinfo(spell)` | yes |
| `timetolevel` | `timetolevel(level)` | yes |
| `tradecount` | `tradecount(tradetype, itemid); tradecount(tradetype, itemname)` | yes |
| `windowcount` | `windowcount(locationname)` | yes |

## functions/bot-control

| entry | signature | in binary |
|---|---|---|
| `clearlastonto` | `clearlastonto()` | yes |
| `flashclient` | `flashclient()` | yes |
| `focusclient` | `focusclient()` | yes |
| `geteventbyid` | `geteventbyid(id)` | yes |
| `getsetting` | `getsetting(settingpath)` | yes |
| `ignorecreature` | `ignorecreature(creaturename, unignore); ignorecreature(creatureid, unignore)` | yes |
| `listas` | `listas(text)` | yes |
| `listcolor` | `listcolor(color)` | yes |
| `loadsettings` | `loadsettings(filexml)` | yes |
| `messagebox` | `messagebox(title, msg)` | yes |
| `minimizeclient` | `minimizeclient()` | yes |
| `openbrowser` | `openbrowser(url)` | yes |
| `pausebot` | `pausebot(value, dontshowalert)` | yes |
| `pauseinput` | `pauseinput(timems)` | yes |
| `pausewalking` | `pausewalking(timems)` | yes |
| `playsound` | `playsound(filename)` | yes |
| `restoreclient` | `restoreclient()` | yes |
| `screenshot` | `screenshot(filename, worldonly, quality)` | yes |
| `setsetting` | `setsetting(settingpath, value)` | yes |
| `showbot` | `showbot(show)` | yes |
| `switchprofile` | `switchprofile(profiletype, profilename)` | yes |
| `terminateevent` | `terminateevent(eventid)` | yes |
| `traymessage` | `traymessage(title, msg, timems)` | yes |
| `traytooltip` | `traytooltip(text)` | yes |

## functions/cavebot

| entry | signature | in binary |
|---|---|---|
| `addspecialarea` | `addspecialarea(type, posx, posy, posz)` | yes |
| `addwaypoint` | `addwaypoint(wpttype, posx, posy, posz)` | yes |
| `filteruseroptions` | `filteruseroptions(filterevents)` | yes |
| `getlootingdestination` | `getlootingdestination(destinationname)` | yes |
| `getlurelocation` | `getlurelocation()` | yes |
| `getuseroption` | `getuseroption(useoptionname)` | yes |
| `gotolabel` | `gotolabel(labelname, waypointsection); gotolabel(waypointid, waypointsection)` | yes |
| `increaseamountbought` | `increaseamountbought(itemname, amount); increaseamountbought(itemid, amount)` | yes |
| `increaseamountlooted` | `increaseamountlooted(itemname, amount); increaseamountlooted(itemid, amount)` | yes |
| `increaseamountused` | `increaseamountused(itemname, amount); increaseamountused(itemid, amount)` | yes |
| `increasemoneyspent` | `increasemoneyspent(amount)` | yes |
| `islocation` | `islocation(range)` | yes |
| `moneytowithdraw` | `moneytowithdraw(supplycategories)` | yes |
| `removespecialarea` | `removespecialarea(areaname)` | yes |
| `removewaypoint` | `removewaypoint(wptid)` | yes |
| `resetcharactertime` | `resetcharactertime()` | yes |
| `resetexpcounter` | `resetexpcounter()` | yes |
| `resetlootcounter` | `resetlootcounter()` | yes |
| `setlootingdestination` | `setlootingdestination(destinationname, value)` | yes |
| `setlurelocation` | `setlurelocation(posx, posy, posz)` | yes |
| `setrefilling` | `setrefilling(value)` | yes |
| `setuseroption` | `setuseroption(widgetname, value)` | yes |
| `setuseroptionscript` | `setuseroptionscript(jsonscript)` | yes |
| `showuseroption` | `showuseroption(widgetname, state)` | yes |

## functions/client

| entry | signature | in binary |
|---|---|---|
| `clientitemhotkey` | `clientitemhotkey(itemid, type)` | yes |
| `clientspellhotkey` | `clientspellhotkey(incantation, type)` | yes |
| `clienttexthotkey` | `clienttexthotkey(text, type)` | yes |
| `cooldown` | `cooldown(spell)` | yes |
| `getarearunetile` | `getarearunetile(countplayers, name1, name2, ...)` | yes |
| `getcontainer` | `getcontainer(containerindex, all); getcontainer(containername, all)` | yes |
| `getcreature` | `getcreature(name); getcreature(id)` | yes |
| `getcreaturebyid` | `getcreaturebyid(creatureid)` | yes |
| `getcreaturebyname` | `getcreaturebyname(creaturename)` | yes |
| `getplayerinfo` | `getplayerinfo(playerid); getplayerinfo(playername)` | yes |
| `gettile` | `gettile(posx, posy, posz); gettile(rx, ry, rz)` | yes |
| `ischannel` | `ischannel(channelname)` | yes |
| `isitemontile` | `isitemontile(itemid, posx, posy, posz)` | yes |
| `maround` | `maround(range, name1, name2, ...)` | yes |
| `paround` | `paround(range)` | yes |
| `tileclickable` | `tileclickable(posx, posy, posz)` | yes |
| `tilereachable` | `tilereachable(posx, posy, posz, fullreach)` | yes |
| `tileshootable` | `tileshootable(tox, toy, toz, fromx, fromy)` | yes |
| `topitem` | `topitem(posx, posy, posz)` | yes |
| `toplookitem` | `toplookitem(posx, posy, posz)` | yes |
| `topmoveitem` | `topmoveitem(posx, posy, posz)` | yes |
| `topuseitem` | `topuseitem(posx, posy, posz)` | yes |
| `topuseonitem` | `topuseonitem(posx, posy, posz)` | yes |

## functions/database

| entry | signature | in binary |
|---|---|---|
| `DB:getvalue` | `DB:getvalue(sectionname, varname)` | — |
| `DB:setvalue` | `DB:setvalue(sectionname, varname, stringvalue); DB:setvalue(sectionname, varname, value)` | — |
| `opendatabase` | `opendatabase(dbname)` | yes |

## functions/functionality

| entry | signature | in binary |
|---|---|---|
| `auto` | `auto(interval); auto(intervalfrom, intervalto)` | yes |
| `iskeypressed` | `iskeypressed(key)` | yes |
| `keyevent` | `keyevent(key)` | yes |
| `print` | `print(text1, text2, ...)` | yes |
| `printerror` | `printerror(text1, text2, ...)` | yes |
| `setfavoritedepot` | `setfavoritedepot(index)` | yes |
| `setitemwarnings` | `setitemwarnings(val)` | yes |
| `setlifetime` | `setlifetime(lifetime)` | yes |
| `setpriority` | `setpriority(priority, overridepriority, expiretime, lifetime, type)` | yes |
| `setdelayedload` | `setdelayedload(libName, priority, functionNames)` | — |
| `wait` | `wait(waittime); wait(waittimefrom, waittimeto)` | yes |
| `waitforevents` | `waitforevents(wait)` | yes |

## functions/navigation

| entry | signature | in binary |
|---|---|---|
| `navpm` | `navpm(charname, msg)` | yes |
| `navsay` | `navsay(msg)` | yes |
| `navsendping` | `navsendping(posx, posy, posz)` | yes |

## functions/string

| entry | signature | in binary |
|---|---|---|
| `ground` | `ground(posx, posy, posz)` | yes |
| `num` | `num(numbertoformat)` | yes |
| `time` | `time(times)` | yes |
| `timeshort` | `timeshort(timems)` | yes |
| `tohex` | `tohex(num)` | yes |

## huds/basic

| entry | signature | in binary |
|---|---|---|
| `addgradcolors` | `addgradcolors(pos1, color1, pos2, color2, ...); addgradcolors(pos1, color1, pos2, color2, ...)` | yes |
| `createtexture` | `createtexture()` | yes |
| `drawchord` | `drawchord(x, y, width, height, startangle, spanangle)` | yes |
| `drawcircle` | `drawcircle(x, y, width, height)` | yes |
| `draweffect` | `draweffect(effectid, x, y, zoom, phase)` | yes |
| `drawicon` | `drawicon(iconid, x, y, zoom, fillcolor, shadowcolor, shadowdepth)` | yes |
| `drawimage` | `drawimage(filename, x, y, srcx, srcy, srcw, srch)` | yes |
| `drawitem` | `drawitem(itemid, x, y, zoom, amount, phase)` | yes |
| `drawline` | `drawline(x, y, width, height)` | yes |
| `drawoutfit` | `drawoutfit(outfitid, x, y, zoom, dir, phase, headcolor, chestcolor, legscolor, feetcolor, addon, mountid)` | yes |
| `drawpie` | `drawpie(x, y, width, height, startangle, spanangle)` | yes |
| `drawrect` | `drawrect(x, y, width, height)` | yes |
| `drawroundrect` | `drawroundrect(x, y, width, height, xradius, yradius)` | yes |
| `drawspellicon` | `drawspellicon(spelliconid, x, y, zoom)` | yes |
| `drawtext` | `drawtext(text, x, y)` | yes |
| `getposition` | `getposition()` | yes |
| `setbackgroundtexture` | `setbackgroundtexture(textureid, sizemode, left, top, right, bottom)` | yes |
| `setbordercolor` | `setbordercolor(color); setbordercolor(colorname)` | yes |
| `setcompositionmode` | `setcompositionmode(mode)` | yes |
| `setfillstyle` | `setfillstyle('color', color); setfillstyle('color', colorname)` | yes |
| `setfontborder` | `setfontborder(bordersize, bordercolor)` | yes |
| `setfontcolor` | `setfontcolor(color); setfontcolor(colorname)` | yes |
| `setfontname` | `setfontname(fontname)` | yes |
| `setfontsize` | `setfontsize(size)` | yes |
| `setfontstyle` | `setfontstyle(fontname, size, fontweight, color, bordersize, bordercolor, glowradius, glowcolor); setfontstyle(fontname, size, fontweight, colorname, bordersize, bordercolor, glowradius, glowcolor)` | yes |
| `setfontweight` | `setfontweight(weight)` | yes |
| `setposition` | `setposition(x, y)` | yes |

## huds/input

| entry | signature | in binary |
|---|---|---|
| `filterinput` | `filterinput(keys, mouseclicks, mousemoves, stealfocus)` | yes |
| `requestfloat` | `requestfloat(requestid, question, defaultvalue)` | yes |
| `requestint` | `requestint(requestid, question, defaultvalue)` | yes |
| `requestlist` | `requestlist(requestid, question, defaultindex)` | yes |
| `requestlistitem` | `requestlistitem(text)` | yes |
| `requestmenu` | `requestmenu(requestid)` | yes |
| `requestmenuitem` | `requestmenuitem(text)` | yes |
| `requesttext` | `requesttext(requestid, question, defaultvalue)` | yes |

## huds/listas

| entry | signature | in binary |
|---|---|---|
| `isscript` | `isscript(scripttype, index)` | yes |
| `scriptlistcolor` | `scriptlistcolor(scripttype, index)` | yes |
| `scriptlistname` | `scriptlistname(scripttype, index)` | yes |

## huds/positioning

| entry | signature | in binary |
|---|---|---|
| `getbararea` | `getbararea(creaturepointer)` | yes |
| `getnamearea` | `getnamearea(creaturepointer)` | yes |
| `getobjectarea` | `getobjectarea(creaturepointer); getobjectarea(posx, posy, posz)` | yes |
| `measurestring` | `measurestring(text)` | yes |

## huds/settings

| entry | signature | in binary |
|---|---|---|
| `killhudwindow` | `killhudwindow(hudid)` | yes |
| `selecthud` | `selecthud(hudid)` | yes |
| `setantialiasing` | `setantialiasing(enabled)` | yes |
| `setbkgcolorxp` | `setbkgcolorxp(color)` | yes |
| `setcurrenthud` | `setcurrenthud(hudid)` | yes |
| `setfixedsize` | `setfixedsize(width, height)` | yes |
| `setopengl` | `setopengl(enabled)` | yes |
| `spawnhudwindow` | `spawnhudwindow()` | yes |
| `useworldhud` | `useworldhud()` | yes |

## iterators/iterators

| entry | signature | in binary |
|---|---|---|
| `DB:sectionvalue` | `DB:sectionvalue()` | — |
| `creature` | `creature()` | yes |
| `deadcreature` | `deadcreature()` | — |
| `deathtimer` | `deathtimer()` | yes |
| `lootingitem` | `lootingitem()` | — |
| `message` | `message()` | yes |
| `navchar` | `navchar()` | — |
| `navping` | `navping()` | yes |
| `newanimatedtext` | `newanimatedtext()` | — |
| `neweffect` | `neweffect()` | — |
| `newmessage` | `newmessage()` | — |
| `newprojectile` | `newprojectile()` | — |
| `queuedevent` | `queuedevent()` | — |
| `settingsentry` | `settingsentry()` | — |
| `spellinfo` | `spellinfo()` | yes |
| `supplyitem` | `supplyitem()` | — |
| `vipentry` | `vipentry()` | — |

## types/animatedtext

| entry | signature | in binary |
|---|---|---|
| `.content` | `.content()` | yes |
| `.hasproperty(str)` | `.hasproperty(str)()` | yes |
| `.objtype` | `.objtype()` | yes |
| `.posx` | `.posx()` | yes |
| `.posy` | `.posy()` | yes |
| `.time` | `.time()` | yes |
| `.type` | `.type()` | yes |

## types/container

| entry | signature | in binary |
|---|---|---|
| `.curpage` | `.curpage()` | yes |
| `.emptycount` | `.emptycount()` | yes |
| `.hashigher` | `.hashigher()` | yes |
| `.hasproperty(str)` | `.hasproperty(str)()` | yes |
| `.index` | `.index()` | yes |
| `.isopen` | `.isopen()` | yes |
| `.ispage` | `.ispage()` | yes |
| `.item` | `.item()` | yes |
| `.itemcount` | `.itemcount()` | yes |
| `.itemid` | `.itemid()` | yes |
| `.lastpage` | `.lastpage()` | yes |
| `.maxcount` | `.maxcount()` | yes |
| `.name` | `.name()` | yes |
| `.objtype` | `.objtype()` | yes |

## types/creature

| entry | signature | in binary |
|---|---|---|
| `.addon` | `.addon()` | yes |
| `.aggressortype` | `.aggressortype()` | yes |
| `.chestcolor` | `.chestcolor()` | yes |
| `.dir` | `.dir()` | yes |
| `.dist` | `.dist()` | yes |
| `.feetcolor` | `.feetcolor()` | yes |
| `.hasproperty(str)` | `.hasproperty(str)()` | yes |
| `.headcolor` | `.headcolor()` | yes |
| `.hpcolor` | `.hpcolor()` | yes |
| `.hppc` | `.hppc()` | yes |
| `.id` | `.id()` | yes |
| `.ignored` | `.ignored()` | yes |
| `.ismonster` | `.ismonster()` | yes |
| `.isnpc` | `.isnpc()` | yes |
| `.isownsummon` | `.isownsummon()` | yes |
| `.isplayer` | `.isplayer()` | yes |
| `.isreachable` | `.isreachable()` | yes |
| `.isshootable` | `.isshootable()` | yes |
| `.issummon` | `.issummon()` | yes |
| `.iswalking` | `.iswalking()` | yes |
| `.lastattacked` | `.lastattacked()` | yes |
| `.lastseen` | `.lastseen()` | yes |
| `.legscolor` | `.legscolor()` | yes |
| `.lightcolor` | `.lightcolor()` | yes |
| `.lightintensity` | `.lightintensity()` | yes |
| `.mount` | `.mount()` | yes |
| `.name` | `.name()` | yes |
| `.objtype` | `.objtype()` | yes |
| `.onscreen` | `.onscreen()` | yes |
| `.outfit` | `.outfit()` | yes |
| `.party` | `.party()` | yes |
| `.posx` | `.posx()` | yes |
| `.posy` | `.posy()` | yes |
| `.posz` | `.posz()` | yes |
| `.skull` | `.skull()` | yes |
| `.speed` | `.speed()` | yes |
| `.updated` | `.updated()` | yes |
| `.walkblock` | `.walkblock()` | yes |
| `.warbanner` | `.warbanner()` | yes |

## types/deathtimer

| entry | signature | in binary |
|---|---|---|
| `.hasproperty(str)` | `.hasproperty(str)()` | yes |
| `.killer` | `.killer()` | yes |
| `.objtype` | `.objtype()` | yes |
| `.target` | `.target()` | yes |
| `.time` | `.time()` | yes |
| `.timeofdeath` | `.timeofdeath()` | yes |

## types/effect

| entry | signature | in binary |
|---|---|---|
| `.hasproperty(str)` | `.hasproperty(str)()` | yes |
| `.objtype` | `.objtype()` | yes |
| `.posx` | `.posx()` | yes |
| `.posy` | `.posy()` | yes |
| `.timems` | `.timems()` | yes |
| `.type` | `.type()` | yes |

## types/inventoryitem

| entry | signature | in binary |
|---|---|---|
| `.count` | `.count()` | yes |
| `.id` | `.id()` | yes |

## types/item

| entry | signature | in binary |
|---|---|---|
| `.count` | `.count()` | yes |
| `.hasproperty(str)` | `.hasproperty(str)()` | yes |
| `.id` | `.id()` | yes |
| `.objtype` | `.objtype()` | yes |
| `.special` | `.special()` | yes |

## types/itemdata

| entry | signature | in binary |
|---|---|---|
| `.armor` | `.armor()` | yes |
| `.attack` | `.attack()` | yes |
| `.attackmod` | `.attackmod()` | yes |
| `.automapcolor` | `.automapcolor()` | yes |
| `.buyprice` | `.buyprice()` | yes |
| `.category` | `.category()` | yes |
| `.clothslot` | `.clothslot()` | yes |
| `.deathresistmod` | `.deathresistmod()` | yes |
| `.defaultaction` | `.defaultaction()` | yes |
| `.defense` | `.defense()` | yes |
| `.defensemod` | `.defensemod()` | yes |
| `.destructible` | `.destructible()` | yes |
| `.dmgtype` | `.dmgtype()` | yes |
| `.durationtotalinmsecs` | `.durationtotalinmsecs()` | yes |
| `.earthresistmod` | `.earthresistmod()` | yes |
| `.enchantable` | `.enchantable()` | yes |
| `.energyresistmod` | `.energyresistmod()` | yes |
| `.fireresistmod` | `.fireresistmod()` | yes |
| `.hasextradata` | `.hasextradata()` | yes |
| `.hasproperty(str)` | `.hasproperty(str)()` | yes |
| `.height` | `.height()` | yes |
| `.hitpercentmod` | `.hitpercentmod()` | yes |
| `.holyresistmod` | `.holyresistmod()` | yes |
| `.iceresistmod` | `.iceresistmod()` | yes |
| `.id` | `.id()` | yes |
| `.isanimatealways` | `.isanimatealways()` | yes |
| `.isautomap` | `.isautomap()` | yes |
| `.isavoid` | `.isavoid()` | yes |
| `.isanimatealways` | `.isanimatealways()` | yes |
| `.isbottom` | `.isbottom()` | yes |
| `.isclip` | `.isclip()` | yes |
| `.isclothes` | `.isclothes()` | yes |
| `.iscontainer` | `.iscontainer()` | yes |
| `.iscumulative` | `.iscumulative()` | yes |
| `.isdefaultaction` | `.isdefaultaction()` | yes |
| `.isdonthide` | `.isdonthide()` | yes |
| `.isfloorchange` | `.isfloorchange()` | yes |
| `.isforceuse` | `.isforceuse()` | yes |
| `.isfullbank` | `.isfullbank()` | yes |
| `.ishang` | `.ishang()` | yes |
| `.isheight` | `.isheight()` | yes |
| `.ishookeast` | `.ishookeast()` | yes |
| `.ishooksouth` | `.ishooksouth()` | yes |
| `.isignorelook` | `.isignorelook()` | yes |
| `.islenshelp` | `.islenshelp()` | yes |
| `.islight` | `.islight()` | yes |
| `.isliquidcontainer` | `.isliquidcontainer()` | yes |
| `.isliquidpool` | `.isliquidpool()` | yes |
| `.islyingobject` | `.islyingobject()` | yes |
| `.ismarket` | `.ismarket()` | yes |
| `.ismount` | `.ismount()` | yes |
| `.ismultiuse` | `.ismultiuse()` | yes |
| `.isnomovementanimation` | `.isnomovementanimation()` | yes |
| `.isrotate` | `.isrotate()` | yes |
| `.isshift` | `.isshift()` | yes |
| `.istake` | `.istake()` | yes |
| `.istop` | `.istop()` | yes |
| `.istranslucent` | `.istranslucent()` | yes |
| `.isunmove` | `.isunmove()` | yes |
| `.isunpass` | `.isunpass()` | yes |
| `.isunsight` | `.isunsight()` | yes |
| `.isusable` | `.isusable()` | yes |
| `.iswrite` | `.iswrite()` | yes |
| `.iswriteonce` | `.iswriteonce()` | yes |
| `.itemlossmod` | `.itemlossmod()` | yes |
| `.layers` | `.layers()` | yes |
| `.lenshelp` | `.lenshelp()` | yes |
| `.lifedrainresistmod` | `.lifedrainresistmod()` | yes |
| `.lightcolor` | `.lightcolor()` | yes |
| `.lightradius` | `.lightradius()` | yes |
| `.lootmsgcount` | `.lootmsgcount()` | yes |
| `.mana` | `.mana()` | yes |
| `.manadrainresistmod` | `.manadrainresistmod()` | yes |
| `.marketcategory` | `.marketcategory()` | yes |
| `.marketrestrictlevel` | `.marketrestrictlevel()` | yes |
| `.marketrestrictprofession` | `.marketrestrictprofession()` | yes |
| `.marketshowas` | `.marketshowas()` | yes |
| `.markettradeas` | `.markettradeas()` | yes |
| `.maxdmg` | `.maxdmg()` | yes |
| `.mindmg` | `.mindmg()` | yes |
| `.name` | `.name()` | yes |
| `.objtype` | `.objtype()` | yes |
| `.patterndepth` | `.patterndepth()` | yes |
| `.patternx` | `.patternx()` | yes |
| `.patterny` | `.patterny()` | yes |
| `.phase` | `.phase()` | yes |
| `.physicalresistmod` | `.physicalresistmod()` | yes |
| `.range` | `.range()` | yes |
| `.sellprice` | `.sellprice()` | yes |
| `.shiftx` | `.shiftx()` | yes |
| `.shifty` | `.shifty()` | yes |
| `.sizeinpixels` | `.sizeinpixels()` | yes |
| `.specialeffect` | `.specialeffect()` | yes |
| `.specialeffectgain` | `.specialeffectgain()` | yes |
| `.textlimit` | `.textlimit()` | yes |
| `.walkheight` | `.walkheight()` | yes |
| `.walkspeed` | `.walkspeed()` | yes |
| `.weight` | `.weight()` | yes |

## types/lootingdata

| entry | signature | in binary |
|---|---|---|
| `.action` | `.action()` | yes |
| `.alert` | `.alert()` | yes |
| `.amountlooted` | `.amountlooted()` | yes |
| `.caphigherthan` | `.caphigherthan()` | yes |
| `.category` | `.category()` | yes |
| `.condition` | `.condition()` | yes |
| `.conditionvalue` | `.conditionvalue()` | yes |
| `.count` | `.count()` | yes |
| `.destination` | `.destination()` | yes |
| `.haslessthan` | `.haslessthan()` | yes |
| `.hasproperty(str)` | `.hasproperty(str)()` | yes |
| `.id` | `.id()` | yes |
| `.lootmessage` | `.lootmessage()` | yes |
| `.name` | `.name()` | yes |
| `.objtype` | `.objtype()` | yes |
| `.sellprice` | `.sellprice()` | yes |
| `.weight` | `.weight()` | yes |

## types/message

| entry | signature | in binary |
|---|---|---|
| `.channel` | `.channel()` | yes |
| `.content` | `.content()` | yes |
| `.hasproperty(str)` | `.hasproperty(str)()` | yes |
| `.level` | `.level()` | yes |
| `.objtype` | `.objtype()` | yes |
| `.sender` | `.sender()` | yes |
| `.time` | `.time()` | yes |
| `.timestr` | `.timestr()` | yes |
| `.type` | `.type()` | yes |

## types/mouseinfo

| entry | signature | in binary |
|---|---|---|
| `.count` | `.count()` | yes |
| `.crosshair` | `.crosshair()` | yes |
| `.hasproperty(str)` | `.hasproperty(str)()` | yes |
| `.id` | `.id()` | yes |
| `.objtype` | `.objtype()` | yes |
| `.x` | `.x()` | yes |
| `.y` | `.y()` | yes |
| `.z` | `.z()` | yes |

## types/navchar

| entry | signature | in binary |
|---|---|---|
| `.hasproperty(str)` | `.hasproperty(str)()` | yes |
| `.objtype` | `.objtype()` | yes |
| `.objtype` | `.objtype()` | yes |
| `.objtype` | `.objtype()` | yes |
| `.objtype` | `.objtype()` | yes |
| `.objtype` | `.objtype()` | yes |
| `.objtype` | `.objtype()` | yes |
| `.objtype` | `.objtype()` | yes |

## types/navping

| entry | signature | in binary |
|---|---|---|
| `.color` | `.color()` | yes |
| `.glowcolor` | `.glowcolor()` | yes |
| `.hasproperty(str)` | `.hasproperty(str)()` | yes |
| `.objtype` | `.objtype()` | yes |
| `.posx` | `.posx()` | yes |
| `.posy` | `.posy()` | yes |
| `.posz` | `.posz()` | yes |
| `.time` | `.time()` | yes |

## types/navtarget

| entry | signature | in binary |
|---|---|---|
| `.color` | `.color()` | yes |
| `.creature` | `.creature()` | yes |
| `.color` | `.color()` | yes |
| `.hasproperty(str)` | `.hasproperty(str)()` | yes |
| `.icon` | `.icon()` | yes |
| `.id` | `.id()` | yes |
| `.isenemy` | `.isenemy()` | yes |
| `.isfriend` | `.isfriend()` | yes |
| `.isleader` | `.isleader()` | yes |
| `.isneutral` | `.isneutral()` | yes |
| `.maxmp` | `.maxmp()` | yes |
| `.mp` | `.mp()` | yes |
| `.name` | `.name()` | yes |
| `.objtype` | `.objtype()` | yes |
| `.posx` | `.posx()` | yes |
| `.posy` | `.posy()` | yes |
| `.posz` | `.posz()` | yes |
| `.realname` | `.realname()` | yes |
| `.team` | `.team()` | yes |
| `.teamname` | `.teamname()` | yes |
| `.time` | `.time()` | yes |
| `.voc` | `.voc()` | yes |

## types/playerinfo

| entry | signature | in binary |
|---|---|---|
| `.comment` | `.comment()` | yes |
| `.guild` | `.guild()` | yes |
| `.hasproperty(str)` | `.hasproperty(str)()` | yes |
| `.level` | `.level()` | yes |
| `.name` | `.name()` | yes |
| `.objtype` | `.objtype()` | yes |
| `.priority` | `.priority()` | yes |
| `.status` | `.status()` | yes |
| `.time` | `.time()` | yes |
| `.voc` | `.voc()` | yes |
| `.vocation` | `.vocation()` | yes |
| `.vocshort` | `.vocshort()` | yes |

## types/point

| entry | signature | in binary |
|---|---|---|
| `.hasproperty(str)` | `.hasproperty(str)()` | yes |
| `.objtype` | `.objtype()` | yes |
| `.x` | `.x()` | yes |
| `.y` | `.y()` | yes |

## types/projectile

| entry | signature | in binary |
|---|---|---|
| `.fromx` | `.fromx()` | yes |
| `.fromy` | `.fromy()` | yes |
| `.hasproperty(str)` | `.hasproperty(str)()` | yes |
| `.objtype` | `.objtype()` | yes |
| `.timems` | `.timems()` | yes |
| `.tox` | `.tox()` | yes |
| `.toy` | `.toy()` | yes |
| `.type` | `.type()` | yes |

## types/rectangle

| entry | signature | in binary |
|---|---|---|
| `.bottom` | `.bottom()` | yes |
| `.centerx` | `.centerx()` | yes |
| `.centery` | `.centery()` | yes |
| `.hasproperty(str)` | `.hasproperty(str)()` | yes |
| `.height` | `.height()` | yes |
| `.left` | `.left()` | yes |
| `.objtype` | `.objtype()` | yes |
| `.right` | `.right()` | yes |
| `.top` | `.top()` | yes |
| `.width` | `.width()` | yes |

## types/spellinfo

| entry | signature | in binary |
|---|---|---|
| `.avgdmg` | `.avgdmg()` | yes |
| `.cancast` | `.cancast()` | yes |
| `.castarea` | `.castarea()` | yes |
| `.castmode` | `.castmode()` | yes |
| `.cooldown` | `.cooldown()` | yes |
| `.dmgtype` | `.dmgtype()` | yes |
| `.duration` | `.duration()` | yes |
| `.group` | `.group()` | yes |
| `.hasproperty(str)` | `.hasproperty(str)()` | yes |
| `.healtype` | `.healtype()` | yes |
| `.iconid` | `.iconid()` | yes |
| `.itemid` | `.itemid()` | yes |
| `.learned` | `.learned()` | yes |
| `.level` | `.level()` | yes |
| `.maxdmg` | `.maxdmg()` | yes |
| `.mindmg` | `.mindmg()` | yes |
| `.mlevel` | `.mlevel()` | yes |
| `.mp` | `.mp()` | yes |
| `.name` | `.name()` | yes |
| `.objtype` | `.objtype()` | yes |
| `.premium` | `.premium()` | yes |
| `.price` | `.price()` | yes |
| `.promotion` | `.promotion()` | yes |
| `.soul` | `.soul()` | yes |
| `.specialeffect` | `.specialeffect()` | yes |
| `.type` | `.type()` | yes |
| `.vocation` | `.vocation()` | yes |
| `.words` | `.words()` | yes |

## types/supplydata

| entry | signature | in binary |
|---|---|---|
| `.amountbought` | `.amountbought()` | yes |
| `.amounttobuy` | `.amounttobuy()` | yes |
| `.amountused` | `.amountused()` | yes |
| `.buyprice` | `.buyprice()` | yes |
| `.category` | `.category()` | yes |
| `.count` | `.count()` | yes |
| `.destination` | `.destination()` | yes |
| `.downtocap` | `.downtocap()` | yes |
| `.hasproperty(str)` | `.hasproperty(str)()` | yes |
| `.id` | `.id()` | yes |
| `.leaveat` | `.leaveat()` | yes |
| `.name` | `.name()` | yes |
| `.objtype` | `.objtype()` | yes |
| `.rule` | `.rule()` | yes |
| `.rulevalue` | `.rulevalue()` | yes |
| `.uptocount` | `.uptocount()` | yes |
| `.weight` | `.weight()` | yes |

## types/tile

| entry | signature | in binary |
|---|---|---|
| `.hasproperty(str)` | `.hasproperty(str)()` | yes |
| `.item` | `.item()` | yes |
| `.itemcount` | `.itemcount()` | yes |
| `.objtype` | `.objtype()` | yes |

## types/vipnode

| entry | signature | in binary |
|---|---|---|
| `.hasproperty(str)` | `.hasproperty(str)()` | yes |
| `.icon` | `.icon()` | yes |
| `.id` | `.id()` | yes |
| `.isonline` | `.isonline()` | yes |
| `.name` | `.name()` | yes |
| `.notify` | `.notify()` | yes |
| `.objtype` | `.objtype()` | yes |

## variables/bot

| entry | signature | in binary |
|---|---|---|
| `$addons` | `$addons()` | yes |
| `$balance` | `$balance()` | yes |
| `$botversion` | `$botversion()` | yes |
| `$cavebot` | `$cavebot()` | yes |
| `$curscript` | `$curscript()` | yes |
| `$fasthotkeys` | `$fasthotkeys()` | yes |
| `$favoritedepot` | `$favoritedepot()` | yes |
| `$lastlabel` | `$lastlabel()` | yes |
| `$lastonto` | `$lastonto()` | yes |
| `$lootaccuracy` | `$lootaccuracy()` | yes |
| `$lootbodies` | `$lootbodies()` | yes |
| `$looting` | `$looting()` | yes |
| `$lootsaround` | `$lootsaround()` | yes |
| `$luring` | `$luring()` | yes |
| `$macheteid` | `$macheteid()` | yes |
| `$moneyspent` | `$moneyspent()` | yes |
| `$openingbps` | `$openingbps()` | yes |
| `$pickid` | `$pickid()` | yes |
| `$refilling` | `$refilling()` | yes |
| `$ropeid` | `$ropeid()` | yes |
| `$shovelid` | `$shovelid()` | yes |
| `$simulatedcursor` | `$simulatedcursor()` | yes |
| `$targeting` | `$targeting()` | yes |
| `$trapped` | `$trapped()` | yes |
| `$wptid` | `$wptid()` | yes |
| `$wptsection` | `$wptsection()` | yes |
| `$wpttype` | `$wpttype()` | yes |
| `$wptx` | `$wptx()` | yes |
| `$wpty` | `$wpty()` | yes |
| `$wptz` | `$wptz()` | yes |

## variables/character

| entry | signature | in binary |
|---|---|---|
| `$cap` | `$cap()` | yes |
| `$dead` | `$dead()` | yes |
| `$exp` | `$exp()` | yes |
| `$hp` | `$hp()` | yes |
| `$hppc` | `$hppc()` | yes |
| `$id` | `$id()` | yes |
| `$maxhp` | `$maxhp()` | yes |
| `$maxmp` | `$maxmp()` | yes |
| `$mounted` | `$mounted()` | yes |
| `$mp` | `$mp()` | yes |
| `$mppc` | `$mppc()` | yes |
| `$name` | `$name()` | yes |
| `$offlinetraining` | `$offlinetraining()` | yes |
| `$posx` | `$posx()` | yes |
| `$posy` | `$posy()` | yes |
| `$posz` | `$posz()` | yes |
| `$premium` | `$premium()` | yes |
| `$soul` | `$soul()` | yes |
| `$stamina` | `$stamina()` | yes |
| `$voc` | `$voc()` | yes |
| `$vocation` | `$vocation()` | yes |
| `$vocshort` | `$vocshort()` | yes |
| `$worldname` | `$worldname()` | yes |

## variables/client

| entry | signature | in binary |
|---|---|---|
| `$attackmode` | `$attackmode()` | yes |
| `$battleopen` | `$battleopen()` | yes |
| `$chasemode` | `$chasemode()` | yes |
| `$connected` | `$connected()` | yes |
| `$connectionstate` | `$connectionstate()` | yes |
| `$focused` | `$focused()` | yes |
| `$marketopen` | `$marketopen()` | yes |
| `$minimized` | `$minimized()` | yes |
| `$openmenuname` | `$openmenuname()` | yes |
| `$pvpmode` | `$pvpmode()` | yes |
| `$pvpsecurity` | `$pvpsecurity()` | yes |
| `$tradeopen` | `$tradeopen()` | yes |
| `$typedtext` | `$typedtext()` | yes |
| `$worldvisible` | `$worldvisible()` | yes |
| `$writtentext` | `$writtentext()` | yes |
| `$writtentextinfo` | `$writtentextinfo()` | yes |

## variables/creature

| entry | signature | in binary |
|---|---|---|
| `$attacked` | `$attacked()` | yes |
| `$followed` | `$followed()` | yes |
| `$mattacker` | `$mattacker()` | yes |
| `$pattacker` | `$pattacker()` | yes |
| `$self` | `$self()` | yes |
| `$target` | `$target()` | yes |
| `$targetingtarget` | `$targetingtarget()` | yes |

## variables/damage

| entry | signature | in binary |
|---|---|---|
| `$deathdmg` | `$deathdmg()` | yes |
| `$earthdmg` | `$earthdmg()` | yes |
| `$energydmg` | `$energydmg()` | yes |
| `$firedmg` | `$firedmg()` | yes |
| `$healdmg` | `$healdmg()` | yes |
| `$holydmg` | `$holydmg()` | yes |
| `$icedmg` | `$icedmg()` | yes |
| `$manadmg` | `$manadmg()` | yes |
| `$physicaldmg` | `$physicaldmg()` | yes |

## variables/database

| entry | signature | in binary |
|---|---|---|
| `$botdb` | `$botdb()` | yes |
| `$chardb` | `$chardb()` | yes |
| `$worlddb` | `$worlddb()` | yes |

## variables/equip

| entry | signature | in binary |
|---|---|---|
| `$back` | `$back()` | yes |
| `$belt` | `$belt()` | yes |
| `$chest` | `$chest()` | yes |
| `$feet` | `$feet()` | yes |
| `$finger` | `$finger()` | yes |
| `$head` | `$head()` | yes |
| `$legs` | `$legs()` | yes |
| `$lhand` | `$lhand()` | yes |
| `$neck` | `$neck()` | yes |
| `$rhand` | `$rhand()` | yes |

## variables/events

| entry | signature | in binary |
|---|---|---|
| `$curevent` | `$curevent()` | yes |
| `$cureventid` | `$cureventid()` | yes |
| `$cureventtype` | `$cureventtype()` | yes |

## variables/huds

| entry | signature | in binary |
|---|---|---|
| `$clientwin` | `$clientwin()` | yes |
| `$cursor` | `$cursor()` | yes |
| `$cursorinfo` | `$cursorinfo()` | yes |
| `$screenwin` | `$screenwin()` | yes |
| `$windowsxp` | `$windowsxp()` | yes |
| `$worldwin` | `$worldwin()` | yes |

## variables/navigation

| entry | signature | in binary |
|---|---|---|
| `$navigation` | `$navigation()` | yes |

## variables/screen

| entry | signature | in binary |
|---|---|---|
| `$lastanimatedtext` | `$lastanimatedtext()` | yes |
| `$lasteffect` | `$lasteffect()` | yes |
| `$lastmsg` | `$lastmsg()` | yes |
| `$lastnpcmsg` | `$lastnpcmsg()` | yes |
| `$lastprojectile` | `$lastprojectile()` | yes |

## variables/server

| entry | signature | in binary |
|---|---|---|
| `$idlerecvtime` | `$idlerecvtime()` | yes |
| `$ping` | `$ping()` | yes |
| `$pingaverage` | `$pingaverage()` | yes |

## variables/skill

| entry | signature | in binary |
|---|---|---|
| `$axe` | `$axe()` | yes |
| `$axepc` | `$axepc()` | yes |
| `$club` | `$club()` | yes |
| `$clubpc` | `$clubpc()` | yes |
| `$distance` | `$distance()` | yes |
| `$distancepc` | `$distancepc()` | yes |
| `$fishing` | `$fishing()` | yes |
| `$fishingpc` | `$fishingpc()` | yes |
| `$fist` | `$fist()` | yes |
| `$fistpc` | `$fistpc()` | yes |
| `$level` | `$level()` | yes |
| `$levelpc` | `$levelpc()` | yes |
| `$mlevel` | `$mlevel()` | yes |
| `$mlevelpc` | `$mlevelpc()` | yes |
| `$shielding` | `$shielding()` | yes |
| `$shieldingpc` | `$shieldingpc()` | yes |
| `$sword` | `$sword()` | yes |
| `$swordpc` | `$swordpc()` | yes |

## variables/statistics

| entry | signature | in binary |
|---|---|---|
| `$expgained` | `$expgained()` | yes |
| `$exphour` | `$exphour()` | yes |
| `$exptonextlevel` | `$exptonextlevel()` | yes |
| `$timetonextlevel` | `$timetonextlevel()` | yes |

## variables/status

| entry | signature | in binary |
|---|---|---|
| `$battlesigned` | `$battlesigned()` | yes |
| `$bleeding` | `$bleeding()` | yes |
| `$bleedingdmg` | `$bleedingdmg()` | yes |
| `$burning` | `$burning()` | yes |
| `$burningdmg` | `$burningdmg()` | yes |
| `$cursed` | `$cursed()` | yes |
| `$curseddmg` | `$curseddmg()` | yes |
| `$dazzled` | `$dazzled()` | yes |
| `$drowning` | `$drowning()` | yes |
| `$drunk` | `$drunk()` | yes |
| `$electrified` | `$electrified()` | yes |
| `$electrifieddmg` | `$electrifieddmg()` | yes |
| `$frozen` | `$frozen()` | yes |
| `$frozendmg` | `$frozendmg()` | yes |
| `$hasted` | `$hasted()` | yes |
| `$manashielded` | `$manashielded()` | yes |
| `$paralyzed` | `$paralyzed()` | yes |
| `$poisondmg` | `$poisondmg()` | yes |
| `$poisoned` | `$poisoned()` | yes |
| `$pvpsigned` | `$pvpsigned()` | yes |
| `$pzone` | `$pzone()` | yes |
| `$strenghtened` | `$strenghtened()` | yes |

## variables/timer

| entry | signature | in binary |
|---|---|---|
| `$charactertime` | `$charactertime()` | yes |
| `$clientctrltime` | `$clientctrltime()` | yes |
| `$clientshifttime` | `$clientshifttime()` | yes |
| `$ctrltime` | `$ctrltime()` | yes |
| `$hastetime` | `$hastetime()` | yes |
| `$hunttime` | `$hunttime()` | yes |
| `$invistime` | `$invistime()` | yes |
| `$mshieldtime` | `$mshieldtime()` | yes |
| `$openmenutime` | `$openmenutime()` | yes |
| `$recoverytime` | `$recoverytime()` | yes |
| `$shifttime` | `$shifttime()` | yes |
| `$standtime` | `$standtime()` | yes |
| `$strenghtentime` | `$strenghtentime()` | yes |
| `$targettime` | `$targettime()` | yes |
| `$timems` | `$timems()` | yes |

## widgets/button

| entry | signature | in binary |
|---|---|---|
| `description` | `description()` | yes |
| `name` | `name()` | yes |
| `text` | `text()` | yes |
| `type` | `type()` | yes |

## widgets/checkbox

| entry | signature | in binary |
|---|---|---|
| `description` | `description()` | yes |
| `name` | `name()` | yes |
| `text` | `text()` | yes |
| `type` | `type()` | yes |
| `value` | `value()` | yes |

## widgets/combobox

| entry | signature | in binary |
|---|---|---|
| `description` | `description()` | yes |
| `items` | `items()` | yes |
| `name` | `name()` | yes |
| `text` | `text()` | yes |
| `type` | `type()` | yes |

## widgets/doublespinbox

| entry | signature | in binary |
|---|---|---|
| `description` | `description()` | yes |
| `max` | `max()` | yes |
| `min` | `min()` | yes |
| `name` | `name()` | yes |
| `prefix` | `prefix()` | yes |
| `suffix` | `suffix()` | yes |
| `text` | `text()` | yes |
| `type` | `type()` | yes |
| `value` | `value()` | yes |

## widgets/group

| entry | signature | in binary |
|---|---|---|
| `checkable` | `checkable()` | yes |
| `children` | `children()` | yes |
| `column` | `column()` | yes |
| `description` | `description()` | yes |
| `name` | `name()` | yes |
| `text` | `text()` | yes |
| `type` | `type()` | yes |

## widgets/lineedit

| entry | signature | in binary |
|---|---|---|
| `description` | `description()` | yes |
| `name` | `name()` | yes |
| `placeholder` | `placeholder()` | yes |
| `text` | `text()` | yes |
| `type` | `type()` | yes |
| `value` | `value()` | yes |

## widgets/rangespinbox

| entry | signature | in binary |
|---|---|---|
| `description` | `description()` | yes |
| `max` | `max()` | yes |
| `min` | `min()` | yes |
| `name` | `name()` | yes |
| `prefix` | `prefix()` | yes |
| `suffix` | `suffix()` | yes |
| `text` | `text()` | yes |
| `type` | `type()` | yes |
| `value` | `value()` | yes |

## widgets/scriptinfo

| entry | signature | in binary |
|---|---|---|
| `name` | `name()` | yes |
| `type` | `type()` | yes |
| `version` | `version()` | yes |

## widgets/separator

| entry | signature | in binary |
|---|---|---|
| `type` | `type()` | yes |

## widgets/spinbox

| entry | signature | in binary |
|---|---|---|
| `description` | `description()` | yes |
| `max` | `max()` | yes |
| `min` | `min()` | yes |
| `name` | `name()` | yes |
| `prefix` | `prefix()` | yes |
| `suffix` | `suffix()` | yes |
| `text` | `text()` | yes |
| `type` | `type()` | yes |
| `value` | `value()` | yes |
