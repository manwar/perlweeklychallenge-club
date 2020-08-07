#!/usr/bin/env perl6
# 
#
#       peak_power.raku
#
#       TASK #1 › Peak Element
#         Submitted by: Mohammad S Anwar
#         You are given positive integer $N (>1).
# 
#         Write a script to create an arr of size $N with random
#         unique elements between 1 and 50.
# 
#         In the end it should print peak elements in the arr, if
#         found.
# 
#         An arr element is called peak if it is bigger than it’s
#         neighbour.
# 
#         Example 1
#             Array: [ 18, 45, 38, 25, 10, 7, 21, 6, 28, 48 ]
#             Peak: [ 48, 45, 21 ]
#
#         Example 2
#             Array: [ 47, 11, 32, 8, 1, 9, 39, 14, 36, 23 ]
#             Peak: [ 47, 32, 39, 36 ]
#
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

sub MAIN (Int $n where {$n > 0} = 10 ) {

    # create our random array:
    # bookending the arr in 0s  
    # makes the comparisons at the ends cleaner
    
    my @a = 0, |(1..50).pick($n), 0 ;

    say "input array: @a[1..@a-2]";

    ## the indices for the original array elements
    ## map back to their array values iff comparison passes
    my @output = (1..^@a.end)
                .map: { @a[$_] if @a[$_-1] < @a[$_] && @a[$_] > @a[$_+1] };

    say "peak values: ", @output.join: ' '; 
    
}

