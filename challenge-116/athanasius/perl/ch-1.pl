#!perl

###############################################################################
=comment

Perl Weekly Challenge 116
=========================

TASK #1
-------
*Number Sequence*

Submitted by: Mohammad S Anwar

You are given a number $N >= 10.

Write a script to split the given number such that the difference between two
consecutive numbers is always 1 and it shouldn't have leading 0.

Print the given number if it impossible to split the number.

Example

 Input: $N = 1234
 Output: 1,2,3,4

 Input: $N = 91011
 Output: 9,10,11

 Input: $N = 10203
 Output: 10203 as it is impossible to split satisfying the conditions.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumptions
-----------
(1) N is an integer.
(2) Let N's digits be grouped as numbers: n0|n1|n2|...; then "the difference
    between two consecutive numbers" is defined as (n1 - n0), (n2 - n1), etc.
    That is, the grouped numbers must *increase* by exactly one from left to
    right; N = 987 cannot be split into 9|8|7, even though successive numbers
    in this grouping might be said to "differ by one."
(3) The condition "and it shouldn't have leading 0" refers to every number in
    the final grouping; so, in the third Example, 1|02|03 is not a valid split
    because "02" and "03" have leading "0" digits and so are disallowed.

Observation
-----------
For any integers p and q, if q - p = 1 then either
    (1) p and q have the same number of digits; or
    (2) p is entirely composed of "9" digits (say a total of D "9" digits) and
        q comprises a "1" followed by D "0" digits.

Algorithm
---------
Let N comprise D digits. Since N >= 10, D >= 2.

FOR each number of starting digits _d_,
        beginning with 1 and ending with the lower bound of D/2:

    Move from left to right through N, checking that each group of _d_ digits
        comprises a number exactly 1 greater than the number to its left.
        (In the special case where the left-hand number is all 9's, first
        increment _d_ by 1.)
    On the first failure encountered, abort the search and start again with the
        next higher value of _d_.
    IF the search is successful for the whole of N, with all digits accounted-
        for,
    THEN record the solution and discontinue the search for higher values of
        _d_.

ENDFOR

If a solution has been found, output its elements separated by commas;
    otherwise, output N.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;

const my $USAGE =>
"Usage:
  perl $0 <N>

    <N>    An integer greater than or equal to 10\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 116, Task #1: Number Sequence (Perl)\n\n";
}

#=============================================================================
MAIN:
#==============================================================================
{
    my $N = parse_command_line();

    print "Input:  \$N = $N\n";

    my @sequence;
    my $len_N = length $N;

    DIGITS: for my $digits (1 .. int( $len_N / 2 ))
    {
           @sequence = ();
        my $number0  = substr $N, 0, $digits;
        my $length1  = $digits;
        my $offset   = $digits;
        my $number1;

        while ($offset < $len_N)
        {
            ++$length1  if $number0 =~ / ^ 9+ $ /x;
            next DIGITS if $offset + $length1 > $len_N;

            $number1 = substr $N, $offset, $length1;

            next DIGITS if $number1 - $number0 != 1;

            push @sequence, $number0;

            $offset += $length1;
            $number0 = $number1;
        }

        push @sequence, $number1;

        last DIGITS;
    }

    printf "Output: %s\n", @sequence ? join( ',', @sequence ) : $N;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or error( "Expected 1 command line argument, found $args" );

    my $N = $ARGV[ 0 ];

    $N =~ s/ ^ \+ //x;                   # Remove initial "+", if any

    $N =~ / ^ [0-9]+ $ /x
                  or error( qq["$N" is not a valid integer] );

    $N =~ s/ ^ 0+ //x;                   # Remove initial zero digit(s), if any

    length $N > 1 or error( "$N is less than 10" );

    return $N;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
