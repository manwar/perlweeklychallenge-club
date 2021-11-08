use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 115
=========================

TASK #2
-------
*Largest Multiple*

Submitted by: Mohammad S Anwar

You are given a list of positive integers (0-9), single digit.

Write a script to find the largest multiple of 2 that can be formed from the
list.

Examples

 Input: @N = (1, 0, 2, 6)
 Output: 6210

 Input: @N = (1, 4, 2, 8)
 Output: 8412

 Input: @N = (4, 1, 7, 6)
 Output: 7614

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Observations
------------
1. To be a multiple of 2, an integer must end in an even digit: 0, 2, 4, 6, or
   8.
2. When forming an integer from available digits, the largest integer is formed
   by placing the largest digit in the most significant place, followed by the
   next-largest digit in the next-most-significant place, and so on.

Algorithm
---------
1. Find the least significant digit: this is the smallest even digit among the
   available digits. If no even digit is available, no solution is possible.
2. Form a string S by concatenating the remaining digits in descending order.
3. Append the least significant digit (found in step 1) to S. The resulting
   string is (a string representation of) the solution.

=end comment
#==============================================================================

subset Digit of Int where 0 <= * <= 9;

my constant EVEN = Set[Digit].new: 0, 2, 4, 6, 8;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 115, Task #2: Largest Multiple (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    *@N where { .elems > 0 && .all ~~ Digit:D }   #= A non-empty list of digits
)
#==============================================================================
{
    "Input:  \@N = (%s)\n".printf: @N.join: ', ';

    my BagHash[Digit] $digits = BagHash[Digit].new: @N.map: { .Int };
    my         Digit  $lsdigit;         # Least significant digit: must be even

    for $digits.keys -> Digit $digit
    {
        $lsdigit = $digit if $digit ∈ EVEN &&
                         (!$lsdigit.defined || $digit < $lsdigit);
    }

    if $lsdigit.defined
    {
        $digits.remove: $lsdigit;

        "Output: %s\n".printf: $digits.kxxv.sort.reverse.join ~ $lsdigit;
    }
    else
    {
       ('Output: None (no multiple of 2 can be formed from the given ' ~
        'digits)').put;
    }
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
