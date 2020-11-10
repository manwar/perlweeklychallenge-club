#!/usr/bin/env perl6
use v6;

sub concat_nrs(@a, $l) {
    (@a xx $l).reduce(&infix:<X~>)
    .grep({ $l==0 || $_.substr(0..0) ne '0' })
    .grep(*.chars == $l)
}

say @*ARGS[2..*].&concat_nrs(@*ARGS[0].Int).grep(*.Int < @*ARGS[1].Int)

# run as <script> <length> <upper bound> <space-separated list entries>
