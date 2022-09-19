#!/usr/bin/raku

#raku has a built-in compose operator (infix o)

sub f($x) {$x+1}
sub g($x) {$x*3}

my &h = &g o &f;

say &h(5); #-- 18


