use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 277
=========================

TASK #2
-------
*Strong Pair*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to return the count of all strong pairs in the given array.

    A pair of integers x and y is called strong pair if it satisfies:
    0 < |x - y| < min(x, y).

Example 1

  Input: @ints = (1, 2, 3, 4, 5)
  Output: 4

  Strong Pairs: (2, 3), (3, 4), (3, 5), (4, 5)

Example 2

  Input: @ints = (5, 7, 1, 7)
  Output: 1

  Strong Pairs: (5, 7)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If an explanation of the output is required, the flag "--verbose" is entered
   on the command-line.
3. The input integers are entered as a non-empty list at the end of the command-
   line.
4. If the first input integer is negative, it must be preceded by "--" to
   indicate that it is not a command-line flag.

Assumption
----------
Within a strong pair (x, y), the order of x and y is not significant. So (x, y)
is the same strong pair as (y, x). For convenience, strong pairs are always
given as (x, y) where x < y (see Analysis below).

Analysis
--------
Requirements (given): (a) 0 < |x - y|
                      (b) 0 < min(x, y)         (by transitivity)
                      (c) |x - y| < min(x, y)

1. Let d = |x - y|. If x = y, then d = 0; but from (a) we know that 0 < d, so it
   follows that x ≠ y.
2. For convenience, let each strong pair (x, y) be ordered such that x < y.
   Then min(x, y) = x.
3. From (2) together with (b) it follows that x > 0; and from (1) we know that
   d > 0. But if x = 1, (c) is impossible; therefore, x > 1.
4. From (c) we have y - x < x. Adding x to both sides yields y < 2x.

Summary. For any strong pair (x, y) ordered so that x < y, it is required that:

                      (d) 1 < x < y < 2x

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 277, Task #2: Strong Pair (Raku)\n".put;
}

#-------------------------------------------------------------------------------
class StrongPair
#-------------------------------------------------------------------------------
{
    has Int $.x;
    has Int $.y;

    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    submethod TWEAK                                               # Sanity check
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    {
        $!x < $!y && 0 < $!y - $!x < $!x or die 'Invalid StrongPair';
    }

    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    method format( --> Str:D )
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    {
        return "($!x, $!y)";
    }
}

#===============================================================================
multi sub MAIN
(
    Bool:D :$verbose = False,                    #= Explain the output?

    *@ints where { .elems > 0 && .all ~~ Int:D } #= A non-empty list of integers
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my StrongPair @pairs = find-strong-pairs( @ints );
    my UInt       $count = @pairs.elems;

    "Output: $count".put;

    if $verbose && $count > 0
    {
        "\nStrong pair%s: %s\n".printf:
         $count == 1 ?? '' !! 's', @pairs.map( { .format } ).join: ', ';
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-strong-pairs( List:D[Int:D] $ints-arg --> List:D[StrongPair:D] )
#-------------------------------------------------------------------------------
{
    my Int        @ints = $ints-arg.grep( { $_ > 1 } ).unique.sort;
    my StrongPair @pairs;

    for 0 .. @ints.end - 1 -> UInt $i
    {
        for $i + 1 .. @ints.end -> UInt $j
        {
            my Int $x = @ints[ $i ];
            my Int $y = @ints[ $j ];

            if $y < 2 * $x              # See requirement (d) in Analysis, above
            {
                @pairs.push: StrongPair.new: :$x, :$y;
            }
            else
            {
                last;
            }
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
        my Str ($test-name, $ints-str, $exp-str) = $line.split: / \| /;

        for     $test-name, $ints-str, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int        @ints     = int-split( $ints-str );
        my StrongPair @pairs    = find-strong-pairs( @ints );
        my Str        @exp-strs = $exp-str.split: / \; \s* /, :skip-empty;
        my StrongPair @expected;

        for @exp-strs -> Str $str
        {
            my Int ($x, $y) = int-split( $str );

            @expected.push: StrongPair.new: :$x, :$y;
        }

        is-deeply @pairs, @expected, $test-name; 
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub int-split( Str:D $str --> Seq:D[Int:D] )
#-------------------------------------------------------------------------------
{
    return $str.split( / \s+ /, :skip-empty ).map: { .Int };
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
        Example 1|1 2 3 4 5|2 3; 3 4; 3 5; 4 5
        Example 2|5 7 1 7  |5 7
        END
}

################################################################################
