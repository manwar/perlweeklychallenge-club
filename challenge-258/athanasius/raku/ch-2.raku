use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 258
=========================

TASK #2
-------
*Sum of Values*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @int and an integer $k.

Write a script to find the sum of values whose index binary representation has
exactly $k number of 1-bit set.

Example 1

  Input: @ints = (2, 5, 9, 11, 3), $k = 1
  Output: 17

  Binary representation of index 0 = 0
  Binary representation of index 1 = 1
  Binary representation of index 2 = 10
  Binary representation of index 3 = 11
  Binary representation of index 4 = 100

  So the indices 1, 2 and 4 have total one 1-bit sets.
  Therefore the sum, $ints[1] + $ints[2] + $ints[3] = 17

Example 2

  Input: @ints = (2, 5, 9, 11, 3), $k = 2
  Output: 11

Example 3

  Input: @ints = (2, 5, 9, 11, 3), $k = 0
  Output: 2

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
$k is greater than or equal to zero.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. $k is given as the first command-line argument, followed by one or more
   elements of @ints.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 258, Task #2: Sum of Values (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    UInt:D $k,                        #= Target number of 1-digits in each index

    *@ints where { .elems > 0 && .all ~~ Int:D }   #= Non-empty list of integers
)
#===============================================================================
{
    "Input:  \@ints = (%s), \$k = %d\n".printf: @ints.join( ', ' ), $k;

    my Int $sum = find-sum( @ints, $k );

    "Output: $sum".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-sum( List:D[Int:D] $ints, UInt:D $k --> Int:D )
#-------------------------------------------------------------------------------
{
    my Int $sum = 0;

    for 0 .. $ints.end -> UInt $i
    {
        my Str  $binary   = '%b'.sprintf: $i;
        my UInt $one-bits = +( tr/1/*/ with $binary );

        $sum += $ints[ $i ] if $one-bits == $k;
    }

    return $sum;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $int-str, $k-str, $exp-str) = $line.split: / \| /;

        for     $test-name, $int-str, $k-str, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @ints = $int-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int $sum  = find-sum( @ints, $k-str.Int );

        is $sum, $exp-str.Int, $test-name;
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
        Example 1| 2  5  9 11 3|1|17
        Example 2| 2  5  9 11 3|2|11
        Example 3| 2  5  9 11 3|0| 2
        Singleton|42           |0|42
        Negatives|-1 -3 -5 -7  |1|-8
        END
}

################################################################################
