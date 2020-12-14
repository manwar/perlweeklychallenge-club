#!/usr/bin/env perl6
use v6;

# run as <script> <number>

say @*ARGS[0].comb(/(\d)$0*/).map(*.comb).map({ $_.elems, $_[0] }).flat
