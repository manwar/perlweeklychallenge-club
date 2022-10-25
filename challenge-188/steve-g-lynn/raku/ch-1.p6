#!/usr/bin/env perl6

say &divisible_pairs(2,(4,5,1,6)); #2
say &divisible_pairs(2,(1,2,3,4)); #2
say &divisible_pairs(3,(1,3,4,5)); #2
say &divisible_pairs(4,(5,1,2,3)); #2
say &divisible_pairs(4,(7,2,4,5)); #1

sub divisible_pairs($k, @test) {
    (0 .. @test-1).combinations(2).grep({@test[$_].sum %% $k}).elems    
}


