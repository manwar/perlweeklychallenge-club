#!/usr/bin/env raku

sub count-smaller (+nums) {
    nums.map: {
        $_ X> nums
        andthen .sum
    }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is count-smaller(8,1,2,2,3),(4,0,1,1,3);
    is count-smaller(6,5,4,8),(2,1,0,3);
    is count-smaller(2,2,2),(0,0,0);
    done-testing;
}

multi MAIN (+nums) {
    put count-smaller nums
}
