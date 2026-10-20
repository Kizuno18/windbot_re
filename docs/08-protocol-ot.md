# Local OT stack

| Piece | Detail |
| --- | --- |
| Server | otland/forgottenserver tag `v1.1` |
| Protocols | `CLIENT_VERSION_MIN/MAX` 1076–1077 |
| Ports | login 7171, game 7172 |
| DB | MariaDB schema from `schema.sql` |
| Build fixes | Disabled `-Werror`; cast `posix_time::seconds`; force `liblua5.2` over LuaJIT |

Junk TCP payload → ASCII reject mentioning protocol 10.77 (`CLIENT_VERSION_STR`).
