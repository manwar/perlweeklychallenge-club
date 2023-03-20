#!/bin/env raku

unit sub MAIN(*@N);

put @N.sort.combinations(4).grep({ .[0] + .[1] + .[2] == .[3] }).elems;
