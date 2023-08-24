#!/bin/env raku

unit sub MAIN(*@N where @N.all ~~ Int);

put(@N.grep(* != @N.min|@N.max) || -1);
