#! /opt/local/bin/perl5.26
#
#       gcd_sum.pl
#
#         TASK #1 › GCD Sum
#         Submitted by: Mohammad S Anwar
#         You are given a positive integer $N.
#
#         Write a script to sum GCD of all possible unique pairs between 1 and $N.
#
#         Example 1:
#         Input: 3
#         Output: 3
#
#         gcd(1,2) + gcd(1,3) + gcd(2,3)
#         Example 2:
#         Input: 4
#         Output: 7
#
#         gcd(1,2) + gcd(1,3) + gcd(1,4) + gcd(2,3) + gcd(2,4) + gcd(3,4)

#         method:
#             Nothing too complicated here -- we have two parts to this somewhat
#             mashed together task. In the first step we need to assmble a list
#             of paired values from the range 1 to out input value. If we take
#             the second value as incrementally larger than the first, then the
#             resulting pairs will not repeat and be unique.

#             For this we will compose our own pairs() function, with two loops
#             to produce an array of arrays.

#             In the second part of the puzzle, each unique pair is taken as
#             values for a greatest common divisor function, and the sum of the
#             return values for the list of combinations is output.

#             We'll use a quick implimentation Euclid's Algorithm to find our
#             GCDs.
#
#         validation: checked against A178881
#             "Sum of all pairs of greater common divisors for (i,j) where i<j.	"
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my $input = shift @ARGV // 4100;

my $sum = 0 ;
$sum += gcd($_->@*) for pairs($input)->@*;

say "input $input";
say "sum   $sum";

## ## ## ## ## SUBS:

sub gcd {
## Euclid's algorithm
    my ($m, $n) = @_;
    while ( $n != 0 ) {
        $n > $m and ($m, $n) = ($n, $m);
        my $r = $m - $n * ( int ($m/$n));
        return $n if $r == 0;
        ($m, $n) = ($n, $r);
    }
}

sub pairs {
## unique pairs among values 1 and $max
    my ($max) = @_;
    my @out;
    for my $m ( 1..$max-1 ) {
        for my $n ( $m+1..$max ) {
            push @out, [$m, $n];
        }
    }
    return \@out;
}
