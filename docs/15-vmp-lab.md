# VMProtect unpack path (windows-lab)

Repo: private [`Kizuno18/windows-lab`](https://github.com/Kizuno18/windows-lab). Relevant skill: `windows-lab-novmp` (NoVmp 1.0.6 via `/devirt/mcp`).

## Applicability to WindBot

| Check | WindBot 2.6.2 / 2.8.30 |
|---|---|
| Protector | VMProtect (`.vmp0` / `.vmp1`, high entropy) — yes |
| Bitness | **PE32 / x86** (Wine `win32`, `ImageBase 0x400000`) |
| NoVmp support | **x64 only** (`PE64`). Skill text: 32-bit targets are outside NoVmp's support. |

**Conclusion:** NoVmp on windows-lab cannot lift WindBot's VMProtect bytecode. A dump-first path (pe-sieve / x32dbg+Scylla on a live PID after auth) remains the lab-documented route for x86 VMP, followed by static analysis of the dump. That live attach was not run in this pass (Authentication dialog; no Windows RE VM session opened).

## What we already have without a dump
RTTI class map (`HookManager`, `EncryptedFastDllStream`, `IVirtualAllocationManager`, …), Lua API catalog, settings schema, auth string surface — see [10](10-rtti-architecture.md), [09](09-lua-api-catalog.md), [12](12-auth-protocol.md).
