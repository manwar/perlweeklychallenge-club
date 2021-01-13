#!/usr/bin/env perl6
#
#
#       number_combo_convo.raku
#
#         TASK #1 › Number Combinations
#         Submitted by: Mohammad S Anwar
#
#             You are given two integers $max and $elems. Write a script print all
#             possible combinations of $elems numbers from the list 1 2 3 … $max.
#
#             Every combination should be sorted i.e. [2,3] is valid
#             combination but [3,2] is not.
#
#             Example:
#               Input: $max = 5, $elems = 2
#
#               Output: [ [1,2], [1,3], [1,4], [1,5], [2,3], [2,4], [2,5], [3,4], [3,5], [4,5] ]
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



sub MAIN ( Int $max = 5, Int $elems = 3 ) {

    .say for (1..$max).combinations: $elems;
}
