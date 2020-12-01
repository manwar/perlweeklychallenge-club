#!/usr/bin/env perl6
use v6;

sub id($n) { (0..^$n).map({ |(0 xx $_), 1, |(0 xx ($n-$_-1)) }) }

for @*ARGS[0].Int.&id {.say}

# run as <script> <matrix size>
