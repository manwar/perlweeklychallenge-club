use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 116
=========================

TASK #1
-------
*Number Sequence*

Submitted by: Mohammad S Anwar

You are given a number $N >= 10.

Write a script to split the given number such that the difference between two
consecutive numbers is always 1 and it shouldn’t have leading 0.

Print the given number if it impossible to split the number.

Example

 Input: $N = 1234
 Output: 1,2,3,4

 Input: $N = 91011
 Output: 9,10,11

 Input: $N = 10203
 Output: 10203 as it is impossible to split satisfying the conditions.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

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

FOR each number of starting digits _d_, beginning with 1 and ending with ⌊D/2⌋:

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

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 116, Task #1: Number Sequence (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D $N where { $N >= 10 }      #= An integer greater than or equal to 10
)
#==============================================================================
{
    my UInt $n = $N + 0;             # Normalize: e.g., 010 --> 10, 0x10 --> 16

    "Input:  \$N = $n".put;

    my UInt @sequence;
    my UInt $len-n = $n.chars;

    DIGITS: for 1 .. floor( $len-n / 2 ) -> UInt $digits
    {
                @sequence = ();
        my UInt $number0  = $n.substr( 0, $digits ).Int;
        my UInt $length1  = $digits;
        my UInt $offset   = $digits;
        my UInt $number1;

        while $offset < $len-n
        {
            ++$length1  if $number0 ~~ / ^ 9+ $ /;
            next DIGITS if $offset + $length1 > $len-n;

            $number1 = $n.substr( $offset, $length1 ).Int;

            next DIGITS if $number1 - $number0 != 1;

            @sequence.push: $number0;

            $offset += $length1;
            $number0 = $number1;
        }

        @sequence.push: $number1;

        last DIGITS;
    }

    "Output: %s\n".printf: @sequence ?? @sequence.join( ',' ) !! $n;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################
