#!/usr/bin/perl

# Challenge 214
#
# Task 2: Collect Points
# Submitted by: Mohammad S Anwar
#
# You are given a list of numbers.
#
# You will perform a series of removal operations. For each operation, you
# remove from the list N (one or more) equal and consecutive numbers, and
# add to your score N × N.
#
# Determine the maximum possible score.
# Example 1:
#
# Input: @numbers = (2,4,3,3,3,4,5,4,2)
# Output: 23
#
# We see three 3's next to each other so let us remove that first and
# collect 3 x 3 points.
# So now the list is (2,4,4,5,4,2).
# Let us now remove 5 so that all 4's can be next to each other and
# collect 1 x 1 point.
# So now the list is (2,4,4,4,2).
# Time to remove three 4's and collect 3 x 3 points.
# Now the list is (2,2).
# Finally remove both 2's and collect 2 x 2 points.
# So the total points collected is 9 + 1 + 9 + 4 => 23.
#
# Example 2:
#
# Input: @numbers = (1,2,2,2,2,1)
# Output: 20
#
# Remove four 2's first and collect 4 x 4 points.
# Now the list is (1,1).
# Finally remove the two 1's and collect 2 x 2 points.
# So the total points collected is 16 + 4 => 20.
#
# Example 3:
#
# Input: @numbers = (1)
# Output: 1
#
# Example 4:
#
# Input: @numbers = (2,2,2,1,1,2,2,2)
# Output: 40
#
# Remove two 1's = 2 x 2 points.
# Now the list is (2,2,2,2,2,2).
# Then reomove six 2's = 6 x 6 points.

use Modern::Perl;

sub remove_numbers {
    my(@in) = @_;
    return scalar(@in) if @in < 2;
    my $best_score = 0;
    for (my $s = 0; $s < @in; $s++) {
        my $e = $s;
        while ($e < @in && $in[$s]==$in[$e]) {
            $e++;
        }
        my @new_list = (@in[0..$s-1], @in[$e..$#in]);
        my $score = ($e-$s)*($e-$s) + remove_numbers(@new_list);
        $best_score = $score if $best_score < $score;
        $s = $e-1;
    }
    return $best_score;
}

say remove_numbers(@ARGV);
