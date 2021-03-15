#!/usr/bin/env perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-097/
# TASK #2 › Binary Substrings

use 5.030;
use warnings;
use List::AllUtils qw(sum0 pairwise reduce);

my ($B, $S) = @ARGV;

# ($B, $S) = qw(101100101 3);
# ($B, $S) = qw(10110111 4);

length($B) % $S == 0
    or die "The length of the string '$B' must be a multiple of $S\n";

my @substrings = $B =~ /(.{$S})/g;

my (@distance, @flips);

# Calculate the distances between each pair of substrings and the total number
# of flips to change all of them to be equal to each one.
for my $i (0 .. $#substrings) {
    my @from = split //, $substrings[$i];
    for my $j (0 .. $#substrings) {
        my @to = split //, $substrings[$j];
        $distance[$i][$j] = sum0 pairwise {$a != $b} @from, @to;
    }
    $flips[$i] = sum0 @{$distance[$i]};
}

# Find the index of the substring which requires the minimum number of flips.
my $i = reduce {$flips[$a] < $flips[$b] ? $a : $b} 0 .. $#flips;

say "$flips[$i] to make all substrings equal to '$substrings[$i]' ($i)";
