#!/usr/bin/env python3
"""Snapshot battle-list slots of player-type creatures (type 0) for one or more Tibia 10.76 pids via /proc/<pid>/mem (read-only).
Usage: snap_1076.py <label> <pid> [<pid>...]   -> appends JSON line to snaps.jsonl and prints diff vs previous snapshot."""
import sys, struct, json, os
BL, STRIDE, SLOTS = 0xA2C0A0, 0xDC, 1300
OUT = os.environ.get('SNAPS', 'snaps.jsonl')
def snap(pid):
    f = open(f'/proc/{pid}/mem', 'rb'); r = {}
    f.seek(0x9D5034); me = struct.unpack('<I', f.read(4))[0]
    for i in range(SLOTS):
        f.seek(BL + i*STRIDE); b = f.read(STRIDE)
        cid = struct.unpack_from('<I', b, 0)[0]
        if not cid or struct.unpack_from('<i', b, 0xBC)[0] != 0: continue
        name = b[4:36].split(b'\0')[0].decode('latin1')
        r[name] = {f'{o:#04x}': struct.unpack_from('<i', b, o)[0] for o in range(0x8C, STRIDE, 4)}
        r[name]['self'] = int(cid == me)
    return r
label, pids = sys.argv[1], sys.argv[2:]
cur = {'label': label, 'p': {p: snap(int(p)) for p in pids}}
prev = None
if os.path.exists(OUT):
    lines = open(OUT).read().splitlines()
    if lines: prev = json.loads(lines[-1])
open(OUT, 'a').write(json.dumps(cur) + '\n')
for p, cs in cur['p'].items():
    for n, fl in cs.items():
        old = (prev or {}).get('p', {}).get(p, {}).get(n)
        ch = {k: (old[k] if old else None, v) for k, v in fl.items() if not old or old.get(k) != v}
        if old is None: ch = {k: v for k, v in fl.items() if k in ('0x94','0x98','0x9c','0xa0','0xa8','0xb0','0xcc','self')}
        print(f'[{label}] pid {p} sees {n!r}: {ch}')
