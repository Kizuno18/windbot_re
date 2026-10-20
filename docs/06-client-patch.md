# Client IP/RSA patch

Same tool and 10.76 offsets as [ibot_re docs/09-client-patch.md](https://github.com/Kizuno18/ibot_re/blob/main/docs/09-client-patch.md)
(sibling repo). Summary:

- RSA @ `0x3885a0` → TFS public modulus (309 digits)
- Login hosts → `127.0.0.1` NUL-padded
- Patched SHA256: `addb0da28b85d338a180375bde1359bcfba0e4d3a65db233537f3f89495917e0`
