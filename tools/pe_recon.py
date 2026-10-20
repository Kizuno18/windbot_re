#!/usr/bin/env python3
"""PE triage: header, sections+entropy, imports, exports, .NET metadata presence, packer hints."""
import sys, pefile, hashlib, math, collections, datetime
def ent(b):
    if not b: return 0
    c=collections.Counter(b); n=len(b); return -sum(v/n*math.log2(v/n) for v in c.values())
for p in sys.argv[1:]:
    d=open(p,'rb').read(); pe=pefile.PE(data=d)
    print(f"# {p}\nsha256 {hashlib.sha256(d).hexdigest()}  size {len(d)}")
    fh=pe.FILE_HEADER; oh=pe.OPTIONAL_HEADER
    print(f"timestamp {datetime.datetime.utcfromtimestamp(fh.TimeDateStamp)}Z  ImageBase {oh.ImageBase:#x} EP {oh.AddressOfEntryPoint:#x} subsys {oh.Subsystem}")
    clr=oh.DATA_DIRECTORY[14]; print("CLR header:", bool(clr.VirtualAddress))
    for s in pe.sections:
        print(f"  {s.Name.rstrip(b'\0').decode(errors='replace'):10} va {s.VirtualAddress:#09x} vsz {s.Misc_VirtualSize:#09x} raw {s.SizeOfRawData:#09x} ent {ent(s.get_data()):.2f}")
    if hasattr(pe,'DIRECTORY_ENTRY_IMPORT'):
        for imp in pe.DIRECTORY_ENTRY_IMPORT:
            names=[(i.name or b'#%d'%i.ordinal).decode() for i in imp.imports]
            print(f"  IMPORT {imp.dll.decode()} ({len(names)}): {', '.join(names[:40])}{' ...' if len(names)>40 else ''}")
    if hasattr(pe,'DIRECTORY_ENTRY_EXPORT'):
        ex=[(e.name or b'').decode() for e in pe.DIRECTORY_ENTRY_EXPORT.symbols]
        print(f"  EXPORTS ({len(ex)}): {', '.join(ex[:60])}")
    print()
