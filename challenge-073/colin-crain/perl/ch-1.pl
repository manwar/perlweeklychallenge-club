#! /opt/local/bin/perl
#
#       open-the-window-a-little-bit.pl
#
#       TASK #1 › Min Sliding Window
#         Submitted by: Mohammad S Anwar
# 
#         You are given an array of integers @A and sliding window size $S.
# 
#         Write a script to create an array of min from each sliding window.
# 
#         Example
#             Input: @A = (1, 5, 0, 2, 9, 3, 7, 6, 4, 8) and $S = 3
#             Output: (0, 0, 0, 2, 3, 3, 4, 4)
# 
#             [(1 5 0) 2 9 3 7 6 4 8] = Min (0)
#             [1 (5 0 2) 9 3 7 6 4 8] = Min (0)
#             [1 5 (0 2 9) 3 7 6 4 8] = Min (0)
#             [1 5 0 (2 9 3) 7 6 4 8] = Min (2)
#             [1 5 0 2 (9 3 7) 6 4 8] = Min (3)
#             [1 5 0 2 9 (3 7 6) 4 8] = Min (3)
#             [1 5 0 2 9 3 (7 6 4) 8] = Min (4)
#             [1 5 0 2 9 3 7 (6 4 8)] = Min (4)
# 
# 
#         method:
#         
#             array slices to the rescue! Iterate over 0 to (last - window size)
#             find min and push to output array. 
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:


my ($S, @A) = @ARGV;

# $S = 3;
# @A = (1, 5, 0, 2, 9, 3, 7, 6, 4, 8);

my $end = @A - $S;
my @output;

for ( 0..$end ){
    my $min = minimum( @A[$_..$_+$S-1] );
    push @output, $min;
}


say "input:   @A    window size $S";
say "output:  @output";

## ## ## ## ## SUBS:

sub minimum {
    my $min = "inf";
    $_ < $min and $min = $_ for @_;
    return $min;
}




