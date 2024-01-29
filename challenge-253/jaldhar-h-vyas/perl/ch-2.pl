#!/usr/bin/perl
use 5.030;
use warnings;

my @matrix = map { [ map { 0 + $_ } split /\s+/ ] } @ARGV;
my %ones;

while (my ($key, $row) = each @matrix) {
    $ones{$key} = scalar grep { $_ == 1 } @{$row};
}

say q{(},
    (join q{, }, sort { $ones{$a} <=> $ones{$b} || $a <=> $b } keys %ones),
    q{)};
