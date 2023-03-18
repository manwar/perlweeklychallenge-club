#!/bin/env raku

unit sub MAIN(*@N where @N.all ~~ UInt);

put ((0..+@N) (-) @N».UInt).keys.sort;
