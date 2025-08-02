#!/bin/env raku

unit sub MAIN(*@ints);

my \k = @ints.pop;
put (k, 2*k, 4*k ... *).first({ ! @ints.grep($_) });
