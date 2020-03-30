#!/usr/bin/perl
# Test: ./ch-1.pl 3 4
use strict;
use warnings;
use feature qw /say/;
use Algorithm::Combinatorics qw(permutations);

my $n = $ARGV[0];
my $k = $ARGV[1];

my @data = 1 .. $n;
my @all_permutations = permutations(\@data);
say join '', @{$all_permutations[$k - 1]};
