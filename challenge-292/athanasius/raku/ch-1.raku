use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 292
=========================

TASK #1
-------
*Twice Largest*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints, where the largest integer is unique.

Write a script to find whether the largest element in the array is at least
twice as big as every element in the given array. If it is return the index of
the largest element or return -1 otherwise.

Example 1

  Input: @ints = (2, 4, 1, 0)
  Output: 1

  The largest integer is 4.
  For every other elements in the given array is at least twice as big.
  The index value of 4 is 1.

Example 2

  Input: @ints = (1, 2, 3, 4)
  Output: -1

  The largest integer is 4.
  4 is less than twice the value of 3, so we return -1.

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
2. A non-empty list of integers is entered on the command-line.
3. If the first integer is negative, it must be preceded by "--" to prevent it
   from being interpreted as a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 292, Task #1: Twice Largest (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of integers

    *@ints where { .elems > 0 && .all ~~ Int:D && max-is-unique( @ints ) }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my Int $index = twice-largest( @ints );

    "Output: $index".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub twice-largest( List:D[Int:D] $ints where { .elems > 0 } --> Int:D )
#-------------------------------------------------------------------------------
{
    return 0 if $ints.elems == 1;

    my UInt $idx = 0;
    my Int  $max = $ints[ 0 ];

    for 0 .. $ints.end -> UInt $i
    {
        if $ints[ $i ] > $max
        {
            $idx = $i;
            $max = $ints[ $i ];
        }
    }

    my Int @sorted = $ints.sort.reverse;

    return @sorted[ 0 ] >= 2 * @sorted[ 1 ] ?? $idx !! -1;
}

#-------------------------------------------------------------------------------
sub max-is-unique( List:D[Int:D] $ints where { .elems > 0 } --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Int  $max   = $ints.max;
    my UInt $count = 0;

    $_ == $max && ++$count for @$ints;

    return $count == 1;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $int-str, $expected) = $line.split: / \| /;

        for     $test-name, $int-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @ints  = $int-str.split( / \s+ / ).map: { .Int };
        my Int $index = twice-largest( @ints );

        is $index, $expected, $test-name;
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
        Example 1|2 4 1 0| 1
        Example 2|1 2 3 4|-1
        END
}

################################################################################
