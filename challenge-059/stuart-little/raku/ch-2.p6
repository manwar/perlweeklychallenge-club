#!/usr/bin/env perl6
use v6;

say @*ARGS.map(*.Int).combinations(2).map({ ($_[0] +^ $_[1]).base(2).comb.grep(1).elems }).sum

# run as <script> <space-separated numbers>
