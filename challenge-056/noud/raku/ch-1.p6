# Diff-K
#
# You are given an array @N of positive integers (sorted) and another non
# negative integer k.
#
# Write a script to find if there exists 2 indices i and j such that A[i] -
# A[j] = k and i != j.
#
# It should print the pairs of indices, if any such pairs exist.
#
# Example:
#
#    @N = (2, 7, 9)
#    $k = 2
#
# Output : 2,1

sub diff-k(@N, $k) {
    (^@N.elems X ^@N.elems).grep({
        $_[0] < $_[1] && @N[$_[1]] - @N[$_[0]] == $k
    });
}

say diff-k((2, 7, 9), 2);
