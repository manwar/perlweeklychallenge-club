use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 333
=========================

TASK #2
-------
*Duplicate Zeros*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to duplicate each occurrence of zero, shifting the remaining
elements to the right. The elements beyond the length of the original array are
not written.

Example 1

  Input: @ints = (1, 0, 2, 3, 0, 4, 5, 0)
  Output: (1, 0, 0, 2, 3, 0, 0, 4)

  Each zero is duplicated.
  Elements beyond the original length (like 5 and last 0) are discarded.

Example 2

  Input: @ints = (1, 2, 3)
  Output: (1, 2, 3)

  No zeros exist, so the array remains unchanged.

Example 3

  Input: @ints = (1, 2, 3, 0)
  Output: (1, 2, 3, 0)

Example 4

  Input: @ints = (0, 0, 1, 2)
  Output: (0, 0, 0, 0)

Example 5

  Input: @ints = (1, 2, 0, 3, 4)
  Output: (1, 2, 0, 0, 3)

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
3. If the first integer is negative, it must be preceded by "--" to indicate
   that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 333, Task #2: Duplicate Zeros (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of integers

    *@ints where { .elems > 0 && .all ~~ Int:D }
)
#===============================================================================
{
    "Input: \@ints = (%s)\n".printf: @ints.join: ', ';

    my Int @dups = duplicate-zeros( @ints );

    "Output:        (%s)\n"\.printf: @dups.join: ', ';
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

    for @$ints -> Int $int
    {
        @dups.push: $int;
        @dups.push: 0 if $int == 0;
    }

    return @dups[ ^$ints.elems ];
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

        my Int @ints = $int-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int @exps = $exp-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int @dups = duplicate-zeros( @ints );

        is-deeply @dups, @exps, $test-name;
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
        Example 1|1 0 2 3 0 4 5 0|1 0 0 2 3 0 0 4
        Example 2|1 2 3          |1 2 3
        Example 3|1 2 3 0        |1 2 3 0
        Example 4|0 0 1 2        |0 0 0 0
        Example 5|1 2 0 3 4      |1 2 0 0 3
        END
}

################################################################################
