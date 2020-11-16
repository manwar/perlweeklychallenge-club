#!/usr/bin/env perl6
use v6;

try {
    say @*ARGS[0].Real/@*ARGS[1].Real;
}

($!) && say "Tried to divide by 0, eh?"

# run as <script> <numerator> <denominator>

