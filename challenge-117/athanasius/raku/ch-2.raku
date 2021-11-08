use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 117
=========================

TASK #2
-------
*Find Possible Paths*

Submitted by: E. Choroba

You are given size of a triangle.

Write a script to find all possible paths from top to the bottom right corner.

In each step, we can either move horizontally to the right (H), or move
downwards to the left (L) or right (R).

BONUS: Try if it can handle triangle of size 10 or 20.

Example 1:

 Input: $N = 2

            S
           / \
          / _ \
         /\   /\
        /__\ /__\ E

 Output: RR, LHR, LHLH, LLHH, RLH, LRH

Example 2:

 Input: $N = 1

            S
           / \
          / _ \ E

 Output: R, LH

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Output
------
Both the Task description and the associated Examples show that the required
output is an enumeration of all the possible paths from the top of the equi-
lateral triangle to its bottom right corner. However, for values of $N greater
than 6 this becomes impractical. In particular, for the bonus size of 10, the
number of paths is over a million, and for the bonus size of 20, the number of
paths is over 17 trillion!

An alternative output is simply the total number of distinct paths. In the
script below, this number is given first, followed optionally by a full enumer-
ation of the paths. This enumeration is output by default, but may be turned
off by setting the $SHOW_PATHS constant to a false value. IT IS STRONGLY
ADVISED THAT $SHOW_PATHS BE SET TO FALSE WHEN ENTERING ANY VALUE OF $N GREATER
THAN 10, AS OTHERWISE MEMORY MAY BECOME EXHAUSTED.

It is assumed that the full list of paths may be presented in any order. This
script prioritizes R over both L and H, and L over H. For example, when $N = 4
the paths are output in this order:

    (beginning) RRRR ... LLLLHHHH ... LHLHLHLH (end).

Algorithms
----------
The total number of distinct paths for each value of $N is given by the series
of Schröder numbers (see the references below). Schröder numbers may be calcu-
lated via a recurrence relation as detailed in the header to sub S(). Memoiza-
tion is used to reduce the computation time.

Enumeration of the paths is performed as follows:

1. A ragged array is constructed to hold a path list for each node of the
   triangle. For example, if $N = 2 then the array has this structure:

        nodes[0] contains node[0][0]
        nodes[1] contains node[1][0] and node[1][1]
        nodes[2] contains node[2][0] and node[2][1] and node[2][2]

2. The end point of the path -- in this case node[2][2] -- contains only the
   empty string.

3. FOR each row of the triangle, from last to first
       FOR each column in this row, from last to first
           All possible paths from the node at this row and column to the end
           node are constructed by
           - prepending 'R' to each path already stored in the node (if any)
             immediately below and to the right
           - prepending 'L' to each path already stored in the node (if any)
             immediately below and to the left
           - prepending 'H' to each path already stored in the node (if any)
             immediately to the right
       ENDFOR
   ENDFOR

4. All paths are now stored in node[0][0]

References
----------
(1) "A006318  Large Schröder numbers ...", The On-Line Encyclopedia of Integer
     Sequences (OEIS), https://oeis.org/A006318

(2) "Schröder number", Wikipedia,
     https://en.wikipedia.org/wiki/Schr%C3%B6der_number

=end comment
#==============================================================================

use Memoize;

my Bool constant $SHOW-PATHS = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 117, Task #2: Find Possible Paths (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D $N    #= Positive int: size (side length) of an equilateral triangle
)
#==============================================================================
{
    my UInt $n = $N + 0;             # Normalize: e.g., 010 --> 10, 0x10 --> 16

    "Input: \$N = $n".put;

    memoize( 'S' );

    my UInt $s = S( $n );

    print "Output:\n  Total paths: $s\n";

    if $SHOW-PATHS
    {
        my Array[Str] $paths = find-paths( $n );

        "  List of paths: %s\n".printf: $paths.join: ', ';

        $s == $paths.elems
            or note "\nERROR: The number of paths found does not equal the " ~
                      "Schroeder number of \$N";
    }
}

#------------------------------------------------------------------------------
# Schröder number
# ---------------
# Formula:
#             S[0] = 1
#             S[1] = 2
# for n >= 2: S[n] = 3.S[n - 1] + SUM( k = 1 .. (n - 2) ){ S[k].S[n - k - 1] }
#
# -- https://en.wikipedia.org/wiki/Schr%C3%B6der_number#Recurrence_relation
#
sub S( UInt:D $N --> UInt:D )
#------------------------------------------------------------------------------
{
    return 1 if $N == 0;
    return 2 if $N == 1;

    my UInt $S = 3 * S( $N - 1 );

    for 1 .. $N - 2 -> UInt $k
    {
        $S += S( $k ) * S( $N - $k - 1 );
    }

    return $S;
}

#------------------------------------------------------------------------------
sub find-paths( UInt:D $N --> Array:D[Str:D] )
#------------------------------------------------------------------------------
{
    my Array[Array[Str]] @nodes;

    for 0 .. $N -> UInt $row
    {
        @nodes[$row]     = Array[Array[Str]].new;
        @nodes[$row][$_] = Array[Str].new for 0 .. $row;
    }

    @nodes[$N][$N].push: '';

    for (0 .. $N).reverse -> UInt $r
    {
        for (0 .. $r).reverse -> UInt $c
        {
            if $r < $N
            {
                # (R) Move downwards to the right

                @nodes[$r][$c].push: "R$_" for @nodes[$r + 1][$c + 1][];

                # (L) Move downwards to the left

                @nodes[$r][$c].push: "L$_" for @nodes[$r + 1][$c    ][];
            }

            if $c < $r
            {
                # (H) Move horizontally to the right

                @nodes[$r][$c].push: "H$_" for @nodes[$r    ][$c + 1][];
            }
        }
    }

    return @nodes[0][0];
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
