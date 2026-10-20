#!/usr/bin/env python3
"""IP-changer style patch for Cipsoft Tibia 8.x–10.x C++ clients (research).

Replaces the login hostnames and the 309-digit Cipsoft RSA public modulus with
the classic OTServ/TFS public modulus (n = p*q from TFS 1.1 otserv.cpp).
Operates on a local Tibia.exe copy you already have; writes a new file next to it.
"""
from __future__ import annotations
import hashlib, re, sys

OT = (
    b"1091201329673994292788609605089955415282375029027981291234687579"
    b"3726629149257644633073969600111060390723088861007265581882535850"
    b"3429057592827629436413108566029093628212635953836686562675849720"
    b"6207862794310902180176810615217550567108238764764442605581471797"
    b"07119674283982419152118103759076030616683978566631413"
)
assert len(OT) == 309

HOSTS = [
    b"login01.tibia.com", b"login02.tibia.com", b"login03.tibia.com",
    b"login04.tibia.com", b"login05.tibia.com",
    b"tibia01.cipsoft.com", b"tibia02.cipsoft.com", b"tibia03.cipsoft.com",
    b"tibia04.cipsoft.com", b"tibia05.cipsoft.com",
]


def pad(host: bytes, slot: int) -> bytes:
    if len(host) >= slot:
        raise SystemExit(f"host too long for slot {slot}: {host!r}")
    return host + b"\x00" * (slot - len(host))


def main() -> None:
    src, dst, target = sys.argv[1], sys.argv[2], sys.argv[3].encode()
    data = bytearray(open(src, "rb").read())
    print(f"in  {src} sha256={hashlib.sha256(data).hexdigest()}")
    m = re.search(rb"[1-9]\d{308}", bytes(data))
    if not m:
        raise SystemExit("no 309-digit RSA modulus found")
    off = m.start()
    print(f"RSA @ {off:#x} was {bytes(data[off:off+32])}...")
    data[off : off + 309] = OT
    for h in HOSTS:
        start = 0
        while True:
            i = data.find(h, start)
            if i < 0:
                break
            end = i
            while end < len(data) and data[end] != 0:
                end += 1
            slot = max(end - i, len(h))
            data[i : i + slot] = pad(target, slot)
            print(f"host {h.decode()} @ {i:#x} slot={slot} -> {target.decode()}")
            start = i + slot
    open(dst, "wb").write(data)
    print(f"out {dst} sha256={hashlib.sha256(data).hexdigest()}")


if __name__ == "__main__":
    main()
