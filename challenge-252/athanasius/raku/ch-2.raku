use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 252
=========================

TASK #2
-------
*Unique Sum Zero*

Submitted by: Mohammad S Anwar

You are given an integer, $n.

Write a script to find an array containing $n unique integers such that they add
up to zero.

Example 1

  Input: $n = 5
  Output: (-7, -1, 1, 3, 4)

  Two other possible solutions could be as below:
  (-5, -1, 1, 2, 3) and (-3, -1, 2, -2, 4).

Example 2

  Input: $n = 3
  Output: (-1, 0, 1)

Example 3

  Input: $n = 1
  Output: (0)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
It is assumed that the output list contains at least one element, and therefore
that $n > 0.

Interface
---------
1. A single, non-zero, positive integer should be entered on the command-line.
2. No test suite is provided, as the output is randomized. Instead, if the
   constant DEBUG is set to True, the generated solution is validated to ensure
   that it contains exactly $n unique elements that sum to zero.
3. The constant COEFF may be adjusted to vary the range of potential output
   values. For example, if $n = 4 and COEFF = 2.5, the integers in the solution
   will be drawn from the range -10 .. +10.

=end comment
#===============================================================================

use List::Util < shuffle >;

subset Pos of Int where * > 0;

my Rat  constant COEFF = 2.5;     # Determines range of possible solution values
my Bool constant DEBUG = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 252, Task #2: Unique Sum Zero (Raku)\n".put;
}

#===============================================================================
sub MAIN
(
    Pos:D $n                  #= A non-zero, positive integer
)
#===============================================================================
{
    "Input:  \$n = $n".put;

    my Int @zero-sum-list = find-zero-sum-list( $n );

    "Output: (%s)\n".printf: @zero-sum-list.join: ', ';

    validate( $n, @zero-sum-list ) or die 'Solution failed validation' if DEBUG;
}

#-------------------------------------------------------------------------------
sub find-zero-sum-list( Pos:D $n --> List:D[Int:D] )
#-------------------------------------------------------------------------------
{
    my Int  @zero-sum-list;
    my UInt $max = (COEFF * $n).floor;

    loop (my Bool $done = False; !$done; )
    {
        my Int @candidates = -$max .. +$max;

        @zero-sum-list = (shuffle @candidates)[ 0 .. $n - 2 ];

        my Int $diff = - [+] @zero-sum-list;

        # Ensure that $diff is (1) not already in @zero-sum
        #                  and (2) within the specified range

        if @zero-sum-list.none == $diff && $diff.abs <= $max
        {
            @zero-sum-list.push: $diff;
            $done = True;
        }
    }

    return @zero-sum-list;
}

#-------------------------------------------------------------------------------
sub validate( Pos:D $n, List:D[Int:D] $zero-sum-list --> Bool:D )
#-------------------------------------------------------------------------------
{
    # 1. n elements

    return False unless $zero-sum-list.elems == $n;

    # 2. Unique

    my Pos %dict{Int};

    for @$zero-sum-list -> Int $elem
    {
        return False unless ++%dict{ $elem } == 1;
    }

    # 3. Add up to zero

    my Int $sum = [+] @$zero-sum-list;

    return $sum == 0;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

################################################################################
