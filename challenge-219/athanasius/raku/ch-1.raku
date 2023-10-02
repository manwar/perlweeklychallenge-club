use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 219
=========================

TASK #1
-------
*Sorted Squares*

Submitted by: Mohammad S Anwar

You are given a list of numbers.

Write a script to square each number in the list and return the sorted list,
increasing order.

Example 1

  Input: @list = (-2, -1, 0, 3, 4)
  Output: (0, 1, 4, 9, 16)

Example 2

  Input: @list = (5, -4, -1, 3, 6)
  Output: (1, 9, 16, 25, 36)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
The input numbers are integers.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If the first integer is negative, the input list must be preceded by '--'.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 219, Task #1: Sorted Squares (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A list of 1 or more integers

    *@list where { .all ~~ Int:D && .elems > 0 }
)
#===============================================================================
{
    "Input:  \@list = (%s)\n".printf: @list.join: ', ';

    my Int @output = square-and-sort( @list );

    "Output: (%s)\n".printf: @output.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub square-and-sort
(
    List:D[Int:D] $list where { .elems > 0 }
--> List:D[Int:D]
)
#-------------------------------------------------------------------------------
{
    my Int @solution;

    @solution.push: $_² for @$list;

    @solution.= sort;

    return @solution;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $list-str, $expd-str) = $line.split: / \| /;

        for $test-name, $list-str, $expd-str                   # Trim whitespace
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @expected   = $expd-str.split( / \, \s* / ).map: { .Int };
        my Int @input-list = $list-str.split( / \, \s* / ).map: { .Int };
        my Int @solution   = square-and-sort( @input-list );

        is-deeply @solution, @expected, $test-name;
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
        Example 1|-2, -1,  0, 3, 4|0, 1,  4,  9, 16
        Example 2| 5, -4, -1, 3, 6|1, 9, 16, 25, 36
        END
}

################################################################################
