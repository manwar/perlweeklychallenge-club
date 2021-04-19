#!/usr/bin/env perl6
use v6;

# run <script> <space-separated numbers>

sub difSums(@a) {
    (0,|@a,0).rotor(3 => -1).map(*.sum).Set
}

sub fmtOut(@a) {
    (zip ['a'..'g'], @a, :with({qq|$^a = $^b|})) .join(", ")
}

my @out = @*ARGS.map(*.Int).permutations.grep(-> @a { difSums(@a).elems == 1 });

(!@out) && do {
    say "No solution.";
    exit;
};

for (@out.map({qq|Solution: {fmtOut($_)}\nSum: {$_.[0,1].sum}\n|})) {.say};
