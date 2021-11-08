#!/usr/bin/env perl
use warnings;
use v5.12;

# run <script> <number>

use feature qw(signatures);
no warnings qw(experimental::signatures);

use POSIX qw(ceil);

($ARGV[0] =~ /^9+$/) && do {
    say $ARGV[0]+2;
    exit;
};

my $nrDig = length $ARGV[0];

sub doubleUp($nrDig,$initHalf) {
    return $initHalf . (($nrDig % 2) ? (scalar reverse substr($initHalf, 0,-1)) : (scalar reverse $initHalf))
}

my $initHalf = substr($ARGV[0], 0, ceil($nrDig/2));

say((int(doubleUp($nrDig,$initHalf)) > int($ARGV[0])) ? (doubleUp($nrDig,$initHalf)) : (doubleUp($nrDig,$initHalf+1)));
