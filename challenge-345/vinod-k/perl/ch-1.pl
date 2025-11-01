#!/usr/bin/perl

###################################################################################
#You are given an array of integers, @ints.
#
#Find all the peaks in the array, a peak is an element that is strictly greater 
#than its left and right neighbours. Return the indices of all such peak positions.
###################################################################################

use strict;
use warnings;

sub find_peaks {
    my @ints = @_;
    my @peaks;
    for my $i (0..$#ints) {
        my $left  = ($i == 0 ) ? -1 : $ints[$i-1];
        my $right = ($i == $#ints) ? -1 : $ints[$i+1];
        if ($ints[$i] > $left && $ints[$i] > $right) {
            push @peaks, $i;
        }
    }
    return @peaks;
}

# Examples
my @examples = (
    [1, 3, 2],
    [2, 4, 6, 5, 3],
    [1, 2, 3, 2, 4, 1],
    [5, 3, 1],
    [1, 5, 1, 5, 1, 5, 1],
);

foreach my $ex (@examples) {
    my @peaks = find_peaks(@$ex);
    print "Input: (@$ex)\n";
    print "Output: (", join(", ", @peaks), ")\n\n";
}
