#!/usr/bin/env perl6
use v6;

# run <script> <quoted string> <number>

say @*ARGS[0].trans(['A'..'Z'] => ['A'..'Z'].rotate(26-@*ARGS[1].Int))

