#!/usr/bin/env perl6
use v6;

# run <script> <path-to-file> <number>

say @*ARGS[0].IO.slurp.substr(0,@*ARGS[1].Int)
