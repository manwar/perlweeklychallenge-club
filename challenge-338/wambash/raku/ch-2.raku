#!/usr/bin/env raku

sub max-distance (@arr1, @arr2) {
    my ($min1,$max1) = @arr1.minmax.bounds;
    my ($min2,$max2) = @arr2.minmax.bounds;
    ($max1-$min2) max ($max2 - $min1)
}

multi MAIN (Bool :test($)!) {
    use Test;
    is max-distance((4,5,7),(9,1,3,4)), 6;
    is max-distance((2,3,5,4),(3,2,5,5,8,7)), 6;
    is max-distance((2,1,11,3),(2,5,10,2)), 9;
    is max-distance((1...3),(3...1)), 2;
    is max-distance((1,0,2,3),(5,0)), 5;
    done-testing;
}

multi MAIN ($arr1, $arr2) {
    say max-distance $arr1.comb(/\d+/), $arr2.comb(/\d+/);
}
