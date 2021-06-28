#!/usr/bin/env raku

use Test;
plan 3;

is seq(5),    13;
is seq(10),   32;
is seq(60), 2223;

sub seq($N where * > 0)
{
    (1..*).grep(/ ^ (<[123]>+) $ <!{ $0 ~~ /11/ }> /)[$N-1]
}
