#!/bin/env raku

unit sub MAIN(*@N where .all ~~ UInt);

put @N.sum %% +@N ??
    (^+@N).map({ abs((@N[$_] - @N.sum div +@N) * ($_ - (+@N - 1) / 2)) }).sum !!
    -1;
