#!/usr/bin/perl

use strict;
use warnings;

die "usage: ./ch-2.pl <positive numbers>\n"
    unless scalar @ARGV >= 1;

my @nums = @ARGV;
@nums = sort { $a <=> $b} @nums;

die "ch-2.pl: input array of positive numbers\n"
    if $nums[0] <= 0;

print "0\n" and exit 0 if scalar @nums == 1;
print "1\n" and exit 0 if scalar @nums == 2;

# Multiplied by 2 because we'll subtract it once.
my $tmp = 2 * $nums[$#nums];
$tmp -= $_ foreach @nums;

print "1\n" and exit 0 if $tmp == 0;
print scalar @nums - 1, "\n" and exit 0 if $tmp > 0;

die "ch-2.pl: cannot solve\n";
