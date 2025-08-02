#!/usr/bin/env raku

multi consecutive-one-producer ($acc,0 --> 0) {}
multi consecutive-one-producer ($acc,1 --> Int:D) {$acc + 1}

sub consecutive-one (+binary) {
    binary
    andthen .produce: &consecutive-one-producer
    andthen .max
}

multi MAIN (Bool :test($)!) {
    use Test;
    is consecutive-one(0,1,1,0,1,1,1), 3;
    is consecutive-one(0 xx 4), 0;
    is consecutive-one(1,0,1,0,1,1), 2;
    done-testing;
}

multi MAIN (+binary) {
    say consecutive-one binary;
}
