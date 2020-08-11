#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

my @N = (2, 7, 9, 2, 7, 4);
my $k = 2;

my %in_array;
push @{ $in_array{ $N[$_] } }, $_ for 0 .. $#N;

for my $n (0 .. $#N) {
    if (my $found = $in_array{ $N[$n] + $k }) {
        say "$_, $n" for @$found;
    }
}
