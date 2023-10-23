#!/usr/bin/env raku

my &running-sum = { [\+] @_ };

multi MAIN (Bool :test($)!) {
    use Test;
    is running-sum(1 ... 5), (1, 3, 6, 10, 15);
    is running-sum(1 xx 5), (1..5);
    is running-sum(0,-1,1,2), (0,-1,0,2);
    done-testing;
}

multi MAIN (*@int) {
    put running-sum @int
}
