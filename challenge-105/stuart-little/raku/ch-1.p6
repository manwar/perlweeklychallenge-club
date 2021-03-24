#!/usr/bin/env perl6
use v6;

# run <script> <exponent> <number>

sub nthRoot($exp,$nr) {
    my $rootFloor = (1...{($_+1) ** $exp > $nr}).[*-1];
    return ($rootFloor ** $exp == $nr) ?? ($rootFloor) !! (exp ((log $nr)/$exp))
}

say nthRoot(|@*ARGS[0,1]);
