#!/usr/bin/env raku

my $gapful=(100..Inf).grep({$_%% .comb[0,*-1].join.Int});
put $gapful[0..19];
