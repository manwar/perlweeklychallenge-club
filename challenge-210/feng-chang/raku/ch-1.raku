#!/bin/env raku

unit sub MAIN(*@N where @N.all ~~ Int);

put @N.minmax.map(-> \m { @N.grep(-> \s { abs(m - s) ≤ 1 }).sum }).max;
