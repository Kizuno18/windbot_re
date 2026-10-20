# Static protection profile (VMProtect) — 2.6.2 vs 2.8.30

Scope: main binary `code$MyConst.exe` from each installer. Read-only, file-level analysis (pefile, capstone on entry bytes, `strings`). Script: [`tools/vmp_section_profile.py`](../tools/vmp_section_profile.py); raw output: [`artifacts/section_profile_2.6.2_vs_2.8.30.txt`](../artifacts/section_profile_2.6.2_vs_2.8.30.txt).

## Identity

| | 2.6.2 (client 10.76) | 2.8.30 (clients 10.00–10.47 line) |
|---|---|---|
| SHA256 | `5b8217d2c36880c1…41172b` | `756403d367e578ed…066be3` |
| Size | 11 777 536 | 15 796 736 |
| TimeDateStamp | `0x54F585F9` = 2015-03-03 | `0x59B7D9A1` = 2017-09-12 |
| Linker / Rich | 10.0 (VS2010, MSVCR100/MSVCP100) | 10.0 (VS2010) |
| PDB path | `Z:\WindBot\gui\Release\windbot.pdb` | `Z:\WindBot\gui2.0-tibia10\Release\windbot.pdb` |
| ImageBase / relocs | `0x400000`, no `.reloc` (stripped) | same |
| DllCharacteristics | `0x8100` (NX, TS-aware; no ASLR) | same |
| PE checksum | valid (`0xB3DF0D`) | valid (`0xF1DC8C`) |
| Overlay | none | none |

## Section table

| Section | flags | 2.6.2 VS / RAW / H | 2.8.30 VS / RAW / H |
|---|---|---|---|
| `.text` | `0x60000020` | `0x32715C` / **0** / — | `0x32E70C` / `0x32E800` / 6.62 |
| `.rdata` | `0x40000040` | `0x0DD364` / **0** / — | `0x0DEAD6` / `0x0DEC00` / 6.33 |
| `.data` | `0xC0000040` | `0xA39624` / **0** / — | `0xA3AB04` / `0x5E00` / 3.95 |
| `.vmp0` | `0xE0000060` (RWX) | `0xA94B2C` / **0** / — | `0x9D7065` / `0x9D7200` / 7.45 |
| `.tls` | `0xC0000040` | `0x18` / `0x200` / 0 | same |
| `.vmp1` | `0xE0000060` (RWX) | `0xAE0548` / `0xAE0600` / **8.00** | `0x0CB58E` / `0x0CB600` / 7.98 |
| `.rsrc` | `0x40000040` | `0x5A9EF` / `0x5AA00` / 3.54 | same size; identical resource payloads (6 icons, `IDI_ICON1`, manifest), section hash differs by data-entry RVAs |

Entry point: **`.vmp1`** in both (2.6.2 RVA `0x23A1E32`, 2.8.30 RVA `0x18912A5`).

### Windowed entropy (64 KiB)

| Section | 2.6.2 | 2.8.30 |
|---|---|---|
| `.vmp1` | 175 windows, median 8.00; 172 > 7.9. Tail windows `0x2397000` 7.80, `0x23A7000` 7.77, `0x23B7000` 5.05 (holds the EP and the loader/IAT/TLS/debug structures) | 13 windows, median 7.99, min 7.54 (`0x18E3000`) |
| `.vmp0` | no raw data | 158 windows, median 7.45, p10 7.31; one low window at `0xE5A000` (5.88) |
| `.text` | no raw data | max 6.72 (plain MSVC code) |
| `.rdata` | no raw data | median 5.49; three windows ≈ 7.95 at `0x350000`, `0x360000`, `0x400000` (embedded compressed data blobs, e.g. Qt resources/SQLite/Lua tables) |

## Reading of the layout

**2.6.2 — packed image.** `.text`, `.rdata`, `.data` and `.vmp0` have `SizeOfRawData = 0`: all original sections plus the VM section are reconstructed at load time from the `.vmp1` blob (H = 8.00, i.e. compressed). This is the VMProtect "Pack the output file" mode. The import directory (`0x1900844`), TLS directory, debug directory and load config all sit in the `.vmp1` tail, and the EP is in the low-entropy tail window. Statically, no RTTI, no Qt moc strings, no Lua registration names are visible (0 `.?AV` descriptors; only 19.6 k mostly random 6+ char strings, plus the import/name table and `.rsrc`).

**2.8.30 — unpacked layout.** Original `.text/.rdata/.data` are present in clear; `.vmp0` carries ~10 MB of virtualized/mutated code at H≈7.45 (VM bytecode + handlers, not compression); `.vmp1` is small (≈0.8 MB, H≈7.98) and holds the loader, the IAT (`0x1893000`) and stub structures. No packing; therefore RTTI, strings and registration tables are readable.

### Entry stub

| | first instructions (static disassembly of EP bytes) |
|---|---|
| 2.6.2 | `push ebp ; mov dword [esp], 0x800CE80 ; jmp 0x27A00E8` |
| 2.8.30 | `push 0xC71A663B ; mov dword [esp], 0x278CF867 ; call 0x1CE775C` |

Both follow the VMProtect pattern of pushing an encrypted VM-entry key (the first push is a junk/overwritten slot) and transferring to a VM entry in `.vmp*`.

### Residual imports

