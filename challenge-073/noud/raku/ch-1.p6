# You are given an array of integers @A and sliding window size $S.
#
# Write a script to create an array of min from each sliding window.
# Example
# Input: @A = (1, 5, 0, 2, 9, 3, 7, 6, 4, 8) and $S = 3
# Output: (0, 0, 0, 2, 3, 3, 4, 4)
#
# [(1 5 0) 2 9 3 7 6 4 8] = Min (0)
# [1 (5 0 2) 9 3 7 6 4 8] = Min (0)
# [1 5 (0 2 9) 3 7 6 4 8] = Min (0)
# [1 5 0 (2 9 3) 7 6 4 8] = Min (2)
# [1 5 0 2 (9 3 7) 6 4 8] = Min (3)
# [1 5 0 2 9 (3 7 6) 4 8] = Min (3)
# [1 5 0 2 9 3 (7 6 4) 8] = Min (4)
# [1 5 0 2 9 3 7 (6 4 8)] = Min (4)

sub min-sliding-window(@A, $S) {
    gather for 0..@A.elems-$S -> $i {
        take min(@A[$i..$i+$S-1]);
    }
}

min-sliding-window((1, 5, 0, 2, 9, 3, 7, 6, 4, 8), 3).say;
