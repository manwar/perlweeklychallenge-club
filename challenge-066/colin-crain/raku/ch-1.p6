#!/usr/bin/env perl6
#
#
#       sewing_division_with_stone_tools.raku
#
#         TASK #1 › Divide Integers
#         Submitted by: Mohammad S Anwar
#
#             You are given two integers $M and $N.
#
#             Write a script to divide the given two integers i.e. $M / $N
#             without using multiplication, division and mod operator and
#             return the floor of the result of the division.
#
#             Example 1:
#                 Input: $M = 5, $N = 2
#                 Output: 2
#
#             Example 2:
#                 Input: $M = -5, $N = 2
#                 Output: -3
#
#             Example 3:
#                 Input: $M = -5, $N = -2
#                 Output: 2
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



sub MAIN (Int $numerator, Int $denominator where { $denominator != 0 }) {

    my $quotient_floor = divide_to_floor( $numerator, $denominator );
    "floor $numerator ÷ $denominator = $quotient_floor".say;

}

sub absolute (Int $num, Bool $negate is rw) {
##  Int -> (Int absolute value of $num, Int is negative)
    return $num if $num >= 0;
    $negate = ! $negate;
    0 - $num;
}



sub divide_to_floor (Int $numerator, Int $denominator is copy) {
## integer division floor function
    my $remainder;
    my $quotient_floor = 0;
    my $negate         = False;
    $remainder    = absolute($numerator, $negate);
    $denominator  = absolute($denominator, $negate);

    ## do integer division on two positive values
    while ($remainder - $denominator >= 0) {
        $remainder -= $denominator;
        $quotient_floor++;
    }

    ## convert to floor for negative results
    if $negate {
        ## the negative of the floor of x i the ceiling of -x
        ## - ⎣x⎦ = ⎡-x⎤
        ## so subtract 1 unless ⎣x⎦ = ⎡x⎤, which is when {x} = 0
        ## or in other words when the remainder is 0
        $quotient_floor = 0 - $quotient_floor;
        $quotient_floor-- if $remainder != 0;
    }

    return $quotient_floor;
}
