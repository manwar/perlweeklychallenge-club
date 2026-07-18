use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 382
=========================

TASK #1
-------
*Hamiltonian Cycle*

Submitted by: Peter Campbell Smith

You are given a target number.

Write a script to arrange all the whole numbers from 1 up to the given target
number into a circle so that every pair of side-by-side numbers adds up to a
perfect square. Please make sure, the last number and the first must also add up
to a square.

Example 1

  Input: $n = 32
  Output:  1, 8, 28, 21,  4, 32, 17, 19, 30, 6,  3, 13, 12, 24, 25, 11, 5, 31,
          18, 7, 29, 20, 16,  9, 27, 22, 14, 2, 23, 26, 10, 15

  1  + 8  = 9
  8  + 28 = 36
  28 + 21 = 49
  21 + 4  = 25
  4  + 32 = 36
  32 + 17 = 49
  17 + 19 = 36
  19 + 30 = 49

  so on, all the way through the sequence.

Example 2

  Input: $n = 15
  Output: ()

  No valid circular list of numbers exists.

Example 3

  Input: $n = 34
  Output:  1, 8, 28, 21,  4, 32, 17, 19,  6, 30, 34, 15, 10, 26, 23, 2, 14, 22,
          27, 9, 16, 33, 31, 18,  7, 29, 20,  5, 11, 25, 24, 12, 13, 3

[2026-07-13 11:45]: Output was incorrect, corrected by E. Choroba.

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
2. A single, positive integer greater than 1 is entered on the command-line.

Algorithm
---------
Backtracking, implemented via recursion.

The cycle begins with the number 1. A depth-first search of the solution space
is made by examining, recursively, each possible successor to the last entry in
the cycle. At each stage, possible successors are considered in increasing
numerical order (smallest to greatest). The search ends when either the first solution has been found, or all possible solutions have been exhausted.

For testing, the output in Example 3 has been replaced by the cycle found by the
above algorithm.

Timings (rounded to whole seconds)
-------
n:  32 33 34 35 36 37  38  39 40  41 42  43  44   45
s:   3  8  4  3  7 52 142 158 76 153 37 133 372 1337

Reference
---------
[1] OEIS Foundation Inc. (2026), Entry A071984 in The On-Line Encyclopedia of
    Integer Sequences, https://oeis.org/A071984

=end comment
#===============================================================================

use Test;

my Bool constant ASSERT = False;
my Bool constant TIMER  = True;
my UInt constant MIN-N  = 32;              # See [1]: COMMENTS (Bert Dobbelaere)

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 382, Task #1: Hamiltonian Cycle (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    UInt:D $n where * > 1         #= The target number, an integer > 1
)
#===============================================================================
{
    my DateTime $t0 = DateTime.now                if TIMER;

    "Input:  \$n = $n".put;

    my UInt @cycle = find-cycle( $n );

    "Output: (%s)\n"\ .printf: @cycle.join: ', ';
    "\n%.1f seconds\n".printf: DateTime.now - $t0 if TIMER;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-cycle( UInt:D $n where * > 1 --> List:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my UInt @cycle;

    if $n >= MIN-N
    {
        my SetHash $domain = SetHash.new: 2 .. $n;
        @cycle.push: 1;

        if  grow-cycle( $n, @cycle, $domain )
        {
            is-a-cycle( $n, @cycle ) or die 'Logic error' if ASSERT;
        }
        else
        {
            @cycle.pop;
        }
    }

    return @cycle;
}

#-------------------------------------------------------------------------------
sub grow-cycle                                            # Recursive subroutine
(
    UInt:D         $n where * > 1,
    List:D[UInt:D] $cycle,
    SetHash:D      $domain
--> Bool:D
)
#-------------------------------------------------------------------------------
{
    return is-a-cycle( $n, $cycle ) unless $domain.Bool;

    my UInt @partners = find-partners( $n, $cycle );

    if @partners.elems > 0
    {
        for @partners -> UInt $partner
        {
            $domain.unset: $partner;
            $cycle.push:   $partner;

            return True if grow-cycle( $n, $cycle, $domain );

            $cycle.pop;
            $domain.set:   $partner;
        }
    }

    return False;
}

#-------------------------------------------------------------------------------
sub find-partners
(
    UInt:D         $new-n where * > 1,
    List:D[UInt:D] $cycle,
--> List:D[UInt:D]
)
#-------------------------------------------------------------------------------
{
    state UInt $n;
    state UInt @squares;

    if !$n.defined || $n !== $new-n
    {
        $n       = $new-n;
        @squares = init-squares( $n );
    }

    my UInt @partners;
    my UInt $num = $cycle[ *-1 ];

    L-OUTER:
    for @squares -> UInt $square
    {
        if $square > $num
        {
            my UInt $candidate = $square - $num;

            if $n >= $candidate
            {
                for @$cycle -> UInt $term
                {
                    next L-OUTER if $candidate == $term;
                }

                @partners.push: $candidate;
            }
        }
    }

    return @partners;
}

#-------------------------------------------------------------------------------
sub init-squares( UInt:D $n --> List:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my UInt @squares;
    my UInt $max-sq = (2 * $n) - 1;

    for 2 .. * -> UInt $i
    {
        my UInt $square = $i²;

        if $square > $max-sq
        {
            last;
        }
        else
        {
            @squares.push: $square;
        }
    }

    return @squares;
}

#-------------------------------------------------------------------------------
sub is-a-cycle( UInt:D $n where * > 1, List:D[UInt:D] $cycle --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Bool %domain = (1 .. $n).map: { $_ => False };

    for 0 .. $cycle.end -> UInt $i
    {
        my UInt $elem = $cycle[ $i ];

        return False if !(%domain{ $elem }:exists) || %domain{ $elem };

        my UInt $j    = ($i == $cycle.end) ?? 0 !! $i + 1;
        my UInt $sum  =  $elem + $cycle[ $j ];
        my UInt $root = (sqrt( $sum ) + 0.5).floor;

        return False unless $root² == $sum;

        %domain{ $elem } = True;
    }

    $_ || return False for %domain.values;

    return True;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $n, $exp-str) = $line.split: '|';

        for     $test-name, $n, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt @cycle    = find-cycle( $n.Int );
        my UInt @expected = $exp-str.split( / \s+ /, :skip-empty )
                                    .map: { .Int };

        is-deeply @cycle, @expected, $test-name;
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
    my Str $data = q:to/END/;
        Example 1|32| 1  8 28 21  4 32 17 19 30  6  3 13 12 24 25 11  5 31 18  \
                      7 29 20 16  9 27 22 14  2 23 26 10 15
        Example 2|15|
        Example 3|34| 1  3 13 12  4 32 17  8 28 21 15 34 30 19  6 10 26 23  2  \
                     14 22 27  9 16 33 31 18  7 29 20  5 11 25 24
        END

    return S:g/ \s+ \\ \n \s* / / given $data;
}

################################################################################
