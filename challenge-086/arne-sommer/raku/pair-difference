#! /usr/bin/env raku

unit sub MAIN (Int $A, *@N where @N.elems >= 2 && all(@N) ~~ Int);

say + so any( @N.combinations(2).map({ abs([-] @$_) }) ) == $A;
