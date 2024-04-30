#!/bin/env raku

unit sub MAIN(*@ints);

put @ints.any == 0 ?? 0 !! @ints.grep(*.sign == -1) %% 2 ?? 1 !! -1;
