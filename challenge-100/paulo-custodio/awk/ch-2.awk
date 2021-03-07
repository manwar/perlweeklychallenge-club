#!/usr/bin/gawk

# Challenge 100
#
# TASK #2 > Triangle Sum
# Submitted by: Mohammad S Anwar
# You are given triangle array.
#
# Write a script to find the minimum path sum from top to bottom.
#
# When you are on index i on the current row then you may move to either
# index i or index i + 1 on the next row.
#
# Example 1:
# Input: Triangle = [ [1], [2,4], [6,4,9], [5,1,7,2] ]
# Output: 8
#
# Explanation: The given triangle
#
#             1
#            2 4
#           6 4 9
#          5 1 7 2
#
# The minimum path sum from top to bottom:  1 + 2 + 4 + 1 = 8
#
#              [1]
#            [2]  4
#            6 [4] 9
#           5 [1] 7 2
# Example 2:
# Input: Triangle = [ [3], [3,1], [5,2,3], [4,3,1,3] ]
# Output: 7
#
# Explanation: The given triangle
#
#             3
#            3 1
#           5 2 3
#          4 3 1 3
#
# The minimum path sum from top to bottom: 3 + 1 + 2 + 1 = 7
#
#              [3]
#             3  [1]
#            5 [2] 3
#           4 3 [1] 3

function add_row(row, text,    i, arr) {
    rows = row;
    for (i = 1; i <= row; i++) {
        gsub(/^[^0-9]*/, "", text);
        match(text, /^([0-9]+)/, arr);
        triangle[row][i] = arr[1];
        gsub(/^[0-9]*/, "", text);
    }
}

function min_sum_1(sum, row, col,    sum1, sum2) {
    sum += triangle[row][col];
    if (row == rows)
        return sum;
    else {
        sum1 = min_sum_1(sum, row+1, col);
        sum2 = min_sum_1(sum, row+1, col+1);
        return (sum1 < sum2) ? sum1 : sum2;
    }
}

function min_sum() {
    return min_sum_1(0, 1, 1);
}

BEGIN {
    rows = 0;
    for (i = 1; i < ARGC; i++)
        add_row(i, ARGV[i]);
    print min_sum();
    exit 0;
}
