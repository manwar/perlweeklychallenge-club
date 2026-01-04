use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 354
=========================

TASK #1
-------
*Min Abs Diff*

Submitted by: Mohammad Sajid Anwar

You are given an array of distinct integers.

Write a script to find all pairs of elements with the minimum absolute
difference.

  Rules (a,b):
  1: a, b are from the given array.
  2: a < b
  3: b - a = min abs diff any two elements in the given array

Example 1

  Input: @ints= (4, 2, 1, 3)
  Output: [1, 2], [2, 3], [3, 4]

Example 2

  Input: @ints = (10, 100, 20, 30)
  Output: [10, 20], [20, 30]

Example 3

  Input: @ints = (-5, -2, 0, 3)
  Output: [-2, 0]

Example 4

  Input: @ints = (8, 1, 15, 3)
  Output: [1, 3]

Example 5

  Input: @ints = (12, 5, 9, 1, 15)
  Output: [9, 12], [12, 15]

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of distinct integers is entered on the command-line.
3. If the first integer is negative, it must be preceded by "--" to indicate
   that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

subset IntPair of List where (Int, Int);

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 354, Task #1: Min Abs Diff (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A list of distinct integers

    *@ints where { .all ~~ Int:D && are-distinct( @ints ) }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my IntPair @pairs = find-min-abs-diff-pairs( @ints );

    "Output: %s\n".printf: @pairs.map( { "[$_[0], $_[1]]" } ).join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-min-abs-diff-pairs
(
    List:D[Int:D] $ints where { are-distinct( $ints ) }
--> List:D[IntPair:D]
)
#-------------------------------------------------------------------------------
{
    my IntPair @pairs;

    if $ints.elems > 1
    {
        my Int  @sorted   = $ints.sort;
        my UInt $min-diff = @sorted[1] - @sorted[0];

        @pairs.push: [ @sorted[0], @sorted[1] ];

        for 1 .. @sorted.end - 1 -> UInt $i
        {
            my UInt $diff = @sorted[$i + 1] - @sorted[$i];

            if $diff <= $min-diff
            {
                if $diff < $min-diff
                {
                    $min-diff = $diff;
                    @pairs    = Empty;
                }

                @pairs.push: [ @sorted[$i], @sorted[$i + 1] ];
            }
        }
    }

    return @pairs;
}

#-------------------------------------------------------------------------------
sub are-distinct( List:D[Int:D] $ints --> Bool:D )
#-------------------------------------------------------------------------------
{
    my UInt %dict{Int};

    for @$ints -> Int $n
    {
        return False if ++%dict{$n} > 1;
    }

    return True;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $int-str,  @expected-strs) = $line.split: / \| /;

        for     $test-name, $int-str, |@expected-strs
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int     @ints     = $int-str.split( / \s+ /, :skip-empty )
                                       .map: { .Int };
        my IntPair @pairs    = find-min-abs-diff-pairs( @ints );
        my IntPair @expected = @expected-strs.map:
                               {
                                   [
                                       .split( / \s+ /, :skip-empty )
                                       .map: { .Int }
                                   ]
                               };

        is-deeply @pairs, @expected, $test-name;
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
        Example 1| 4   2  1  3   | 1  2| 2  3|3 4
        Example 2|10 100 20 30   |10 20|20 30
        Example 3|-5  -2  0  3   |-2  0
        Example 4| 8   1 15  3   | 1  3
        Example 5|12   5  9  1 15| 9 12|12 15
        END
}

################################################################################
