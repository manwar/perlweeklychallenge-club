#!/usr/bin/env perl6
use v6;

# run <script> <number>

my %memo=(
    1 => [[1,],],
    2 => [[1,1],[2,]]
);

sub memoSteps($n) {
    (%memo{$n}:!exists) && do {
	%memo{$n} = (|memoSteps($n-1).map({ (1,|$_).Array }),|memoSteps($n-2).map({ (2,|$_).Array })).Array;	
    };
    return %memo{$n}.Array;
}

my @res = memoSteps(@*ARGS[0].Int);
say @res.elems;

for (@res) {
    .say;
}
