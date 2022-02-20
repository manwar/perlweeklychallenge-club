#!/usr/bin/perl
# The Weekly Challenge 152
# Task 2 Rectangle Area
# Usage: 
# $ ch-2.pl [bottom-left of R1] [top-right of R1] [BL of R2] [TR of R2]
#  e.g. 
# $ ch-2.pl -1 0 2 2 0 -1 4 4  (Example 1)

use strict;
use v5.22.0;

say rect_area(@ARGV[0..7]) 
    if (defined($ARGV[0]) && defined($ARGV[7]) && verify(@ARGV[0..7]));



sub verify {
    my @A, my @B;
    ($A[0], $A[1], $A[2], $A[3], $B[0], $B[1], $B[2], $B[3]) = @_;
    my $pass_A = $A[0] < $A[2] && $A[1] < $A[3];
    my $pass_B = $B[0] < $B[2] && $B[1] < $B[3];
               
    die "Problem(s) in input data of the first rectangle.\n" if !$pass_A;
    die "Problem(s) in input data of the second rectangle.\n" if !$pass_B;
    return $pass_A && $pass_B;
}



sub rect_area {
    my @A, my @B;
    # ($lA,   $bA,   $rA,   $tA,   $lB,   $bB,   $rB,   $rB)
      ($A[0], $A[1], $A[2], $A[3], $B[0], $B[1], $B[2], $B[3]) = @_;

    my @w = sort {$a<=>$b} ($A[0], $A[2], $B[0], $B[2]);
    my @h = sort {$a<=>$b} ($A[1], $A[3], $B[1], $B[3]);

    my $area = 0;

    for my $i (0..2) { for my $j (0..2) {
        my $inA =    ($w[$j] >= $A[0]) && ($A[2] >= $w[$j+1])
                  && ($h[$i+1] <= $A[3]) && ($A[1] <= $h[$i]);

        my $inB =    ($w[$j] >= $B[0]) && ($B[2] >= $w[$j+1])
                  && ($h[$i+1] <= $B[3]) && ($B[1] <= $h[$i]);

        if ($inA || $inB) {
            $area += ($w[$i+1]-$w[$i])*($h[$j+1]-$h[$j]);
        }
    }}

=pod
    Except the case that one rectangle is inside the other rectangle,
    the two rectangles can be enscribed into a larger rectangle
    Dividing the large rectangle into 9 small rectangular regions,
    then check one by one if a small region is inside rect A or rect B.
    If yes, add the area of the small region into $area.
=cut

    return $area;
}



use Test::More tests => 4;

ok ( rect_area(-1,0,2,2,0,-1,4,4) == 22 ), "Example 1";
ok ( rect_area(-3,-1,1,3,-1,-3,2,2) == 25), "Example 2";
ok ( rect_area(0,0,1,1,-1,-1,4,4) == 25), "Square within Square";
ok ( rect_area(-3,-3,0,0,0,0,4,4) == 25), "Seperated Squares";

