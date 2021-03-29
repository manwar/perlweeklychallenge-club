#!/usr/bin/perl
use warnings;
use v5.12;

# run <script> <exponent> <number>

use feature qw(signatures);
no warnings qw(experimental::signatures);

sub nthRoot($exp,$nr) {
    my $rootFloor = 1;
    while (($rootFloor+1)**$exp <= $nr) {$rootFloor++};
    return ($rootFloor ** $exp == $nr) ? ($rootFloor) : (exp ((log $nr)/$exp))
}

say nthRoot(@ARGV[0,1]);
