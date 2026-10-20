# Runtime notes

## Wine

- Prefix `/workspace/wine/windbot`, win32
- Needs `libGL.so.1` **i386** + VC++2010
- Launch via `wine explorer /desktop=tib,800x600 Tibia.exe` improves windowing
- WindBot starts and presents the Authentication dialog

## Client

Main menu screenshot captured. Early Xvfb sessions missed DirectDraw menu clicks;
later sessions completed Enter Game after correcting coordinates. Protocol TCP
path to TFS verified; full login (MOTD → char list → in game) completed on the
patched 10.76 client.

## Auth dialog

`auth.tibiawindbot.com` is the licence host (forum username/password). No live
session was opened against it in this study; the dialog title and error strings
are the observed evidence.
