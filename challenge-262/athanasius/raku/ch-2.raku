use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 262
=========================

TASK #2
-------
*Count Equal Divisible*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints and an integer $k.

Write a script to return the number of pairs (i, j) where

  a) 0 <= i < j < size of @ints
  b) ints[i] == ints[j]
  c) i x j is divisible by k

Example 1

  Input: @ints = (3,1,2,2,2,1,3) and $k = 2
  Output: 4

  (0, 6) => ints[0] == ints[6] and 0 x 6 is divisible by 2
  (2, 3) => ints[2] == ints[3] and 2 x 3 is divisible by 2
  (2, 4) => ints[2] == ints[4] and 2 x 4 is divisible by 2
  (3, 4) => ints[3] == ints[4] and 3 x 4 is divisible by 2

Example 2

  Input: @ints = (1,2,3) and $k = 1
  Output: 0

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
The divisor $k may take any integer value, positive or negative, except zero.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The divisor $k is given on the command-line as a named argument, followed by
   a (possibly empty) list of integers.
3. If the first integer in the list (i.e., following $k) on the command-line is
   negative, it must be preceded by "--" to indicate that it is not a command-
   line flag.
4. If the constant VERBOSE is set to True, the output count is followed by a
   list of the (i, j) pairs themselves.

=end comment
#===============================================================================

use Test;

my Bool constant VERBOSE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 262, Task #2: Count Equal Divisible (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Int:D :$k where { $k != 0 },              #= The divisor: a non-zero integer
          *@ints where { .all ~~ Int:D }      #= A list of integers
)
#===============================================================================
{
    "Input:  \@ints = (%s) and \$k = %d\n".printf: @ints.join( ', ' ), $k;

    my Pair @pairs = find-equal-divisible-pairs( @ints, $k );

    "Output: %d\n".printf: @pairs.elems;

    "\nPairs found: %s\n".printf:
        @pairs.map( { '(' ~ .key ~ ', ' ~ .value ~ ')' } ).join( ', ' )
            if VERBOSE;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-equal-divisible-pairs
(
    List:D[Int:D] $ints,
    Int:D         $k where { $k != 0 }
--> List:D[Pair:D]
)
#-------------------------------------------------------------------------------
{
    my Pair @pairs;

    for 0 .. $ints.end - 1 -> UInt $i
    {
        for $i + 1 .. $ints.end -> UInt $j
        {
            @pairs.push: $i => $j
                if $ints[ $i ] == $ints[ $j ] && ($i * $j) %% $k;
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
        my Str ($test-name, $ints-str, $k-str, $expected) =
                $line.split: / \| /;

        for     $test-name, $ints-str, $k-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int  @ints  = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Pair @pairs = find-equal-divisible-pairs( @ints, $k-str.Int );

        is @pairs.elems, $expected.Int, $test-name;
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
        Example 1      | 3  1 2  2  2  1  3| 2|4
        Example 2      | 1  2 3            | 1|0
        Negative $k 1  | 3  1 2  2  2  1  3|-1|5
        Negative $k 2  | 3  1 2  2  2  1  3|-2|4
        Negative ints 1|-3 -1 2 -2 -2 -1 -3| 2|2
        Negative ints 2|-3 -1 2 -2 -2 -1 -3|-2|2
        END
}

################################################################################
