#!/usr/bin/env perl6
use v6;

# run as <script> <two numbers, space-separated>

sub eth_mult($a,$b) {
    ($a==1) ?? ($b) !!
    (eth_mult(($a div 2),2*$b) + (($a %% 2) ?? (0) !! ($b)))
}

say eth_mult(|@*ARGS[0,1].map(*.Int))
