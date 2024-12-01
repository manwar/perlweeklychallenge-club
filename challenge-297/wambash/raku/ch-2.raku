#!/usr/bin/env raku

sub semi-ordered (+@ints) {
    @ints
    andthen .min(:k),.max(:k), .end
    andthen -> (($min,),($max,), $end) { $min + $end - $max - ($max < $min) }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is semi-ordered(2, 1, 4, 3),2;
    is semi-ordered(2, 4, 1, 3),3;
    is semi-ordered(1, 3, 2, 4, 5),0;
    done-testing;
}

multi MAIN (+ints) {
    say semi-ordered ints
}
