#!/usr/bin/env perl6
use v6;

sub consec(@a) {
    (^@a).combinations(2).grep({ (@a[$_[0]^..$_[1]] Z- @a[$_[0]..$_[1]]).all == 1 }).max({ $_[1] - $_[0] }).List
}

my @sorted=@*ARGS.map(*.Int).sort;
my @consec = (@sorted.&consec.grep(* ~~ Int)) ?? @sorted.&consec !! (());

say (@consec) ?? @sorted[@consec[0]..@consec[1]] !! 0

# run as <script> <space-separated array entries>
