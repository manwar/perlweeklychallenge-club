#!/bin/env raku

unit sub MAIN(*@N where @N.elems ≥ 3);

put @N.combinations(3).map({ [*] $_ }).max;
