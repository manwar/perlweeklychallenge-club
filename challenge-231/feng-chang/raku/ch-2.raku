#!/bin/env raku

unit sub MAIN(*@P);

put +@P.grep(*.substr(11, 2) ≥ 60);
