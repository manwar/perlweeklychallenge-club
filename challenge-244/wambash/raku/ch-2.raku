#!/usr/bin/env raku

sub group-hero (+nums) {
    nums
    andthen .combinations
    andthen .skip
    andthen .map: { .max² * .min }\
    andthen .sum
}

multi MAIN (Bool :test($)!) {
    use Test;
    is group-hero(2,1,4),141;
    done-testing;
}

multi MAIN (+nums) {
    say group-hero nums
}
