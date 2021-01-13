#!/usr/bin/env perl6

my \open = True;

my @doors = open xx 500;

for 1 .. 500 -> $emp {
    NEXT {
        for $emp, $emp*2 ... 500 -> $door {
            @doors[$door-1] ?^= open;
        }
    }

    say $emp if @doors[$emp-1];
}
