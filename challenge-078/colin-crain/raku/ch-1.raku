#!/usr/bin/env perl6
# 
#
#       follow-the-leader.raku
#
#         TASK #1 › Leader Element
#         Submitted by: Mohammad S Anwar
#         You are given an array @A containing distinct integers.
# 
#         Write a script to find all leader elements in the array @A. Print (0)
#         if none found.
# 
#         An element is leader if it is greater than all the elements to its
#         right side.
# 
#         Example 1:
#             Input: @A = (9, 10, 7, 5, 6, 1)
#             Output: (10, 7, 6, 1)
#         Example 2:
#             Input: @A = (3, 4, 5)
#             Output: (5)
# 
#         method: working from the end, the tail element is by definition the
#             "leader" of none. From there a running local maximum is
#             established among elements already seen and the focus moves one
#             element to the left. If the element is greater than the local
#             maximum, it is the leader and becomes the new maximum. Leaders are
#             propgated to the output array, which needs to be revered back to 
# 
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (*@input) ;

## in
@input.elems == 0 and @input = 9, 10, 7, 5, 6, 1;

## work
my $max = -Inf;
my @output = @input.reverse
                   .map( { $_ > $max ?? ($max = $_) !! Nil } )
                   .grep( *.defined );
@output .= reverse;

## out
say " input: ", @input;
say "output: ", @output;

