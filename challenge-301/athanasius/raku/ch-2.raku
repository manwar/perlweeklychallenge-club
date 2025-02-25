use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 301
=========================

TASK #2
-------
*Hamming Distance*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to return the sum of Hamming distances between all the pairs of
the integers in the given array of integers.

  The Hamming distance between two integers is the number of places in which
  their binary representations differ.

Example 1

  Input: @ints = (4, 14, 2)
  Output: 6

  Binary representation:
  4  => 0100
  14 => 1110
  2  => 0010

  HammingDistance(4, 14) + HammingDistance(4, 2) + HammingDistance(14, 2) = 2 +
  2 + 2 = 6.

Example 2

  Input: @ints = (4, 14, 4)
  Output: 4

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
The given integers are unsigned.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of unsigned integers is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 301, Task #2: Hamming Distance (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of unsigned integers

    *@ints where { .elems > 0 && .all ~~ UInt:D }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my UInt  $sum = find-sum-of-distances( @ints );

    "Output: $sum".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-sum-of-distances( List:D[UInt:D] $ints --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $sum = 0;

    for 0 .. $ints.end - 1 -> UInt $i
    {
        for $i + 1 .. $ints.end -> UInt $j
        {
            $sum += hamming-distance( $ints[ $i ], $ints[ $j ] );
        }
    }

    return $sum;
}

#-------------------------------------------------------------------------------
sub hamming-distance( UInt:D $p, UInt:D $q --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $count =  0;
    my Str  $bin-p = '%b'.sprintf: $p;
    my Str  $bin-q = '%b'.sprintf: $q;
    my UInt $max-c = ($bin-p.chars, $bin-q.chars).max;

    # Prepend zeros to make the binary representations the same length

    $_ = '0' x ($max-c - .chars) ~ $_ for $bin-p, $bin-q;

    for 0 .. $max-c - 1 -> UInt $i
    {
        ++$count unless $bin-p.substr( $i, 1 ) eq $bin-q.substr( $i, 1 );
    }

    return $count;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $expected) = $line.split: / \| /;

        for     $test-name, $ints-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt @ints = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt $sum  = find-sum-of-distances( @ints );

        is $sum, $expected.Int, $test-name;
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
        Example 1|4 14 2|6
        Example 2|4 14 4|4
        END
}

################################################################################
