#!/usr/bin/perl
use strict;
use warnings;

###################################################################################
#You are given an integer array @ints where each element is either a positive 
#integer or -1.
#
#We process the array from left to right while maintaining two lists:
#
#@seen: stores previously seen positive integers (newest at the front)
#@ans: stores the answers for each -1
#Rules:
#
#If $ints[i] is a positive number -> insert it at the front of @seen
#If $ints[i] is -1:
#Let $x be how many -1s in a row we’ve seen before this one.
#
#If $x < len(@seen) -> append seen[x] to @ans
#
#Else -> append -1 to @ans
#
#At the end, return @ans.
###################################################################################

sub process_ints {
    my @ints = @_;
    my @seen;
    my @ans;
    my $run = 0;

    for (my $i = 0; $i < @ints; $i++) {
        if ($ints[$i] == -1) {
            my $x = 0;
            my $j = $i - 1;
            while ($j >= 0 && $ints[$j] == -1) {
                $x++;
                $j--;
            }
            if ($x < @seen) {
                push @ans, $seen[$x];
            } else {
                push @ans, -1;
            }
        } else {
            unshift @seen, $ints[$i];
        }
    }
    return @ans;
}

# Example
my @examples = (
    [5, -1, -1],            # Output: (5, -1)
    [3, 7, -1, -1, -1],     # Output: (7, 3, -1)
    [2, -1, 4, -1, -1],     # Output: (2, 4, 2)
    [10, 20, -1, 30, -1, -1], # Output: (20, 30, 20)
    [-1, -1, 5, -1],        # Output: (-1, -1, 5)
);

foreach my $ex (@examples) {
    my @ans = process_ints(@$ex);
    print "Input: (@$ex)\n";
    print "Output: (", join(", ", @ans), ")\n\n";
}
