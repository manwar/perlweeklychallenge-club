#! /opt/local/bin/perl
#
#       max-gap.pl
#
#         TASK #1 › Maximum Gap
#         Submitted by: Mohammad S Anwar
#         You are given an array of integers @N.
# 
#         Write a script to display the maximum difference between two successive 
#         elements once the array is sorted.
# 
#         If the array contains only 1 element then display 0.
# 
#         Example
# 
#             Input: @N = (2, 9, 3, 5)
#             Output: 4
# 
#             Input: @N = (1, 3, 8, 2, 0)
#             Output: 5
# 
#             Input: @N = (5)
#             Output: 0
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';
use List::Util qw(reduce max);

my @input =  (2, 19, 13, 15);

my $gap = 0; 

## version 1 - reduce
sub gap_reduce (@list) {
    my $gap = 0;
    reduce { $gap = $b - $a if $b - $a > $gap; $b } sort {$a<=>$b} @list;
    return $gap;
}
                    
say gap_reduce(@input);


## version 2 - map over indices
sub gap_map (@list) {
    @list = sort {$a<=>$b} @list;
    
    my $gap = max (map { $list[$_] - $list[$_-1] } (1..$#list));
    return $gap;
}

say gap_map(@input);


