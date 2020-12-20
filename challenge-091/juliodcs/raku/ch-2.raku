#! /usr/bin/env raku

my @N := @*ARGS>>.Int;

multi advance($pos where * == @N.elems.pred) { 1 }
multi advance($pos where * >= @N.elems     ) { 0 }
multi advance($pos where @N[$pos] == 0)      { 1 }
multi advance($pos = 0)                      { advance $pos + @N[$pos] }

say advance;
