#!/bin/env raku

unit sub MAIN(*@N);

put @N.combinations(2).map({ .[0] +^ .[1] }).max;
