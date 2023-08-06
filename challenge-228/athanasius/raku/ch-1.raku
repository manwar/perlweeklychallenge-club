use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 228
=========================

TASK #1
-------
*Unique Sum*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out the sum of unique elements in the given array.

Example 1

  Input: @int = (2, 1, 3, 2)
  Output: 4

  In the given array we have 2 unique elements (1, 3).

Example 2

  Input: @int = (1, 1, 1, 1)
  Output: 0

  In the given array no unique element found.

Example 3

  Input: @int = (2, 1, 3, 4)
  Output: 10

  In the given array every element is unique.

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
2. If $VERBOSE is set to True, the solution is followed by a list of the unique
   elements in the array.

=end comment
#===============================================================================

use Test;

my Bool constant $VERBOSE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 228, Task #1: Unique Sum (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@int where { .elems > 0 && * ~~ Int:D }     #= A non-empty list of integers
)
#===============================================================================
{
    "Input:  \@int = (%s)\n".printf: @int.join: ', ';

    my (Int $sum, Array[Int] $uniq) = find-sum( @int );

    "Output: $sum".put;

    "\nUnique elements: (%s)\n".printf: @$uniq.join: ', ' if $VERBOSE;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-sum( List:D[Int:D] $ints --> List:D[Int:D, List:D[Int:D]] )
#-------------------------------------------------------------------------------
{
    my %freq;
     ++%freq{ $_ } for @$ints;

    my Int $sum = 0;
    my Int @uniq;

    for @$ints -> Int $n
    {
        if %freq{ $n } == 1
        {
            $sum += $n;
            @uniq.push: $n;
        }
    }

    @uniq .= sort;

    return $sum, @uniq;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test, $int-str, $exp-sum, $exp-uniq-str) = $line.split: / \| /;

        for     $test, $int-str, $exp-sum, $exp-uniq-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @int = $int-str\    .split( / \s+ /, :skip-empty ).map: { .Int };
        my Int @exp = $exp-uniq-str.split( / \s+ /, :skip-empty ).map: { .Int };

        my (Int $sum, Array[Int] $uniq) = find-sum( @int );

        is        $sum,  $exp-sum, "$test: sum";
        is-deeply $uniq, @exp,     "$test: unique";
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
        Example 1|2 1 3 2| 4|1 3
        Example 2|1 1 1 1| 0|
        Example 3|2 1 3 4|10|1 2 3 4
        END
}

################################################################################
