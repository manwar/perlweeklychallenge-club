#!/usr/bin/env raku

sub digit-count-value (+$_) {
    .pairs.Bag eqv .Bag
}

multi MAIN (Bool :test($)!) {
    use Test;
    is digit-count-value(1,2,1,0), True;
    is digit-count-value(0,3,0), False;
    done-testing;
}

multi MAIN (+ints) {
    say digit-count-value ints».Int
}
