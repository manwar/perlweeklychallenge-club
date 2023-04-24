use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 213
=========================

TASK #1
-------
*Fun Sort*

Submitted by: Mohammad S Anwar

You are given a list of positive integers.

Write a script to sort the all even integers first then all odds in ascending
order.

Example 1

  Input: @list = (1,2,3,4,5,6)
  Output: (2,4,6,1,3,5)

Example 2

  Input: @list = (1,2)
  Output: (2,1)

Example 3

  Input: @list = (1)
  Output: (1)

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
A "positive" integer is greater than zero.

=end comment
#===============================================================================

use Test;

subset Pos of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 213, Task #1: Fun Sort (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of positive integers

    *@list where { .elems > 0 && .all ~~ Pos:D }
)
#===============================================================================
{
    "Input:  \@list = (%s)\n".printf: @list.join: ',';

    my Pos @sorted = fun-sort( @list );

    "Output:         (%s)\n".printf: @sorted.join: ',';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub fun-sort( List:D[Pos:D] $list where { .elems > 0 } --> List:D[Pos:D] )
#-------------------------------------------------------------------------------
{
    my Pos (@evens, @odds);

    for @$list -> Pos $element
    {
        ($element %% 2 ?? @evens !! @odds).push: $element;
    }

    return (|@evens.sort, |@odds.sort).List;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $list, $expected) = $line.split: / \| /;

        s/ \s+ $ // for $test-name, $list;          # Trim whitespace

        my Pos @expected = $expected.split( ',' ).Int;
        my Pos @list     = $list\   .split( ',' ).Int;
        my Pos @got      = fun-sort( @list );

        is-deeply @got, @expected, $test-name;
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
        Example 1|1,2,3,4,5,6|2,4,6,1,3,5
        Example 2|1,2        |2,1
        Example 3|1          |1
        END
}

################################################################################
