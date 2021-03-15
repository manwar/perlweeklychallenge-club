#!/usr/bin/gawk

# Challenge 099
#
# TASK #2 > Unique Subsequence
# Submitted by: Mohammad S Anwar
# You are given two strings $S and $T.
#
# Write a script to find out count of different unique subsequences matching
# $T without changing the position of characters.
#
# Example 1:
# Input: $S = "littleit', $T = 'lit'
# Output: 5
#
#     1: [lit] tleit
#     2: [li] t [t] leit
#     3: [li] ttlei [t]
#     4: litt [l] e [it]
#     5: [l] ittle [it]
# Example 2:
# Input: $S = "london', $T = 'lon'
# Output: 3
#
#     1: [lon] don
#     2: [lo] ndo [n]
#     3: [l] ond [on]

function count_subsequences(s, t) {
    while (1) {
        if (t=="") {            # t is empty, matched
            return 1;
        }
        else if (s=="") {       # s is empty, did not match
            return 0;
        }
        else if (substr(s,1,1) == substr(t,1,1)) {  # same char,
                                                    # check two paths matching
                                                    # and not matching
            return count_subsequences(substr(s,2), substr(t,2)) \
                 + count_subsequences(substr(s,2), t);
        }
        else {                  # different char, keep pattern
            s = substr(s,2);
        }
    }
}

BEGIN {
    print count_subsequences(ARGV[1], ARGV[2]);
    exit 0;
}
