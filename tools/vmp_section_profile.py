import pefile,math,sys,collections,hashlib
def ent(b):
    if not b: return 0
    c=collections.Counter(b);n=len(b)
    return -sum(v/n*math.log2(v/n) for v in c.values())
for tag,p in [("2.6.2","../windbot/inst_2.6.2/app/code$MyConst.exe"),("2.8.30","../windbot/inst/app/code$MyConst.exe")]:
    d=open(p,'rb').read(); pe=pefile.PE(data=d)
    oh=pe.OPTIONAL_HEADER; fh=pe.FILE_HEADER
    print(f"=== {tag} sha256={hashlib.sha256(d).hexdigest()} size={len(d)}")
    print(f"TimeDateStamp={fh.TimeDateStamp:#x} Linker={oh.MajorLinkerVersion}.{oh.MinorLinkerVersion} OS={oh.MajorOperatingSystemVersion}.{oh.MinorOperatingSystemVersion} Subsys={oh.Subsystem} DllChar={oh.DllCharacteristics:#x} Chars={fh.Characteristics:#x} ImageBase={oh.ImageBase:#x} SizeOfImage={oh.SizeOfImage:#x} Checksum={oh.CheckSum:#x} calc={pe.generate_checksum():#x}")
    ep=oh.AddressOfEntryPoint
    for s in pe.sections:
        n=s.Name.rstrip(b'\0').decode(errors='replace'); raw=s.get_data()
        ins = s.VirtualAddress<=ep<s.VirtualAddress+max(s.Misc_VirtualSize,s.SizeOfRawData)
        # window entropy 64KB
        W=65536; ws=[ent(raw[i:i+W]) for i in range(0,len(raw),W)] if raw else []
        lo=sum(1 for e in ws if e<6.5); hi=sum(1 for e in ws if e>7.9)
        print(f"{n:7} VA={s.VirtualAddress:#09x} VS={s.Misc_VirtualSize:#09x} RAW={s.SizeOfRawData:#09x} flags={s.Characteristics:#010x} H={ent(raw):.3f} win64k n={len(ws)} min={min(ws,default=0):.2f} max={max(ws,default=0):.2f} <6.5:{lo} >7.9:{hi} {'<-EP' if ins else ''}")
    print(f"EP RVA={ep:#x}")
    print("DataDirs:",[(dd.name.replace('IMAGE_DIRECTORY_ENTRY_',''),hex(dd.VirtualAddress),hex(dd.Size)) for dd in oh.DATA_DIRECTORY if dd.Size])
    for e in getattr(pe,'DIRECTORY_ENTRY_IMPORT',[]):
        print(" IMP",e.dll.decode(),[ (i.name or b'#%d'%i.ordinal).decode() for i in e.imports])
    if hasattr(pe,'DIRECTORY_ENTRY_TLS'):
        t=pe.DIRECTORY_ENTRY_TLS.struct; print(" TLS callbacks@",hex(t.AddressOfCallBacks))
    print(" overlay:", len(d)-pe.get_overlay_data_start_offset() if pe.get_overlay_data_start_offset() else 0)
    print(" Rich:", [(x) for x in (pe.parse_rich_header() or {}).get('values',[])][:40])
