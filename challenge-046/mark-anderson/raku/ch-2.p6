#!/usr/bin/env perl6

my \open = True;

my @doors = open xx 500;

for 2 .. 500 -> $emp {
    for $emp, $emp*2 ... 500 -> $door {
        @doors[$door-1] ?^= open;
    }
}

for 1 .. 500 -> $door {
    say $door if @doors[$door-1];
}
