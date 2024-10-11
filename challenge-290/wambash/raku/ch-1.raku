#!/usr/bin/env raku

sub double-exist (+ints) {
    ints.any
    andthen 2*$_ == $_
    andthen .so

}

multi MAIN (Bool :test($)!) {
    use Test;
    is double-exist(6,2,3,3), True;
    is double-exist(3,1,4,13),False;
    is double-exist(2,1,4,2), True;
    done-testing;
}

multi MAIN (+ints) {
    say double-exist ints
}
