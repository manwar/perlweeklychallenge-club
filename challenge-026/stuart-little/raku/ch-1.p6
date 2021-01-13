#!/usr/bin/env perl6
use v6;

# run as <script> <stones jewels>

say @*ARGS[1].comb.grep({ @*ARGS[0].contains($_) }).elems
