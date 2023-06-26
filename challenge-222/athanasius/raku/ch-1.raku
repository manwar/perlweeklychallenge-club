use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 222
=========================

TASK #1
-------
*Matching Members*

Submitted by: Mohammad S Anwar

You are given a list of positive integers, @ints.

Write a script to find the total matching members after sorting the list [in]
increasing order.

Example 1

  Input: @ints = (1, 1, 4, 2, 1, 3)
  Output: 3

  Original list: (1, 1, 4, 2, 1, 2)
  Sorted list  : (1, 1, 1, 2, 3, 4)

  Compare the two lists, we found 3 matching members (1, 1, 2).

Example 2

  Input: @ints = (5, 1, 2, 3, 4)
  Output: 0

  Original list: (5, 1, 2, 3, 4)
  Sorted list  : (1, 2, 3, 4, 5)

  Compare the two lists, we found 0 matching members.

Example 3

  Input: @ints = (1, 2, 3, 4, 5)
  Output: 5

  Original list: (1, 2, 3, 4, 5)
  Sorted list  : (1, 2, 3, 4, 5)

  Compare the two lists, we found 5 matching members.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
A "positive integer" is an integer greater than zero.

Interface
---------
If no command-line arguments are given, the test suite is run.

=end comment
#===============================================================================

use Test;

subset Pos of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 222, Task #1: Matching Members (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@ints where { .elems > 0 && .all ~~ Pos:D }  #= A list of positive integers
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my UInt  $matches = find-matches( @ints );

    "Output: $matches".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-matches( List:D[Pos:D] $ints --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $matches = 0;
    my Pos  @sorted  = $ints.sort;

    for 0 .. $ints.end -> UInt $i
    {
        ++$matches if $ints[ $i ] == @sorted[ $i ];
    }

    return $matches;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $expected) = $line.split: / \| /;

        for $test-name, $ints-str, $expected                   # Trim whitespace
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Pos  @ints    = $ints-str.split( / \s+ / ).map: { .Int };
        my UInt $matches = find-matches( @ints );

        is $matches, $expected.Int, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|1 1 4 2 1 3|3
        Example 2|5 1 2 3 4  |0
        Example 3|1 2 3 4 5  |5
        END
}

################################################################################
