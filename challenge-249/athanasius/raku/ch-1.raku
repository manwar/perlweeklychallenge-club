use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 249
=========================

TASK #1
-------
*Equal Pairs*

Submitted by: Mohammad S Anwar

You are given an array of integers with even number of elements.

Write a script to divide the given array into equal pairs such that:

  a) Each element belongs to exactly one pair.
  b) The elements present in a pair are equal.

Example 1

  Input: @ints = (3, 2, 3, 2, 2, 2)
  Output: (2, 2), (3, 3), (2, 2)

  There are 6 elements in @ints.
  They should be divided into 6 / 2 = 3 pairs.
  @ints is divided into the pairs (2, 2), (3, 3), and (2, 2) satisfying all the
  conditions.

Example 2

  Input: @ints = (1, 2, 3, 4)
  Output: ()

  There is no way to divide @ints 2 pairs such that the pairs satisfy every
  condition.

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
2. If the first command-line argument is negative, it must be preceded by "--"
   to distinguish it from a command-line switch.

Algorithm
---------


=end comment
#===============================================================================

use Test;

subset IntPair of List where (Int, Int);

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 249, Task #1: Equal Pairs (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty, even-numbered list of integers

    *@ints where { .elems > 0 && .elems %% 2 && .all ~~ Int:D }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my IntPair @pairs = find-equal-pairs( @ints );

    "Output: %s\n".printf:
        @pairs ?? @pairs.map( { '(' ~ .join( ', ' ) ~ ')' } ).join: ', '
               !! '()';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-equal-pairs
(
    List:D[Int:D] $ints where { .elems %% 2 }   # Even-numbered list of integers
--> List:D[IntPair:D]                           # Equal pairs (may be empty)
)
#-------------------------------------------------------------------------------
{
    my IntPair @pairs;

    # Change from IntStr to Int, then sort (numerical ascending)

    my Int @sorted = $ints.map( { .Int } ).sort;

    while @sorted
    {
        my IntPair $pair = [ @sorted.shift, @sorted.shift ];

        if $pair[ 0 ] == $pair[ 1 ]
        {
            @pairs.push: $pair;
        }
        else    # No solution is possible
        {
            @pairs = ();
            last;
        }
    }

    return @pairs;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str,  @exp-pair-strs) = $line.split: / \| /;

        for     $test-name, $ints-str, |@exp-pair-strs
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int     @ints  = $ints-str.split( / \s+ / ).map: { .Int };
        my IntPair @pairs = find-equal-pairs( @ints );
        my IntPair @expected;

        for @exp-pair-strs
        {
            @expected.push: [ .split( / \s+ / ).map: { .Int } ] if $_;
        }

        is-deeply @pairs, @expected, $test-name;
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
        Example 1  | 3 2 3  2 2 2          | 2  2| 2  2|3 3
        Example 2  | 1 2 3  4              |
        Negatives 1|-1 1 3 -1 3 1 -1 -1    |-1 -1|-1 -1|1 1|3 3
        Negatives 2|-1 1 3 -1 3 1 -1 -1 0 1|
        END
}

################################################################################
