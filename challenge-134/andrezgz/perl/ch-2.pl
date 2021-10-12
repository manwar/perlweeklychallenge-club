#!/usr/bin/perl

# https://theweeklychallenge.org/blog/perl-weekly-challenge-134/
# Task #2
#
# You are given 2 positive numbers, $m and $n.
#
# Write a script to generate multiplcation table and display count of distinct terms.
#
# Example 1
# Input: $m = 3, $n = 3
# Output:
#
#       x | 1 2 3
#       --+------
#       1 | 1 2 3
#       2 | 2 4 6
#       3 | 3 6 9
#
# Distinct Terms: 1, 2, 3, 4, 6, 9
# Count: 6
# Example 2
# Input: $m = 3, $n = 5
# Output:
#
#       x | 1  2  3  4  5
#       --+--------------
#       1 | 1  2  3  4  5
#       2 | 2  4  6  8 10
#       3 | 3  6  9 12 15
#
# Distinct Terms: 1, 2, 3, 4, 5, 6, 8, 9, 10, 12, 15
# Count: 11

use strict;
use warnings;
use feature 'say';

my $m = shift // 3;
my $n = shift // 3;

say sprintf ' x |' . '%3d' x $n, 1..$n;
say         '---|' . '---' x $n;
my %unique;
for my $row (1..$m) {
    my @mult = map { $row * $_ } 1..$n;
    @unique{@mult} = (undef) x @mult;
    say sprintf '%2d |' . '%3d' x @mult, $row, @mult;
}

say 'Distinct Terms: ' . join ',', sort {$a <=> $b} keys %unique;
say 'Count: ' . scalar keys %unique;

__END__

$ ./ch-2.pl 3 3
 x |  1  2  3
---|---------
 1 |  1  2  3
 2 |  2  4  6
 3 |  3  6  9
Distinct Terms: 1,2,3,4,6,9
Count: 6

$ ./ch-2.pl 3 5
 x |  1  2  3  4  5
---|---------------
 1 |  1  2  3  4  5
 2 |  2  4  6  8 10
 3 |  3  6  9 12 15
Distinct Terms: 1,2,3,4,5,6,8,9,10,12,15
Count: 11
