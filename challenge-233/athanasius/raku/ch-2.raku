use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 233
=========================

TASK #2
-------
*Frequency Sort*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to sort the given array in increasing order based on the frequen-
cy of the values. If multiple values have the same frequency then sort them in
decreasing order.

Example 1

  Input: @ints = (1,1,2,2,2,3)
  Output: (3,1,1,2,2,2)

  '3' has a frequency of 1
  '1' has a frequency of 2
  '2' has a frequency of 3

Example 2

  Input: @ints = (2,3,1,3,2)
  Output: (1,3,3,2,2)

  '2' and '3' both have a frequency of 2, so they are sorted in decreasing or-
  der.

Example 3

  Input: @ints = (-1,1,-6,4,5,-6,1,4,1)
  Output: (5,-1,4,4,-6,-6,1,1,1)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If the first element in the input list is negative, it must be preceded by
   "--" to distinguish it from a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 233, Task #2: Frequency Sort (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of integers

    *@ints where { .elems > 0 && .all ~~ Int:D }
)
#===============================================================================
{
    "Input: \@ints = (%s)\n".printf: @ints.join: ',';

    my Int @sorted = freq-sort( @ints );

    "Output:        (%s)\n".printf: @sorted.join: ',';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub freq-sort( List:D[Int:D] $ints --> List:D[Int:D] )
#-------------------------------------------------------------------------------
{
    my UInt %freq{Int};

    ++%freq{ $_ } for @$ints;

    return ($ints.sort: { %freq{ $^a } leg %freq{ $^b } || $^b leg $^a }).list;
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

        my Int @ints     = $int-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int @expected = $exp-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int @sorted   = freq-sort( @ints );

        is-deeply @sorted, @expected, $test-name;
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
        Example 1| 1 1  2 2 2  3      |3  1 1 2  2  2
        Example 2| 2 3  1 3 2         |1  3 3 2  2
        Example 3|-1 1 -6 4 5 -6 1 4 1|5 -1 4 4 -6 -6 1 1 1
        END
}

################################################################################
