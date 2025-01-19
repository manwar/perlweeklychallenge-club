use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 304
=========================

TASK #2
-------
*Maximum Average*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints and an integer, $n which is less than
or equal to total elements in the given array.

Write a script to find the contiguous subarray whose length is the given inte-
ger, $n, and has the maximum average. It should return the average.

Example 1

  Input: @ints = (1, 12, -5, -6, 50, 3), $n = 4
  Output: 12.75

  Subarray: (12, -5, -6, 50)
  Average: (12 - 5 - 6 + 50) / 4 = 12.75

Example 2

  Input: @ints = (5), $n = 1
  Output: 5

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
$n is greater than zero. (If $n = 0, calculation of the average would result in
division by zero, which is undefined. If $n < 0, the "window" would have nega-
tive length, which makes no sense.)

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A positive integer named n is entered on the command-line, followed by a non-
   empty list of integers. 0 < n <= (the number of elements in the list).

=end comment
#===============================================================================

use Test;

subset Pos of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 304, Task #2: Maximum Average (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Pos:D :$n,           #= A positive integer not greater than the size of ints

    *@ints where { .elems > 0 && .all ~~ Int:D } #= A non-empty list of integers
)
#===============================================================================
{
    $n <= @ints.elems or error( "\$n is too large" );

    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my Rat $max-avg = find-max-average( @ints, $n );

    "Output: $max-avg".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-max-average
(
    List:D[Int:D] $ints where { .elems > 0 },
    Pos:D         $n    where { $n <= $ints.elems }
--> Rat:D
)
#-------------------------------------------------------------------------------
{
    my UInt $left  = 0;
    my UInt $right = $n - 1;
    my Int  $total = [+] $ints[ $left .. $right ];
    my Int  $max   = $total;

    while $right < $ints.end
    {
        $total -= $ints[   $left++ ];
        $total += $ints[ ++$right  ];
        $max    = $total if $total > $max;
    }

    return $max / $n;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $n, $expected) = $line.split: / \| /;

        for     $test-name, $ints-str, $n, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @ints    = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Rat $max-avg = find-max-average( @ints, $n.Int );

        is $max-avg, $expected.Rat, $test-name;
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
        Example 1|1 12 -5 -6 50 3|4|12.75
        Example 2|5              |1| 5
        Repeating|1 -1  1        |3| 0.333333
        END
}

################################################################################
