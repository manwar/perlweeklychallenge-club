#!/usr/bin/env perl6
use v6;

sub sum3($t, @a) {
    @a.combinations(3).grep({ $_.sum == $t })
}

say sum3(@*ARGS[0].Int, @*ARGS[1..*].map(*.Int));

# run as <script> <target> <space-separated array entries>
