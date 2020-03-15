#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

my @intervals;
for my $arg (@ARGV) {
    $arg =~ /\[ (\d+) , (\d+) \] ,?/gmx;
    push @intervals,  [$1, $2];
}

my $size = scalar @intervals;
my @merged;

for (my $i = 0; $i < $size - 1; $i++) {
    my $start = $intervals[$i]->[0];
    my $end = $intervals[$i]->[1];

    while ($i < $size - 1 &&
    $end >= $intervals[$i + 1]->[0] && $end <= $intervals[$i + 1]->[1]) {
        $end = $intervals[$i + 1]->[1];
        $i++;
    }

    push @merged, [$start, $end];
}

say join ', ', map { "[$_->[0],$_->[1]]" } @merged;
