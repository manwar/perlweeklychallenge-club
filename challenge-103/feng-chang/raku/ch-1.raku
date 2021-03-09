#!/bin/env raku

my @animals  = <Rat Ox Tiger Rabbit Dragon Snake Horse Goat Monkey Rooster Dog Pig>;
my @elements = <Wood Fire Earth Metal Water>;

sub MAIN(UInt:D \Year) {
    put @elements[(Year + 4) % 5], ' ', @animals[(Year + 8) % 12];
}
