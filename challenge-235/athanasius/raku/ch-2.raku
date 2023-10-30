use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 235
=========================

TASK #2
-------
*Duplicate Zeros*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to duplicate each occurrence of ZERO in the given array and shift
the remaining to the right but make sure the size of array remain the same.

Example 1

  Input: @ints = (1, 0, 2, 3, 0, 4, 5, 0)
  Output: (1, 0, 0, 2, 3, 0, 0, 4)

Example 2

  Input: @ints = (1, 2, 3)
  Output: (1, 2, 3)

Example 3

  Input: @ints = (0, 3, 0, 4, 5)
  Output: (0, 0, 3, 0, 0)

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
    "\nChallenge 235, Task #2: Duplicate Zeros (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@ints where { .elems > 0 && .all ~~ Int:D } #= A non-empty list of integers
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my Int @dups = duplicate-zeros( @ints );

    "Output: \@dups = (%s)\n".printf: @dups.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub duplicate-zeros( List:D[Int:D] $ints --> List:D[Int:D] )
#-------------------------------------------------------------------------------
{
    my Int @dups;

    for @$ints -> Int $n
    {
        @dups.push: $n;
        @dups.push: 0 if $n == 0;
    }

    return @dups[ 0 .. $ints.end ];
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

        my Int @ints = $int-str.split( / \s+ / ).map: { .Int };
        my Int @exp  = $exp-str.split( / \s+ / ).map: { .Int };
        my Int @dups = duplicate-zeros( @ints );

        is-deeply @dups, @exp, $test-name;
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
        Example 1| 1 0  2  3 0 4 5 0| 1 0 0  2  3 0 0 4
        Example 2| 1 2  3           | 1 2 3
        Example 3| 0 3  0  4 5      | 0 0 3  0  0
        Singleton| 0                | 0
        Negatives|-3 0 -2 -1 0      |-3 0 0 -2 -1
        END
}

################################################################################
