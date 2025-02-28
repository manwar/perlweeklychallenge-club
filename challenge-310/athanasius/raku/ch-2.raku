use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 310
=========================

TASK #2
-------
*Sort Odd Even*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to sort odd index elements in decreasing order and even index 
elements in increasing order in the given array.

Example 1

  Input: @ints = (4, 1, 2, 3)
  Output: (2, 3, 4, 1)

  Even index elements: 4, 2 => 2, 4 (increasing order)
  Odd index elements : 1, 3 => 3, 1 (decreasing order)

Example 2

  Input: @ints = (3, 1)
  Output: (3, 1)

Example 3

  Input: @ints = (5, 3, 2, 1, 4)
  Output: (2, 3, 4, 1, 5)

  Even index elements: 5, 2, 4 => 2, 4, 5 (increasing order)
  Odd index elements : 3, 1 => 3, 1 (decreasing order)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
The given array contains at least one integer.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of 1 or more integers is entered on the command-line.
3. If the first integer is negative, it must be preceded by "--" to signal that
   it is not a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 310, Task #2: Sort Odd Even (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A list of one or more integers

    *@ints where { .elems > 0 && .all ~~ Int:D }
)
#===============================================================================
{
    "Input: \@ints = (%s)\n".printf: @ints.join: ', ';

    my Int @sorted = sort-odd-even( @ints );

    "Output:        (%s)\n"\.printf: @sorted.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub sort-odd-even( List:D[Int:D] $ints where { .elems > 0 } --> List:D[Int:D] )
#-------------------------------------------------------------------------------
{
    my Int (@odd, @even);
    my Int  @ints = @$ints;                 # Make a copy

    while (@ints)
    {
        @even.push: @ints.shift.Int;
        @odd\.push: @ints.shift.Int if @ints.elems > 0;
    }

    @even .= sort;                          # Increasing
    @odd  .= sort: { $^b <=> $^a };         # Decreasing

    return roundrobin( @even, @odd ).flat.Array;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $int-str, $exp-str) = $line.split: / \| /;

        for     $test-name, $int-str, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @ints   = $int-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int @sorted = sort-odd-even( @ints );
        my Int @expctd = $exp-str.split( / \s+ /, :skip-empty ).map: { .Int };

        is-deeply @sorted, @expctd, $test-name;
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
        Example 1|4 1 2 3  |2 3 4 1
        Example 2|3 1      |3 1
        Example 3|5 3 2 1 4|2 3 4 1 5
        END
}

################################################################################
