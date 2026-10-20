#!/usr/bin/env python3
"""Read Tibia 10.76 client state from a Wine process via /proc/<pid>/mem (Linux host, same uid).
Usage: read_1076.py <linux_pid_of_Tibia.exe> [--dump N]   (no writes; read-only)"""
import sys, struct
BASE=0x400000
A=dict(XOR=0x8380D0,HP=0x9D5000,HPMAX=0x9D502C,MANA=0x838100,MANAMAX=0x8380D4,SOUL=0x8380EC,EXP=0x8380D8,LEVEL=0x8380E8,
       PID=0x9D5034,X=0x9D5038,Y=0x9D503C,Z=0x9D5040,CONN=0x849EEC,RED=0x8380FC,BL=0xA2C0A0)
STRIDE, SLOTS = 0xDC, 1300
pid=int(sys.argv[1]); f=open(f'/proc/{pid}/mem','rb')
def rd(a,n): f.seek(a); return f.read(n)
def u(a): return struct.unpack('<I',rd(a,4))[0]
def player():
    x=u(A['XOR'])
    return dict(id=u(A['PID']),pos=(u(A['X']),u(A['Y']),u(A['Z'])),hp=u(A['HP'])^x,hpmax=u(A['HPMAX'])^x,
                mana=u(A['MANA'])^x,manamax=u(A['MANAMAX'])^x,soul=u(A['SOUL']),exp=u(A['EXP']),level=u(A['LEVEL']),connected=u(A['CONN']),target=u(A['RED']))
def creatures():
    out=[]
    for i in range(SLOTS):
        b=rd(A['BL']+i*STRIDE,STRIDE); cid=struct.unpack_from('<I',b,0)[0]
        if cid==0: continue
        out.append((i,b))
    return out
if __name__=='__main__':
    print(player())
    for i,b in creatures():
        name=b[4:36].split(b'\0')[0].decode('latin1')
        g=lambda o: struct.unpack_from('<i',b,o)[0]
        print(i, hex(g(0)&0xffffffff), repr(name), 'xyz', (g(0x2c),g(0x28),g(0x24)), 'dir', g(0x38),
              'outfit', (g(0x60),g(0x64),g(0x68),g(0x6c),g(0x70),'addons',g(0x74),'mount',g(0x78)),
              'hp%', g(0x8c), 'speed', g(0x90), 'skull', g(0x94), 'party', g(0x98), 'visible', g(0xa4), 'type', g(0xbc))
        if '--dump' in sys.argv:
            for o in range(0x24,STRIDE,4): print(f'   +{o:#04x} {struct.unpack_from("<I",b,o)[0]:#010x} {struct.unpack_from("<i",b,o)[0]}')
