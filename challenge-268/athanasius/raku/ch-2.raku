use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 268
=========================

TASK #2
-------
*Number Game*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints, with even number of elements.

Write a script to create a new array made up of elements of the given array.
Pick the two smallest integers and add it to new array in decreasing order i.e.
high to low. Keep doing until the given array is empty.

Example 1

  Input: @ints = (2, 5, 3, 4)
  Output: (3, 2, 5, 4)

  Round 1: we picked (2, 3) and push it to the new array (3, 2)
  Round 2: we picked the remaining (4, 5) and push it to the new array (5, 4)

Example 2

  Input: @ints = (9, 4, 1, 3, 6, 4, 6, 1)
  Output: (1, 1, 4, 3, 6, 4, 9, 6)

Example 3

  Input: @ints = (1, 2, 2, 3)
  Output: (2, 1, 3, 2)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input integers are entered on the command-line.
3. If the first integer is negative, it must be preceded by "--" to indicate
   that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 268, Task #2: Number Game (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty, even-numbered list of integers

    *@ints where { .elems > 0 && .elems %% 2 }
)
#===============================================================================
{
    "Input: \@ints = (%s)\n".printf: @ints.join: ', ';

    my Int @soln = solve( @ints );

    "Output:        (%s)\n"\.printf: @soln.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub solve( List:D[Int:D] $ints where { .elems %% 2 } --> List:D[Int:D] )
#-------------------------------------------------------------------------------
{
    my Int @solution;
    my Int @sorted = $ints.sort;

    while @sorted
    {
        my Int $first  = @sorted.shift;
        my Int $second = @sorted.shift;

        @solution.push: $second, $first;
    }

    return @solution;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $expd-str) = $line.split: / \| /;

        for     $test-name, $ints-str, $expd-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @ints = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int @soln = solve( @ints );
        my Int @expd = $expd-str.split( / \s+ /, :skip-empty ).map: { .Int };

        is-deeply @soln, @expd, $test-name;
    }

    done-testing;
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
        Example 1|2 5 3 4        |3 2 5 4
        Example 2|9 4 1 3 6 4 6 1|1 1 4 3 6 4 9 6
        Example 3|1 2 2 3        |2 1 3 2
        END
}

################################################################################
