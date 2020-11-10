#!/usr/bin/env perl6
use v6;

sub divs($a,$b) {
    (1..min($a,$b)).grep({ $a %% $_ && $b %% $_ })
}

say divs(|@*ARGS[0,1]);

# run as <script> num1 num2
