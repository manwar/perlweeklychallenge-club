use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 226
=========================

TASK #2
-------
*Zero Array*

Submitted by: Mohammad S Anwar

You are given an array of non-negative integers, @ints.

Write a script to return the minimum number of operations to make every element
equal zero.

    In each operation, you are required to pick a positive number less than or
    equal to the smallest element in the array, then subtract that from each
    positive element in the array.

Example 1:

  Input: @ints = (1, 5, 0, 3, 5)
  Output: 3

  operation 1: pick 1 => (0, 4, 0, 2, 4)
  operation 2: pick 2 => (0, 2, 0, 0, 2)
  operation 3: pick 2 => (0, 0, 0, 0, 0)

Example 2:

  Input: @ints = (0)
  Output: 0

Example 3:

  Input: @ints = (2, 1, 4, 0, 3)
  Output: 4

  operation 1: pick 1 => (1, 0, 3, 0, 2)
  operation 2: pick 1 => (0, 0, 2, 0, 1)
  operation 3: pick 1 => (0, 0, 1, 0, 0)
  operation 4: pick 1 => (0, 0, 0, 0, 0)

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
2. It $VERBOSE is set to True, the operations (pick values) are described, as
   per Examples 1 and 3.

Assumption
----------
A "positive element" is an array value greater than zero.

=end comment
#===============================================================================

use Test;

subset Pos of Int where * > 0;

my Bool constant $VERBOSE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 226, Task #2: Zero Array (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A list of one or more non-negative integers

    *@ints where { .elems > 0 && .all ~~ UInt:D }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my Pos @ops = find-min-ops( @ints );

    "Output: %d\n".printf: @ops.elems;

    if $VERBOSE && @ops.elems > 0
    {
        put();

        my UInt @list = @ints;

        for 0 .. @ops.end -> UInt $i
        {
            my Pos $pick = @ops[ $i ];

            @list .= map: { $_ > 0 ?? $_ - $pick !! $_ };

            "Operation %d: pick %d => (%s)\n".printf:
                $i + 1, $pick, @list.join: ', ';
        }
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-min-ops( List:D[UInt:D] $ints --> List:D[Pos:D] )
#-------------------------------------------------------------------------------
{
    my Pos  @ops;
    my UInt @steps = $ints.unique.sort;

    @steps.shift while @steps.elems > 0 && @steps[ 0 ] == 0;

    if @steps.elems > 0
    {
        @ops.push: @steps[ 0 ];

        for 1 .. @steps.end -> Pos $i
        {
            @ops.push: @steps[ $i ] - @steps[ $i - 1 ];
        }
    }

    return @ops;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints, $min-ops, $picks) = $line.split: / \| /;

        for     $test-name, $ints, $min-ops, $picks
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt @ints  = $ints\.split( / \s+ /, :skip-empty ).map: { .Int };
        my Pos  @picks = $picks.split( / \s+ /, :skip-empty ).map: { .Int };
        my Pos  @ops   = find-min-ops( @ints );

        is        @ops.elems, $min-ops.Int, "$test-name: min ops";
        is-deeply @ops,       @picks,       "$test-name: picks";
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
        Example 1|1 5 0 3 5|3|1 2 2
        Example 2|0        |0|
        Example 3|2 1 4 0 3|4|1 1 1 1
        END
}

################################################################################
