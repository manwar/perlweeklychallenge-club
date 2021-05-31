#!/usr/bin/perl
use 5.020;
use warnings;

my $N = shift // die "Need integer argument\n";
my $rightmostOneBit = $N & -$N;
my $nextHigherOneBit = $N + $rightmostOneBit;
my $rightOnesSequence = $N ^ $nextHigherOneBit;

$rightOnesSequence /= $rightmostOneBit;
$rightOnesSequence >>= 2;

say $nextHigherOneBit | $rightOnesSequence;
