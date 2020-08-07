#!/usr/bin/env perl6
# 
#
#       trail_of_zeros.raku
#
#         TASK #1 › Trailing Zeroes
#         Submitted by: Mohammad S Anwar
#         You are given a positive integer $N (<= 10).
# 
#         Write a script to print number of trailing zeroes in $N!.
# 
#         Example 1
#         Input: $N = 10
#         Output: 2 as $N! = 3628800 has 2 trailing zeroes
# 
#         Example 2
#         Input: $N = 7
#         Output: 1 as $N! = 5040 has 1 trailing zero
# 
#         Example 3
#         Input: $N = 4
#         Output: 0 as $N! = 24 has 0 trailing zero
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



sub MAIN (Int $n where $n > 0 = 20) {
    for 1..30 {
        my $fact = [*] 2..$_;
        
        ## match object captures are in a list. 
        ## Take match object [0], apply comb then elems to count the zeros
        my $zeros = ($fact ~~ /.*?(0*)$/)[0].comb.elems;
        my @pl = $zeros == 1 ?? ('is ', '') !! ('are', 's') ;
        say "there are $zeros trailing zeros on {$_}! = $fact";
    }
}

