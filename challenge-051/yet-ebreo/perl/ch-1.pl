#!/usr/bin/perl

# Given an array @Lof integers.
# Write a script to find all unique triplets such 
# that a + b + c is same as the given target T. Also make sure a <= b <= c.
# Here is wiki page for more information.
# Example:
# @L = (-25, -10, -7, -3, 2, 4, 8, 10);
# One such triplet for target 0 i.e. -10 + 2 + 8 = 0.

use strict;
use warnings;
use feature 'say';

#Solution from the wikipage
sub get_triplets {
    my ($list, $target) = @_;

    my @sorted = sort { $a - $b } @{$list};

    for my $i (0..@sorted-2) {
        my $a = $sorted[$i];
        my $start = $i + 1;
        my $end = @sorted - 1;

        while ($start < $end) {
            my $b = $sorted[$start];
            my $c = $sorted[$end];

            if ($a + $b + $c == $target) {
                say "$a $b $c";
                $start++;
                $end--;
            } elsif ($a + $b + $c > $target) {
                $end--;
            } else {
                $start++;
            }
        }
    }
}
my @L       = [25, -10, -7, -3, 2, 4, 8, 10];
my $target  = 0;
get_triplets(@L, $target);

=begin
perl .\ch-1.pl
-10 2 8
-7 -3 10
=cut