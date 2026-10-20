# Runtime notes

## Wine

- Prefix `/workspace/wine/windbot`, win32
- Needs `libGL.so.1` **i386** + VC++2010
- Launch via `wine explorer /desktop=tib,800x600 Tibia.exe` improves windowing
- WindBot starts and presents Authentication dialog; no further interaction

## Client

Main menu screenshot captured; Enter Game automation under Xvfb/DirectDraw was
unreliable (clicks often miss custom-drawn menu). Protocol TCP path to TFS
verified separately.

## Auth dialog

***REMOVED***
`auth.tibiawindbot.com` is the licence host (forum username/password). No live session was opened against it in this study; the dialog title and error strings are the observed evidence.
