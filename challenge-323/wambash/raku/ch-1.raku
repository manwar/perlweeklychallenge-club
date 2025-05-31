#!/usr/bin/env raku

enum Operation (
    'x++' =>  1,
    '++x' =>  1,
    'x--' => -1,
    '--x' => -1,
);

sub increment-decrement (+operations) {
    operations
    andthen .map: { Operation::{$_} }\
    andthen .sum
}

multi MAIN (Bool :test($)!) {
    use Test;
    is increment-decrement(< --x x++ x++ >), 1;
    is increment-decrement(< x++ ++x x++ >), 3;
    is increment-decrement(< x++ ++x x-- --x >), 0;
    done-testing;
}

multi MAIN (+operations) {
    say increment-decrement operations;
}
