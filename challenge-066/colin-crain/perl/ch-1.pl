#! /opt/local/bin/perl
#
#       sewing_division_with_stone_tools.pl
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


use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my ($n, $d) = @ARGV;

if (@ARGV != 2) {
    die "./script.pl integer1 integer2";
}
die "no division by 0!" if $d == 0;

my $qf = divide_to_floor( $n, $d );
printf "floor %d ÷ %d = %d\n", $n, $d, $qf;

## ## ## ## ## SUBS:

sub absolute {
## return array: (absolute value of $num, bool is negative)
    my $num = shift;
    if ($num < 0) {
        return ((0 - $num), 1)
    }
    return ($num, 0)
}

sub divide_to_floor {
## integer division floor function
    my ($numerator, $denominator) = @_;
    my $remainder;
    my $quotient_floor = 0;
    my $sign_negative  = 0;
    my $negate         = 0;
    ($remainder, $sign_negative)    = absolute($numerator);
    $negate += $sign_negative;
    ($denominator, $sign_negative ) = absolute($denominator);
    $negate += $sign_negative;

    ## do integer division on two positive values
    while ($remainder - $denominator >= 0) {
        $remainder = $remainder - $denominator;
        $quotient_floor++;
    }

    ## convert to floor for negative results
    ## negate can only be 0, 1 or 2, so we have only one negative
    if ($negate == 1) {
        ## the negative of the floor of x i the ceiling of -x
        ## - ⎣x⎦ = ⎡-x⎤
        ## so subtract 1 unless ⎣x⎦ = ⎡x⎤, which is when {x} = 0
        ## or in other words when the remainder is 0
        $quotient_floor = 0 - $quotient_floor;
        $quotient_floor-- if $remainder != 0;
    }

    return $quotient_floor;
}
