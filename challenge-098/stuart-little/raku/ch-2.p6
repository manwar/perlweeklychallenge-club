#!/usr/bin/env perl6
use v6;

# run <script> <target> <space-separated array entries>

my @nrs = @*ARGS.map(*.Int);
say @nrs[1..*].grep(* < @nrs[0]).elems
