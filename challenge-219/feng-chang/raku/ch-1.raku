#!/bin/env raku

unit sub MAIN(*@N where @N.all ~~ Int);

put @N.map(*²).sort.join(', ');
