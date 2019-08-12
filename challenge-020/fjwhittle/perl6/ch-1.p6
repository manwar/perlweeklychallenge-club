#!/usr/bin/env perl6

unit sub MAIN(Str $string);

my Str @split = $string.comb: / (.) $0 * /;

@split».put
