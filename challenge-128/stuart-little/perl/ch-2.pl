#!/usr/bin/env perl
use warnings;
use v5.12;

# run <script> <starting arrivals followed by departures, all space-separated>

use List::Util qw(sum0 zip);

my @times = sort {$a->[0] cmp $b->[0]} map { [$_->[0], $_->[1] % int((scalar @ARGV)/2)] } zip \@ARGV, [0..scalar @ARGV-1];
my $sol=0;
my @station = (0) x int((scalar @ARGV)/2);

for (@times) {
    $station[$_->[1]]^=1;
    ((sum0 @station) > $sol) && do {$sol = sum0 @station};
}

say $sol;
