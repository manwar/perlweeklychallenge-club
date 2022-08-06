use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 176
=========================

TASK #2
-------
*Reversible Numbers*

Submitted by: Mohammad S Anwar

Write a script to find out all Reversible Numbers below 100.


    A number is said to be a reversible if sum of the number and its reverse
    had only odd digits.


For example,

  36 is reversible number as 36 + 63 = 99 i.e. all digits are odd.
  17 is not reversible as 17 + 71 = 88, none of the digits are odd.

Output

  10, 12, 14, 16, 18, 21, 23, 25, 27,
  30, 32, 34, 36, 41, 43, 45, 50, 52,
  54, 61, 63, 70, 72, 81, 90

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm
---------
Each integer n in the range 0 to 99 is tested to determine whether it is re-
versible: a sum is calculated by adding n to its reverse, then each digit of
the sum is tested for divisibility by 2; if it is even, the test fails immedi-
ately; otherwise, the test proceeds until all digits have been tested.

Note: The dual behaviour of Perl's reverse() function has in Raku been split
between 2 built-in functions: reverse(), which reverses the elements of a list,
and flip(), which reverses the characters in a string.

=end comment
#==============================================================================

my UInt constant $LIMIT = 100;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 176, Task #2: Reversible Numbers (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    my UInt @reversible;

    for 0 .. $LIMIT - 1 -> UInt $n
    {
        @reversible.push: $n if is-reversible( $n );
    }

    "The reversible numbers below %d:\n%s\n".printf:
        $LIMIT, @reversible.join: ', ';
}

#------------------------------------------------------------------------------
sub is-reversible( UInt:D $n --> Bool:D )
#------------------------------------------------------------------------------
{
    my UInt $sum    = $n + $n.flip.Int;
    my UInt @digits = $sum.split( '', :skip-empty ).map: { .Int };

    for @digits -> UInt $digit
    {
        return False if $digit %% 2;
    }

    return True;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
