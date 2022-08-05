use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 176
=========================

TASK #1
-------
*Permuted Multiples*

Submitted by: Mohammad S Anwar

Write a script to find the smallest integer x such that x, 2x, 3x, 4x, 5x and
6x are permuted multiples of each other.

For example, the integers 125874 and 251748 are permutated multiples of each
other as

  251784 = 2 x 125874

  and also both have the same digits but in different order.

Output

  142857

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumption
----------
Only positive integers are considered. Zero is excluded; otherwise, it would
be the smallest non-negative solution.

Interface
---------
If the constant $VERBOSE is set to True, the 6 multiples are printed to allow
visual confirmation that they are mutual permutations. If $VERBOSE is set to
False (the default), only the solution is displayed.

Algorithm
---------
Starting at 1, and counting upwards, each positive integer x is tested against
the criteria: is 6x a permutation of x?, is 5x a permutation of x?, and so on.
(Permutations are tested in reverse order because the larger multiples are more
likely to produce additional digits and therefore to fail sooner.) As soon as a
test fails, the remaining tests are bypassed and testing begins on the next x.

A saving of 2 to 3 seconds was achieved by comparing sorted digit-permutations
as strings rather than digit-by-digit. This Raku script takes 6 to 7 seconds to
find the solution.

=end comment
#==============================================================================

my Bool constant $VERBOSE = False;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 176, Task #1: Permuted Multiples (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    my UInt $x = 0;

    Nil until is-pm6( ++$x );

    if $VERBOSE
    {
        ('The smallest non-zero, positive integer x such that x, 2x, 3x, '  ~
         "4x, 5x and 6x\nare permuted multiples of each other is %d:\n\n  " ~
         "%s\n").printf:
                   $x, (1 .. 6).map( { "$_ * $x = " ~ $_ * $x } ).join: "\n  ";
    }
    else
    {
        print  "$x\n";
    }
}

#------------------------------------------------------------------------------
sub is-pm6( UInt:D $x --> Bool:D )
#------------------------------------------------------------------------------
{
    for 6 ... 2 -> UInt $i
    {
        return False unless are-permutations( $x, $i * $x );
    }

    return True;
}

#------------------------------------------------------------------------------
sub are-permutations( UInt:D $x, UInt:D $y --> Bool:D )
#------------------------------------------------------------------------------
{
    return False unless $x.chars == $y.chars;

    my Str $sorted-x = $x.split( '', :skip-empty ).sort.join: '';
    my Str $sorted-y = $y.split( '', :skip-empty ).sort.join: '';

    return $sorted-x eq $sorted-y;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
