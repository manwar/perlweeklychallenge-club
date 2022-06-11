#!/usr/bin/env raku

my @given-perms = $*IN.get.split(', ');

'PERL'.comb.permutations.map(*.join) (-) @given-perms andthen .keys.sort.join(', ').say;

