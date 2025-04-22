#!/bin/env raku

unit sub MAIN(Str:D $s);

put $s.comb(/(<[a..z]>) $0 $0+/);
