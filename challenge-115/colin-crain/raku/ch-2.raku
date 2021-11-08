#!/usr/bin/env perl6
#
#
#       115-2-list-one-perl-two.raku
#
# 
#       Largest Multiple
#         Submitted by: Mohammad S Anwar
#         You are given a list of positive integers (0-9), single digit.
# 
#         Write a script to find the largest multiple of 2 that 
#         can be formed from the list.
# 
#         Examples
#         Input: @N = (1, 0, 2, 6)
#         Output: 6210
# 
#         Input: @N = (1, 4, 2, 8)
#         Output: 8412
# 
#         Input: @N = (4, 1, 7, 6)
#         Output: 7614
#
#         method:
#             sort the list 
#             iterate from small end:
#                 element %% 2 ? splice and small end move to end, last 
#                              : next
#             join list
# 
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

# @*ARGS = "1", "2", "3";

subset ArrayWith2 of Array where  {.any ~~ $_.Int %% 2} ;

multi sub MAIN (ArrayWith2 *@list) {
    @list = @list.sort;
    say @list.unshift( @list.splice(@list.first(* %% 2, :k), 1) )
             .join
             .flip;
}

multi sub MAIN (@list) {
    say "none"
}




