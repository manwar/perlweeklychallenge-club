#!/usr/bin/env raku

sub separate-digits (+ints) {
    ints.map: |*.comb
}

multi MAIN (Bool :test($)!) {
    use Test;
    is separate-digits(1,34,5,6),(1,3,4,5,6);
    is separate-digits(1,24,51,60),(1,2,4,5,1,6,0);
    done-testing;
}

multi MAIN (+ints) {
    put separate-digits ints
}
