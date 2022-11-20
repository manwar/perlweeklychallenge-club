#!/bin/env raku

unit sub MAIN(*@N);

my \m = @N.max;
put @N.grep(!(* == m)).any * 2 > m ?? -1 !! 1;
