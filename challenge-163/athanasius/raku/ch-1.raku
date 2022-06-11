use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 163
=========================

TASK #1
-------
*Sum Bitwise Operator*

Submitted by: Mohammad S Anwar

You are given list positive numbers, @n.

Write script to calculate the sum of bitwise & operator for all unique pairs.

Example 1

  Input: @n = (1, 2, 3)
  Output: 3

  Since (1 & 2) + (2 & 3) + (1 & 3) => 0 + 2 + 1 =>  3.

Example 2

  Input: @n = (2, 3, 4)
  Output: 2

  Since (2 & 3) + (2 & 4) + (3 & 4) => 2 + 0 + 0 =>  2.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumptions
-----------
1. "Positive numbers" are integers greater than zero.
2. "Unique pairs" are 2-combinations drawn from the *set* of input numbers,
    since:
      - the elements of each pair are distinct; and
      - their order is irrelevant.

=end comment
#==============================================================================

subset Pos of Int where * > 0;

my Bool constant $VERBOSE = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 163, Task #1: Sum Bitwise Operator (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    *@n where { +@n > 0 && .all ~~ Pos:D }       #= A list of positive integers
)
#==============================================================================
{
    "Input:  @n = (%s)\n".printf: @n.join: ', ';

    my Array[UInt] @pairs = get-unique-pairs( @n );
    my UInt        @bitw-ands;       # Bitwise ANDs in the same order as @pairs

    for @pairs -> Array[UInt] $pair
    {
        my Pos ($x, $y) = @$pair;

        @bitw-ands.push: $x +& $y;          # Perform the bitwise-AND operation
    }

    my UInt $sum = [+] @bitw-ands;

    "Output: $sum".put;

    if $VERBOSE && +@pairs
    {
        my Str @pair-strs = @pairs.map: { "(%d & %d)".sprintf: @$_ };

        "\nSince %s => %s => %d\n".printf: @pair-strs.join( ' + ' ),
                                           @bitw-ands.join( ' + ' ), $sum;
    }
}

#------------------------------------------------------------------------------
sub get-unique-pairs( Array:D[Pos:D] $n --> Array:D[Array:D[UInt:D]] )
#------------------------------------------------------------------------------
{
    my Array[UInt] @pairs;
    my Pos         @nums = $n.unique.sort;

    for 0 .. @nums.end - 1 -> UInt $i
    {
        for $i + 1 .. @nums.end -> UInt $j
        {
            @pairs.push: Array[UInt].new: @nums[ $i, $j ];
        }
    }

    return @pairs;            # These are in sorted (ascending numerical) order
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

##############################################################################
