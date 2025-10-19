#!/bin/env raku

unit sub MAIN(Str:D $s where *.comb.all eq 0|1);

put (1..$s.chars-1).map({ +$s.substr(0,$_).comb.grep(/0/) + $s.substr($_).comb.sum }).max;
