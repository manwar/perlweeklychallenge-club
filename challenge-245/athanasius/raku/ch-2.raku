use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 245
=========================

TASK #2
-------
*Largest of Three*

Submitted by: Mohammad S Anwar

You are given an array of integers >= 0.

Write a script to return the largest number formed by concatenating some of the
given integers in any order which is also multiple of 3. Return -1 if none
found.

Example 1

  Input: @ints = (8, 1, 9)
  Output: 981

  981 % 3 == 0

Example 2

  Input: @ints = (8, 6, 7, 1, 0)
  Output: 8760

Example 3

  Input: @ints = (1)
  Output: -1

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Assumption
----------
Duplicates are allowed in the input list.

Observation
-----------
Any natural number represented in decimal (aka denary) notation is a multiple of
3 if and only if the recursive sum of its digits is also a multiple of 3.

    For example, 819 -> 8 + 1 + 9 = 18 -> 1 + 8 = 9, and 9 is a multiple of 3,
    so 819 has been shown to be a multiple of 3.

From this it follows that, for any given subset of the input integers, concaten-
ating and testing for multiplicity-of-3 will give the same result regardless of
the order in which the integers are concatenated. The solution below takes ad-
vantage of this fact by testing only the largest number which can be formed by
concatenating each possible subset. Since candidate solutions are evaluated in
order from largest to smallest, the first successful candidate is immediately
returned as the best solution.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 245, Task #2: Largest of Three (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@ints where { .elems > 0 && .all ~~ UInt:D }     #= A list of integers >= 0
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my Int $lot = largest-of-three( @ints );

    "Output: $lot".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub largest-of-three( List:D[UInt:D] $ints --> Int:D )
#-------------------------------------------------------------------------------
{
    # Note the use of the *stringwise* comparison operator leg instead of <=>
    # here: this effectively sorts by digits, most- to least-significant,
    # rather than by total numerical value

    my UInt @sorted = $ints.sort: { $^b leg $^a };

    for @sorted.elems ... 1 -> UInt $digits
    {
        for @sorted.combinations( $digits )
        {
            my UInt $candidate = .join( '' ).Int;

            return  $candidate if $candidate %% 3;
        }
    }

    return -1;
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

        my Int @ints = $ints-str.split( / \s+ / ).map: { .Int };
        my Int $lot  = largest-of-three( @ints );

        is $lot, $expected.Int, $test-name;
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
        Example 1|  8  1   9    |  981
        Example 2|  8  6   7 1 0| 8760
        Example 3|  1           |   -1
        Multiples|  1  1   4 2  |  411
        Small    |  8  2   9    |    9
        Tens     | 81  9  10    |  981
        Hundreds |198 30 500    |30198
        END
}

################################################################################
