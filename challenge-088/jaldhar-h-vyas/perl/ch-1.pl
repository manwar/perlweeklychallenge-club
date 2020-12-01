#!/usr/bin/perl
use 5.020;
use warnings;

my @N = @ARGV;

my $sum = 1;
for my $e (@N) {
    $sum *= $e;
}

my @M = map { $sum / $N[$_] } 0 .. scalar @N - 1;

say join q{, }, @M;
