#!/usr/bin/env raku

sub summations (+@n) {
    @n, { [\+] .skip  } ...^ :!elems
    andthen .tail.head
}

multi MAIN (Bool :test($)!) {
    use Test;
    is summations(1,2,3,4,5), 42;
    is summations(1,3,5,7,9), 70;
    done-testing;
}

multi MAIN (*@n) {
    say summations @n
}
