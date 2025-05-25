use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 322
=========================

TASK #2
-------
*Rank Array*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to return an array of the ranks of each element: the lowest value
has rank 1, next lowest rank 2, etc. If two elements are the same then they
share the same rank.

Example 1

  Input: @ints = (55, 22, 44, 33)
  Output: (4, 1, 3, 2)

Example 2

  Input: @ints = (10, 10, 10)
  Output: (1, 1, 1)

Example 3

  Input: @ints = (5, 1, 1, 4, 3)
  Output: (4, 1, 1, 3, 2)

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
3. If the first list element is negative, it must preceded by "--" to indicate
   that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 322, Task #2: Rank Array (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of integers

    *@ints where { .elems > 0 && .all ~~ Int:D }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints\.join: ', ';

    my UInt @ranks = find-ranks( @ints );

    "Output: (%s)\n".printf: @ranks.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-ranks( List:D[Int:D] $ints --> List:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my Int  @sorted = $ints.sort.squish.map: { .Int };
    my UInt %rank{Int};

    for 0 .. @sorted.end -> UInt $i
    {
        %rank{ @sorted[ $i ] } = $i + 1;
    }

    my UInt @ranks;

    for 0 .. $ints.end -> UInt $i
    {
        @ranks.push: %rank{ +$ints[ $i ] };
    }

    return @ranks;
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

        my Int  @ints    = $int-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt @ranks   = find-ranks( @ints );
        my UInt @expectd = $exp-str.split( / \s+ /, :skip-empty ).map: { .Int };

        is-deeply @ranks, @expectd, $test-name;
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
        Example 1|55 22 44 33  |4 1 3 2
        Example 2|10 10 10     |1 1 1
        Example 3| 5  1  1  4 3|4 1 1 3 2
        END
}

################################################################################
