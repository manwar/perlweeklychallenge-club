#!/usr/bin/env raku

sub missing-numbers (+@list) {
    0 .. @list
    andthen $_ (-) @list
}

multi MAIN (Bool :test($)!) {
    use Test;
    is missing-numbers(0,1,3),2;
    is missing-numbers(0,1),2;
    done-testing;
}

multi MAIN (+@list) {
    say missing-numbers +@list
}
