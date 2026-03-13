#!/usr/bin/env perl

use Modern::Perl;

my(@ints) = @ARGV;
my @smaller;
for my $i (0..$#ints) {
    push @smaller, scalar grep {$ints[$_] < $ints[$i]} 0..$#ints;
}
say "(", join(", ", @smaller), ")";
