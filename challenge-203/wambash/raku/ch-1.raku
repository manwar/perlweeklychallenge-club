#!/usr/bin/env raku

sub special-quadruplets (+@nums) {
    @nums
    andthen .combinations(3)
    andthen .map: *.sum
    andthen .map: { |@nums.grep: * == $_ }\
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is special-quadruplets(1,2,3,6),1;
    is special-quadruplets(1,1,1,3,5),4;
    is special-quadruplets(3,3,6,4,5),0;
    done-testing;
}

multi MAIN (*@nums) {
    say special-quadruplets @nums
}
