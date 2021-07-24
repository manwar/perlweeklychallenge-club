use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 122
=========================

TASK #2
-------
*Basketball Points*

Submitted by: Mohammad S Anwar

You are given a score $S.

You can win basketball points e.g. 1 point, 2 points and 3 points.

Write a script to find out the different ways you can score $S.

Example

 Input: $S = 4
 Output: 1 1 1 1
         1 1 2
         1 2 1
         1 3
         2 1 1
         2 2
         3 1

 Input: $S = 5
 Output: 1 1 1 1 1
         1 1 1 2
         1 1 2 1
         1 1 3
         1 2 1 1
         1 2 2
         1 3 1
         2 1 1 1
         2 1 2
         2 2 1
         2 3
         3 1 1
         3 2

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm
---------
1. Construct all possible combinations:
   1a. For each multiple of 2 (including 0) <= S, add in 1s as needed to bring
       the digit sum up to S
   1b. For each non-zero multiple of 3 <= S, add in 1s and 2s as per 1a to
       bring the digit sum up to S
2. Find the distinct permutations of each combination
   -- the algorithm is described below at sub get-next-permutation()
3. Sort the permutations in ascending lexicographical order
   -- compare strings formed by concatenating the elements of each permutation
4. Display the results

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 122, Task #2: Basketball Points (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D $S                      #= A basketball score
)
#==============================================================================
{
    "Input:  \$S = %s\n".printf: $S + 0;    # Normalize

    my Array[UInt] @perms = Array[UInt].new;

    # 1. Construct all possible combinations

    for get-combinations( $S ) <-> Array[UInt] $comb
    {
        # 2. Find the distinct permutations of each combination

        repeat
        {
            @perms.push: $comb.clone;       # Make a copy

        } while $comb = get-next-permutation( $comb );
    }

    # 3. Sort the permutations in ascending lexicographical order

    @perms = @perms.sort: { $^a.join cmp $^b.join };

    # 4. Display the results

    if @perms && @perms[ 0 ]
    {
        "Output: %s\n".printf: @perms.shift.join: ' ';
        "        %s\n".printf: @$_\        .join: ' ' for @perms;
    }
    else
    {
        "Output: <none>".put;
    }
}

#------------------------------------------------------------------------------
sub get-combinations( UInt:D $S --> Array:D[Array:D[UInt:D]] )
#------------------------------------------------------------------------------
{
    # Note: The combinations returned from fill-with-twos() include one with
    #       zero 2s (i.e., all 1s)

    my Array[UInt] @combs = fill-with-twos( $S );

    for 1 .. floor( $S / 3 ) -> UInt $threes
    {
        for fill-with-twos( $S - 3 * $threes ) -> Array[UInt] $partition
        {
            @combs.push: Array[UInt].new( |$partition, |(3 xx $threes) );
        }
    }

    return @combs;
}

#------------------------------------------------------------------------------
sub fill-with-twos( UInt:D $s --> Array:D[Array:D[UInt:D]] )
#------------------------------------------------------------------------------
{
    my Array[UInt] @partitions;

    for 0 .. floor( $s / 2 ) -> UInt $twos
    {
        @partitions.push:
            Array[UInt].new( |(1 xx ($s - 2 * $twos)), |(2 xx $twos) );
    }

    return @partitions;
}

#------------------------------------------------------------------------------
# Algorithm adapted from:
#   https://en.wikipedia.org/wiki/Permutation#Generation_in_lexicographic_order
#
#  "The following algorithm generates the next permutation lexicographically
#   after a given permutation. It changes the given permutation in-place."
#
sub get-next-permutation( Array:D[UInt:D] $comb --> Array:D[UInt:D] )
#------------------------------------------------------------------------------
{
    # 1. "Find the largest index k such that a[k] < a[k + 1]. If no such index
    #     exists, the permutation is the last permutation."

    my UInt $k;

    for 0 .. $comb.end - 1 -> UInt $i
    {
        $k = $i if $comb[ $i ] < $comb[ $i + 1 ];
    }

    return Nil unless $k.defined;

    # 2. "Find the largest index l greater than k such that a[k] < a[l]."

    my UInt $l;

    for $k + 1 .. $comb.end -> UInt $i
    {
        $l = $i if $comb[ $k ] < $comb[ $i ];
    }

    # 3. "Swap the value of a[k] with that of a[l]."

    ($comb[ $k ], $comb[ $l ]) = ($comb[ $l ], $comb[ $k ]);

    # 4. "Reverse the sequence from a[k + 1] up to and including the final
    #     element a[n]."

    return Array[UInt].new( |$comb[ 0      .. $k        ],
                            |$comb[ $k + 1 .. $comb.end ].reverse );
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################