Both builds keep the VMProtect import-protection shape: **one decoy symbol per DLL** (`OPENGL32!glGetIntegerv`, `WS2_32!socket`/`WSAGetLastError`, one Qt5 mangled symbol per Qt module, `MSVCR100!remove`/`_acmdln`, …) plus a trailing loader block that is identical in both:

```
KERNEL32.dll: GetModuleHandleA, LoadLibraryA, LocalAlloc, LocalFree, GetModuleFileNameA, ExitProcess
```

DLL set (identical in both): OPENGL32, GDI32, USER32, DSOUND (ordinal 1 = `DirectSoundCreate`), WINMM, PSAPI (`GetModuleFileNameExW`), WS2_32, Qt5{OpenGL,Widgets,Gui,Core,Network,Svg}, KERNEL32, ADVAPI32, SHELL32, ole32, OLEAUT32, MSVCR100, MSVCP100, IPHLPAPI (`GetBestInterface`, consistent with MAC/adapter use in the hardware ID), VERSION. Only the chosen decoy symbol changes between builds. IAT size `0xDC` in both.

Other directories: an `EXPORT` directory entry (size `0xC50`) points into `.vmp*` with no name and no symbols (stub artifact); TLS callbacks pointer present in both (callback array in `.vmp1` region, part of the protector's early-init path).

### Code relocated into `.vmp0` (2.8.30)

The protector moved selected functions **and their RTTI/vtables** out of `.text/.rdata` into `.vmp0`. Type descriptors, complete-object locators and vtables for the licensing/injection classes live at `0x1263000–0x1266100`, and every vtable slot targets `.vmp0` (`0x124A3C0–0x124E510`); pure-virtual slots point to a shared `_purecall` at `0x1256838`:

| Class | vtable | slots (est.) | bases |
|---|---|---|---|
| `HookManager` | `0x1263004` | 5 | `IHookManager` |
| `IHookManager` | `0x1262FEC` | 5 (4 pure) | — |
| `VirtualAllocationManager<RealAllocationStrategy>` | `0x126301C` | 5 | `IVirtualAllocationManager` |
| `IVirtualAllocationManager` | `0x1262FD4` | 5 (4 pure) | — |
| `EncryptedFastDllStream` | `0x1262E68` | 2 | `IDllStream` |
| `MyActivationSource` | `0x1262D50` | 4 | `IUrlBuilderSource` |
| `IUrlBuilderSource` | `0x1262D3C` | 4 (3 pure) | — |
| `HardwareID::GetBlock_CC` | `0x12630E0` | 2 | `HardwareID::IGetBlock` |

The same region carries a CRT copy (`type_info`, `std::exception`, `bad_alloc`, FLS/`EncodePointer` init, locale tables) and native-API name strings used for dynamic resolution: `NtOpenFile`, `ZwCreateSection`, `ZwMapViewOfSection`, `NtUnmapViewOfSection`, `NtQuerySection`, `ZwQueryVirtualMemory`, `NtQueryAttributesFile`, `LdrFindResource_U`, `LdrAccessResource`, `LoadStringA/W`, plus `GetMemoryForDLL()`. These names match a section-based in-memory image mapper and resource redirection, consistent with the `EncryptedFastDllStream` → `VirtualAllocationManager` → `HookManager` chain (see [17](17-subsystem-map.md)). Strings by section in 2.8.30: `.vmp0` 11 302, `.rdata` 6 303, `.vmp1` 2 469, `.text` 1 021 (≥6 printable chars).

All other first-party classes (152 with vtables) keep RTTI and vtables in `.rdata` (`0x77B000–0x7A4000`) with methods in `.text` — i.e. GUI/engine code is largely not virtualized; protection is concentrated on licensing, HWID, DLL streaming and hooking.

## Version / family assessment

Public characteristics observed:

- Section names `.vmp0`/`.vmp1`, both `0xE0000060`, EP in `.vmp1`, `.tls` kept between them.
- Import protection with one decoy per DLL and the fixed `GetModuleHandleA/LoadLibraryA/LocalAlloc/LocalFree/GetModuleFileNameA/ExitProcess` loader block.
- `push imm32 ; mov [esp], imm32 ; call/jmp` VM entry at EP.
- Optional "pack output file" (2.6.2) vs not packed (2.8.30).
- RTTI of protected classes relocated alongside mutated code into `.vmp0`.

These fit the **VMProtect 2.x line (2.0x–2.13.x)**. 2.6.2 (built 2015-03) predates the VMProtect 3.0 release (2016) and is 2.x with packing on. 2.8.30 (2017-09) shows the same import-stub shape and loader import block as 2.6.2, which points to the same 2.x family with packing turned off; a VMProtect 3.0/3.1 build cannot be fully excluded from headers alone (the 3.x x86 output keeps the same section naming and EP shape). A signature scan (Detect It Easy library build without signature DB) returned no protector verdict for either file.

| Property | 2.6.2 | 2.8.30 |
|---|---|---|
| Packing | yes (all original sections in `.vmp1`) | no |
| `.vmp0` raw | 0 (materialized at load) | 9.8 MB, VM code |
| `.vmp1` raw | 11.4 MB (compressed image) | 0.8 MB (loader/IAT) |
| RTTI visible statically | no | yes (236 type descriptors) |
| Import stub shape | decoy-per-DLL + loader block | identical |
| Strings usable for mapping | `.rsrc` + import names only | full |

Consequence: static mapping of subsystems is done on 2.8.30; 2.6.2 is compared through its shipped plaintext tree (Lua libs, XML data) and the shared import/resource surface.
