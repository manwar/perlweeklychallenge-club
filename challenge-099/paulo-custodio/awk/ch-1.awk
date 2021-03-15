#!/usr/bin/gawk

# Challenge 099
#
# TASK #1 > Pattern Match
# Submitted by: Mohammad S Anwar
# You are given a string $S and a pattern $P.
#
# Write a script to check if given pattern validate the entire string.
# Print 1 if pass otherwise 0.
#
# The patterns can also have the following characters:
#
# ? - Match any single character.
# * - Match any sequence of characters.
# Example 1:
# Input: $S = "abcde" $P = "a*e"
# Output: 1
# Example 2:
# Input: $S = "abcde" $P = "a*d"
# Output: 0
# Example 3:
# Input: $S = "abcde" $P = "?b*d"
# Output: 0
# Example 4:
# Input: $S = "abcde" $P = "a*c?e"
# Output: 1

function match_pattern(s, p) {
    while (1) {
        if (s=="" && p=="")         # string and pattern finished
            return 1;
        else if (s=="" || p=="")    # either string or pattern finished
            return 0;
        else if (p ~ /^\?/) {       # match any character
            s = substr(s, 2);
            p = substr(p, 2);
        }
        else if (p ~ /^\*/) {       # match any sub-sequence
            p = substr(p, 2);
            for (i = 1; i <= length(s); i++) {
                if (match_pattern(substr(s, i), p))
                    return 1;
            }
            return 0;
        }
        else if (substr(p,1,1) != substr(s,1,1)) {  # chars different
            return 0;
        }
        else {                      # search next char
            s = substr(s, 2);
            p = substr(p, 2);
        }
    }
}

BEGIN {
    print match_pattern(ARGV[1], ARGV[2]);
    exit 0;
}
