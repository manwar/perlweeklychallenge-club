#!/usr/bin/perl
use 5.030;
use warnings;

my @nums = sort { $a <=> $b } @ARGV;
my $e = scalar @nums;

say "minimum:        ", $nums[0];
say "lower quartile: ", $e % 2 == 0 ? ($nums[$e / 4 - 1] + $nums[$e / 4]) / 2 : $nums[$e / 4];
say "median:         ", $e % 2 == 0 ? ($nums[$e / 2 - 1] + $nums[$e / 2]) / 2 : $nums[$e / 2];
say "upper quartile: ", $e % 2 == 0 ? ($nums[$e / 4 * 3 - 1] + $nums[$e / 4 * 3]) / 2 : $nums[$e / 4 * 3];
say "maximum:        ", $nums[-1];
