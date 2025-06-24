#!/bin/env raku

unit sub MAIN(*@ints);

@ints .= sort;
my $min-diff = @ints.rotor(2 => -1).map({ -[-] $_ }).min;
put @ints.rotor(2 => -1).map({ "[{.join(',')}]" if (-[-] $_) == $min-diff }).join(', ');
