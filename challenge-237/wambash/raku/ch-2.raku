#!/usr/bin/env raku
use v6.e.PREVIEW;


sub maximise-greatness (+nums) {
    my @sorted = nums.sort;
    my @snip-func = @sorted.map: { * ≤ $_ }

    @sorted
    andthen .snip: |@snip-func
    andthen .skip
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is maximise-greatness(1,3,5,2,1,3,1),4;
    is maximise-greatness(1,2,3,4),3;
    my @nsg = (1..10).map: {slip $_ xx $_ };
    is maximise-greatness(@nsg), 45;
    done-testing;
}

multi MAIN (*@nums) {
    say maximise-greatness @nums
}
