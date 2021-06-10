#!/usr/bin/env perl6
use v6;

# run <script> <number>

(@*ARGS[0] ~~ /^9+$/) && do {
    say @*ARGS[0].Int+2;
    exit;
};

my $nrDig = @*ARGS[0].chars;

sub doubleUp($nrDig,$initHalf) {
    return $initHalf ~ (($nrDig % 2) ?? (substr($initHalf, 0, *-1).flip) !! ($initHalf.flip))
}

my $initHalf = substr(@*ARGS[0], 0, ($nrDig/2).ceiling);

say((doubleUp($nrDig,$initHalf).Int > @*ARGS[0].Int) ?? (doubleUp($nrDig,$initHalf)) !! (doubleUp($nrDig,($initHalf.Int+1).Str)));
