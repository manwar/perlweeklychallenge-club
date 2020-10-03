#!/usr/bin/perl

use strict;
use warnings;

die "usage: ./ch-2.pl [space seperated numbers]\n"
    unless scalar @ARGV;

my $candies = scalar @ARGV;

# Handle first & last index.
$candies++ if $ARGV[0] > $ARGV[1];
$candies++ if $ARGV[$#ARGV] > $ARGV[$#ARGV - 1];

foreach my $index (1 ... $#ARGV - 1) {
    $candies++ if $ARGV[$index] > $ARGV[$index - 1];
    $candies++ if $ARGV[$index] > $ARGV[$index + 1];
}

print "$candies\n";
