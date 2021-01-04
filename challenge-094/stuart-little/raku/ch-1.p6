#!/usr/bin/env perl6
use v6;

# run as <script> <space-separated words>

for @*ARGS.classify(*.comb.Bag).values {.say}
