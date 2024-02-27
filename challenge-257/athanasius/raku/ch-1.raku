use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 257
=========================

TASK #1
-------
*Smaller than Current*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find out how many integers are smaller than current i.e.
foreach ints[i], count ints[j] < ints[i] where i != j.

Example 1

  Input: @ints = (5, 2, 1, 6)
  Output: (2, 1, 0, 3)

  For $ints[0] = 5, there are two integers (2,1) smaller than 5.
  For $ints[1] = 2, there is one integer (1) smaller than 2.
  For $ints[2] = 1, there is none integer smaller than 1.
  For $ints[3] = 6, there are three integers (5,2,1) smaller than 6.

Example 2

  Input: @ints = (1, 2, 0, 3)
  Output: (1, 2, 0, 3)

Example 3

  Input: @ints = (0, 1)
  Output: (0, 1)

Example 4

  Input: @ints = (9, 4, 9, 2)
  Output: (2, 1, 2, 0)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
If no command-line arguments are given, the test suite is run.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 257, Task #1: Smaller than Current (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty array of integers

    *@ints where { .elems > 0 && .all ~~ Int:D }
)
#===============================================================================
{
    "Input: \@ints = (%s)\n".printf: @ints.join: ', ';

    my UInt @counts = count-smaller-than-current( @ints );

    "Output:        (%s)\n".printf: @counts.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-smaller-than-current( List:D[Int:D] $ints --> List:D[UInts:D] )
#-------------------------------------------------------------------------------
{
    my UInt @counts;

    for 0 .. $ints.end -> UInt $i
    {
        my UInt $count = 0;

        for 0 .. $ints.end -> UInt $j
        {
            next if $i == $j;

            ++$count if $ints[ $j ] < $ints[ $i ];
        }

        @counts.push: $count;
    }

    return @counts;
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

        my Int  @ints   = ($int-str.split: / \s+ /, :skip-empty).map: { .Int };
        my UInt @exp    = ($exp-str.split: / \s+ /, :skip-empty).map: { .Int };
        my UInt @counts =  count-smaller-than-current( @ints );

        is-deeply @counts, @exp, $test-name;
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
        Example 1| 5  2  1 6|2 1 0 3
        Example 2| 1  2  0 3|1 2 0 3
        Example 3| 0  1     |0 1
        Example 4| 9  4  9 2|2 1 2 0
        Negatives|-2 -2 -1  |0 0 2
        END
}

################################################################################
