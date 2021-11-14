use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 138
=========================

TASK #2
-------
*Split Number*

Submitted by: Mohammad S Anwar

You are given a perfect square.

Write a script to figure out if the square root the given number is same as sum
of 2 or more splits of the given number.

Example 1

 Input: $n = 81
 Output: 1

 Since, sqrt(81) = 8 + 1

Example 2

 Input: $n = 9801
 Output: 1

Since, sqrt(9801) = 98 + 0 + 1

 Example 3

 Input: $n = 36
 Output: 0

 Since, sqrt(36) != 3 + 6

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
Output is as per the Examples, except that $n's square root is also given. If a
simpler output (with no square root and no explanation) is desired, set the
constant $VERBOSE to False.

Algorithm
---------
The partitioning of "$n" into its possible substrings is accomplished by the
recursive subroutine get_splits_recursive(), which is adapted from the C++
implementation in "Print all ways to break a string in bracket form" at:
https://www.geeksforgeeks.org/print-ways-break-string-bracket-form/.

Performance
-----------
A string of length s may be partitioned in 2 ^ (s - 1) different ways. For long
strings (i.e., high values of $n), it may be expected that this will incur
significant memory usage. In practice (by which I mean: by my observations
using the Windows Task Manager), memory usage begins to become noticeably large
only when $n reaches 13 digits in length.

=end comment
#==============================================================================

my Bool constant $VERBOSE = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 138, Task #2: Split Number (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D $n where is-square( $n )                         #= A perfect square
)
#==============================================================================
{
    my UInt $root = $n.sqrt.Int;

    "Input:  \$n = %d%s\n".printf: $n, $VERBOSE ?? " (sqrt $root)" !! '';

    my Array[UInt] @splits   = Partition::get-splits( $n );
    my UInt        @solution = find-solution( $root, @splits );

    "Output: %d\n".printf: @solution.elems > 0 ?? 1 !! 0;

    if $VERBOSE
    {
        if @solution.elems > 0
        {
            qq[\nSince "%d" can be split into %s = %d\n].printf:
                $n, @solution.join( ' + ' ), $root;
        }
        else
        {
            qq[\nSince no split of "$n" sums to $root].put;
        }
    }
}

#------------------------------------------------------------------------------
sub find-solution
(
    UInt:D                   $root,
    Array:D[Array:D[UInt:D]] $splits
--> Array:D[UInt:D]
)
#------------------------------------------------------------------------------
{
    my UInt @solution;

    for @$splits -> Array[UInt] $split
    {
        my UInt $sum = [+] @$split;

        if $sum == $root
        {
            @solution = @$split;
            last;
        }
    }

    return @solution;   # The first partition of $n (if any) that sums to $root
}

#==============================================================================
package Partition
#==============================================================================
{
    my Array[Str] @partitions;

    #--------------------------------------------------------------------------
    our sub get-splits( UInt:D $n --> Array:D[Array:D[UInt:D]] )
    #--------------------------------------------------------------------------
    {
        # (1) Find all possible unique partitions of the string "$n"

        get-splits-recursive( $n, 0, [] );

        # (2) Weed out multi-digit numbers beginning with zero

        my Array[UInt] @splits;

        L-OUTER:
        for @partitions -> Array[Str] $comb
        {
            for @$comb -> Str $seg
            {
                next L-OUTER if $seg ~~ / ^ 0 \d /;
            }

            @splits.push: Array[UInt].new: $comb.map: { .Int };
        }

        # (3) Return the valid partitions as integer arrays

        return @splits;
    }

    #--------------------------------------------------------------------------
    # Adapted from "Print all ways to break a string in bracket form",
    # https://www.geeksforgeeks.org/print-ways-break-string-bracket-form/
    # (C++ implementation)
    #
    sub get-splits-recursive( Str:D $str, UInt:D $index, Array:D[Str:D] $out )
    #--------------------------------------------------------------------------
    {
        if $index == $str.chars                               # Base case
        {
            @partitions.push: $out;
        }
        else                                                  # Recursive cases
        {
            for $index .. $str.chars - 1 -> UInt $i
            {
                my Str @new-out = Array[Str].new:
                    |$out, $str.substr: $index, $i + 1 - $index;

                get-splits-recursive( $str, $i + 1, @new-out );
            }
        }
    }
} # End package Partition

#------------------------------------------------------------------------------
sub is-square( UInt:D $n --> Bool:D )
#------------------------------------------------------------------------------
{
    my UInt $root = $n.sqrt.floor;

    return $root * $root == $n;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################
