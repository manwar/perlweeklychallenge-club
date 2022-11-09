#!/bin/env raku

unit sub MAIN(Str:D \s);
put +so s eq s.lc.tc|s.lc|s.uc;
