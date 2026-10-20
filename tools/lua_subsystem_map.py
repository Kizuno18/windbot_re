import re,pefile,collections,json,os,glob
cat=open('/workspace/re/windbot_re/docs/09-lua-api-catalog.md').read()
ents=[];sec=None
for l in cat.splitlines():
    if l.startswith('## '): sec=l[3:].strip()
    m=re.match(r'\| `([^`]+)` \| (.*) \| (yes|—|no) \|$',l)
    if m and sec: ents.append(dict(name=m.group(1),cat=sec,inbin=m.group(3)))
print(len(ents))
B='/workspace/re/windbot/inst/app/code$MyConst.exe'; d=open(B,'rb').read(); pe=pefile.PE(B)
def secof(off):
    for s in pe.sections:
        if s.PointerToRawData<=off<s.PointerToRawData+s.SizeOfRawData: return s.Name.rstrip(b'\0').decode()
def locs(name):
    key=name.split(':')[-1].split('.')[-1].encode()
    out=set()
    for m in re.finditer(rb'(?<![A-Za-z0-9_])'+re.escape(key)+rb'\x00',d): out.add(secof(m.start()))
    return sorted(x for x in out if x)
def lua_ids(root):
    c=collections.Counter()
    for f in glob.glob(root+'/**/*.lua*',recursive=True):
        for w in re.findall(r'[A-Za-z_][A-Za-z0-9_]*',open(f,errors='ignore').read()): c[w]+=1
    return c
L262=lua_ids('/workspace/re/windbot/inst_2.6.2/app'); L830=lua_ids('/workspace/re/windbot/inst/app')
rules=[
 ('navigation',lambda n,c: 'navigation' in c or c.startswith('types/nav') or n.startswith('nav')),
 ('cavebot',lambda n,c: 'cavebot' in c or re.search(r'waypoint|wpt|gotolabel|specialarea|reach|moveto|^path|lure|cavebot|setting',n,re.I)),
 ('targeting',lambda n,c: c=='events/creature' or re.search(r'target|attack|follow|enemy|monster|creature|battle|maround|paround',n,re.I)),
 ('healing/supplies',lambda n,c: re.search(r'heal|hppc|mppc|^hp|^mp|mana|potion|rune|spell|cancast|cast|supply|refill|cooldown|exori|exura',n,re.I) or c in('types/spellinfo','types/supplydata')),
 ('looting/items',lambda n,c: c=='events/item' or re.search(r'loot|item|container|backpack|equip|depot|bp|inventory',n,re.I) or c in('types/container','types/item','types/inventoryitem','types/itemdata','types/lootingdata','variables/equip')),
 ('network/session',lambda n,c: re.search(r'connect|logout|xlog|ping|server|online|world|login|account|http|socket|send',n,re.I) or c=='variables/server'),
 ('client memory/state (HookManager)',lambda n,c: c.startswith('variables/') or c in('types/tile','types/creature','types/message','types/effect','types/projectile','types/animatedtext','types/mouseinfo','types/vipnode','types/playerinfo','types/deathtimer','functions/client') or c.startswith('events/') ),
 ('HUD/widgets',lambda n,c: c.startswith('huds/') or c.startswith('widgets/') or c=='types/rectangle'),
 ('scripting core/db/util',lambda n,c: True),
]
res=[]
for e in ents:
    n,c=e['name'],e['cat']
    for s,f in rules:
        if f(n.split(':')[-1].split('.')[-1],c): e['sub']=s;break
    e['loc']=locs(n); k=n.split(':')[-1].split('.')[-1]
    e['u262']=L262.get(k,0); e['u830']=L830.get(k,0); res.append(e)
json.dump(res,open('sub.json','w'),indent=0)
C=collections.Counter(e['sub'] for e in res); print(C)
print(collections.Counter(tuple(e['loc']) for e in res))
only830=[e['name'] for e in res if e['u830'] and not e['u262']]; only262=[e['name'] for e in res if e['u262'] and not e['u830']]
print('only830',only830); print('only262',only262)
