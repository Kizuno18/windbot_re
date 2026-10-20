import pefile,struct,re,collections,json
import sys
p=sys.argv[1] if len(sys.argv)>1 else '../windbot/inst/app/code$MyConst.exe'
pe=pefile.PE(p); IB=0x400000; img=pe.get_memory_mapped_image()
def u32(va): return struct.unpack_from('<I',img,va-IB)[0]
def inimg(va): return IB<=va<IB+len(img)-4
# type descriptors
tds={}
for m in re.finditer(rb'\.\?A[VU][^\x00]{1,200}\x00',img):
    va=IB+m.start()-8; tds[va]=m.group()[:-1].decode('latin1')
# COLs: signature 0, offset, cdOffset, pTD, pCHD
cols={}
rd=[s for s in pe.sections if s.Name.startswith(b'.rdata')][0]
lo=IB+rd.VirtualAddress; hi=lo+rd.Misc_VirtualSize
for va in range(lo,hi-20,4):
    if u32(va)==0 and u32(va+12) in tds and inimg(u32(va+16)):
        cols[va]=(u32(va+4),u32(va+12),u32(va+16))
# vtables: pointer to COL followed by vtable
colset=set(cols); vt={}
for va in range(lo,hi-4,4):
    c=u32(va)
    if c in colset:
        n=0
        while n<400 and inimg(va+4+4*n):
            f=u32(va+4+4*n)
            if not (IB+0x1000<=f<IB+0x32f70c or IB+0xe4a000<=f<IB+0x1822000): break
            n+=1
        vt.setdefault(c,[]).append((va+4,n))
def demangle(s): return s[4:].rstrip('@').split('@')  # crude
res={}
for c,(off,td,chd) in cols.items():
    name=tds[td]
    nb=u32(chd+8); arr=u32(chd+12); bases=[]
    for i in range(min(nb,64)):
        bcd=u32(arr+4*i); bases.append(tds.get(u32(bcd),'?'))
    attr=u32(chd+4)
    for v,n in vt.get(c,[]):
        res.setdefault(name,[]).append(dict(vtable=hex(v),slots=n,thisoff=off,bases=bases[1:],attr=attr))
json.dump(res,open('rtti_2830.json','w'),indent=1)
print(len(tds),"TDs",len(cols),"COLs",sum(len(v) for v in res.values()),"vtables",len(res),"classes w/ vtable")
