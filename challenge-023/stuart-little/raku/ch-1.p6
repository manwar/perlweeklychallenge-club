#!/usr/bin/env perl6
use v6;

sub dff(@a where {$_.all ~~ Int}) {
    @a.rotor(2 => -1).map({ $_[1] - $_[0] })
}

for (1..@*ARGS[0].Int).map({ reduce { $^b.($^a) }, @*ARGS[1..*].map(*.Int), |(&dff xx $_) }) {.say}

# run as <script> <number of difference iterations> <space-separated integer array entries>
