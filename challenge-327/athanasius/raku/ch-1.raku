use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 327
=========================

TASK #1
-------
*Missing Integers*

Submitted by: Mohammad Sajid Anwar

You are given an array of n integers.

Write a script to find all the missing integers in the range 1..n in the given
array.

Example 1

  Input: @ints = (1, 2, 1, 3, 2, 5)
  Output: (4, 6)

  The given array has 6 elements.
  So we are looking for integers in the range 1..6 in the given array.
  The missing integers: (4, 6)

Example 2

  Input: @ints = (1, 1, 1)
  Output: (2, 3)

Example 3

  Input: @ints = (2, 2, 1)
  Output: (3)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of integers is entered on the command-line.
3. If the first integer in the list is negative, it must be preceded by "--" to
   signal that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 327, Task #1: Missing Integers (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of integers

    *@ints where { .elems > 0 && .all ~~ Int:D }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my UInt @missing = find-missing-ints( @ints );

    "Output: (%s)\n".printf: @missing.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-missing-ints( List:D[Int:D] $ints --> List:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my UInt     @missing;
    my Set[Int] $int-set = Set[Int].new: $ints.map: { .Int };  # Int, NOT IntStr

    for 1 .. $ints.elems -> UInt $i
    {
        @missing.push: $i if $i ∉ $int-set;
    }

    return @missing;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $expd-str) = $line.split: / \| /;

        for     $test-name, $ints-str, $expd-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int  @ints     = $ints-str.split( / \s+ /, :skip-empty )
                                     .map: { .Int };
        my UInt @missing  = find-missing-ints( @ints );
        my UInt @expected = $expd-str.split( / \s+ /, :skip-empty )
                                     .map: { .Int };

        is-deeply @missing, @expected, $test-name;
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
        Example 1| 1 2 1 3  2 5|4 6
        Example 2| 1 1 1       |2 3
        Example 3| 2 2 1       |3
        None     | 1 2 3 4  5 6|
        Negatives|-2 0 3 5 -4  |1 2 4
        END
}

################################################################################
