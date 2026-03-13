#!/bin/env raku

unit sub MAIN(Str:D $s);

put $s.trans(<G () (al)> => <G o al>);
