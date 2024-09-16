use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 283
=========================

TASK #2
-------
*Digit Count Value*

Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers, @ints.

Write a script to return true if for every index i in the range 0 <= i < size of
array, the digit i occurs exactly the $ints[$i] times in the given array other-
wise return false.

Example 1

  Input: @ints = (1, 2, 1, 0)
  Output: true

  $ints[0] = 1, the digit 0 occurs exactly 1 time.
  $ints[1] = 2, the digit 1 occurs exactly 2 times.
  $ints[2] = 1, the digit 2 occurs exactly 1 time.
  $ints[3] = 0, the digit 3 occurs 0 time.

Example 2

  Input: @ints = (0, 3, 0)
  Output: false

  $ints[0] = 0, the digit 0 occurs 2 times rather than 0 time.
  $ints[1] = 3, the digit 1 occurs 0 time rather than 3 times.
  $ints[2] = 0, the digit 2 occurs exactly 0 time.

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
2. A list of positive integers is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 283, Task #2: Digit Count Value (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@ints where { .elems > 0 && .all ~~ UInt:D } #= A list of positive integers
)
#===============================================================================
{
    my UInt @ints_ = @ints.map: { .Int };         # Turn IntStr's back into Ints

    "Input:  \@ints = (%s)\n".printf: @ints_.join: ', ';

    my Bool $match = indices-match-freqs( @ints_ );

    "Output: %s\n".printf: $match ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub indices-match-freqs( List:D[UInt:D] $ints --> Bool:D )
#-------------------------------------------------------------------------------
{
    my UInt %count{UInt};

    ++%count{ $_ } for @$ints;

    for 0 .. $ints.end -> UInt $i
    {
        my UInt $value = $ints[ $i ];

        if $value == 0
        {
            return False if %count{ $i }:exists;
        }
        else
        {
            return False if %count{ $i } !== $value;
        }
    }

    return True;
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

        my UInt @ints  = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Str  $match = indices-match-freqs( @ints ) ?? 'true' !! 'false';

        is $match, $expected, $test-name;
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
        Example 1|1 2 1 0|true
        Example 2|0 3 0  |false
        END
}

################################################################################
