#!perl6
# Task 1 Challenge 056 Solution by kevincolyer
# Diff-K
# You are given an array @N of positive integers (sorted) and another 
# non negative integer k.
# Write a script to find if there exists 2 indices i and j such 
# that A[i] - A[j] = k and i != j.
# It should print the pairs of indices, if any such pairs exist.
# Example:
#     @N = (2, 7, 9)    $k = 2
# Output : 2,1


sub findIndiceDiff(@N, $k) {
    for ^(@N.elems-1) -> $j {
        for $j+1..^@N.elems -> $i {
            next if $i == $j;
            # Returns solution if found
            return $i,$j if @N[$i]-@N[$j] == $k;
            # abort if diff is >k as will never get less...
            last if @N[$i]-@N[$j] > $k;
        }
    }
    # fail
    return 0,0;
}

use Test;
is findIndiceDiff( (2,7,9), 2 ), (2,1), "Example solved";
is findIndiceDiff( (2,7,9), 3 ), (0,0), "Example should not solve";
is findIndiceDiff( (2,7,9), 5 ), (1,0), "Example modified solved";
is findIndiceDiff( (2,3,4,5,6,7,14), 7 ), (6,5), "Longer Example modified solved";
