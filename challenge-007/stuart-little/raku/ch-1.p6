#!/usr/bin/env perl6
use v6;

say 0;
for (1..(@*ARGS[0] || 50).Int).grep({ $_ %% $_.comb.sum }) {.say}

# run as <script> <upper bound> or just <script> to default to range <1..50>
