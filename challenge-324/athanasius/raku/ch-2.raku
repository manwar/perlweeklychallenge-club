use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 324
=========================

TASK #2
-------
*Total XOR*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to return the sum of total XOR for every subset of given array.

Example 1

  Input: @ints = (1, 3)
  Output: 6

  Subset [1],    total XOR = 1
  Subset [3],    total XOR = 3
  Subset [1, 3], total XOR => 1 XOR 3 => 2

  Sum of total XOR => 1 + 3 + 2 => 6

Example 2

  Input: @ints = (5, 1, 6)
  Output: 28

  Subset [5],       total XOR = 5
  Subset [1],       total XOR = 1
  Subset [6],       total XOR = 6
  Subset [5, 1],    total XOR => 5 XOR 1 => 4
  Subset [5, 6],    total XOR => 5 XOR 6 => 3
  Subset [1, 6],    total XOR => 1 XOR 6 => 7
  Subset [5, 1, 6], total XOR => 5 XOR 1 XOR 6 => 2

  Sum of total XOR => 5 + 1 + 6 + 4 + 3 + 7 + 2 => 28

Example 3

  Input: @ints = (3, 4, 5, 6, 7, 8)
  Output: 480

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
The input integers are unsigned.

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
    "\nChallenge 324, Task #2: Total XOR (Raku)\n".put;
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

    my UInt $sum = find-total-xor( @ints );

    "Output: $sum".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-total-xor( List:D[UInt:D] $ints --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $sum = 0;

    for $ints.combinations
    {
        $sum += [+^] $_;
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
        my Str ($test-name, $ints-str, $expected) = $line.split: / \| /;

        for     $test-name, $ints-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt @ints = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt $sum  = find-total-xor( @ints );

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
        Example 1|1 3        |  6
        Example 2|5 1 6      | 28
        Example 3|3 4 5 6 7 8|480
        END
}

################################################################################
