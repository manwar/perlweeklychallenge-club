#!/usr/bin/env perl6
use v6;

say (1..@*ARGS[0].Int).combinations(2).map({ $_[0] gcd $_[1] }).sum

# run as <script> <number>
