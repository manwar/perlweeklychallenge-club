#!/usr/bin/perl
# test: ./ch2.pl
use strict;
use warnings;
use feature qw /say/;

my @list = (10, 4, 1, 8, 12, 3);
my @indices = (0, 2, 5);

# Create a sublist
my @sublist =
    sort {$a <=> $b} @list[@indices];

# Override the original array
my $i = 0;
for my $index (@indices) {
    $list[$index] = $sublist[$i++];
}

say join ',', @list;
