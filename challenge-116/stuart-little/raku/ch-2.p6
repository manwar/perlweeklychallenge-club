#!/usr/bin/env perl6
use v6;

# run <script> <number>

my $digSqSum = @*ARGS[0].comb.map(*.Int ** 2).sum;
($digSqSum.sqrt.Int ** 2 == $digSqSum).Int.say;

