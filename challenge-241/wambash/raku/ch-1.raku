#!/usr/bin/env raku

sub arithmetic-triplets (+nums, :$diff) {
    my $num-set = nums.Set;

    nums.grep: { ($_, $_ + $diff, $_ + (2*$diff)) ⊆ $num-set }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is arithmetic-triplets(0,1,4,6,7,10):3diff,(1,4);
    is arithmetic-triplets(4,5,6,7,8,9):2diff, (4,5);
    is arithmetic-triplets(1,2,3,4,5,6):2diff, (1,2);
    done-testing;
}

multi MAIN (+nums, :$diff) {
    say +arithmetic-triplets nums>>.Int, :$diff
}
