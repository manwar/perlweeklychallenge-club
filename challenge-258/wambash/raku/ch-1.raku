#!/usr/bin/env raku

sub count-even-digits-number (+ints) {
    ints
    andthen .map: *.codes %% 2
    andthen .sum
}

multi MAIN (Bool :test($)!) {
    use Test;
    is count-even-digits-number(10,1,111,24,1000),3;
    is count-even-digits-number(111,1,11111),0;
    is count-even-digits-number(2,8,1024,256),1;
    done-testing;
}

multi MAIN (+ints) {
    say count-even-digits-number ints
}
