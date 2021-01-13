#! /opt/local/bin/perl
#
#       sumpath.pl
#
#       TASK #2 › Sum Path
#         Submitted by: Mohammad S Anwar
#         You are given binary tree containing numbers 0-9 only.
#
#         Write a script to sum all possible paths from root to leaf.
#
#         Example 1:
#
#             Input:
#                  1
#                 /
#                2
#               / \
#              3   4
#
#             Output: 13
#             as sum two paths (1->2->3) and (1->2->4)
#
#         Example 2:
#
#             Input:
#                  1
#                 / \
#                2   3
#               /   / \
#              4   5   6
#
#             Output: 26
#             as sum three paths (1->2->4), (1->3->5) and (1->3->6)

#         method:
#             one of the most bothersome aspects of binary tree algorithms isn't
#             the manipultion of the tree itself, but rather inputting the data
#             into a program in the first place. One way to accomplish this is
#             to serialize the data, considering the tree as an array of levels,
#             each level containing 2 times the elements of the level previous,
#             with a starting index after the end of the previous level. Empty
#             nodes are still allocated space in the indexing to preserve
#             pattern continuity. Here null-set nodes are allocated undef.

#             Because the levels are of known, calcuable size, any node in the
#             tree can be directly addressed with a simple formula. The
#             serialized transform remains a binary tree, with any action on the
#             familiar form available to the latter, with a suitable transform
#             applied to the function.

#             The numbering of the indices follows a strict formal progression.
#             Each level starts at the index 2^n - 1, with n being the level of
#             the tree, starting at 0.
#
#                                    0
#                         1                     2
#                    3         4           5         6
#                 7     8   9    10     11    12  13   14

#             Not displayed here, the next level of the tree would be level 4,
#             comprised of 2^4 positions, and starting at index 2^4 - 1. A quick
#             visual inspection confirms this.

#             Knowing the encoding, we can directly address individual nodes by
#             their position in the array. For a given index n, the children, if
#             any, for that index will be located at the positions 2n+1 and
#             2n+2. To find the parent, if the index is even, subtract 1, if
#             odd, 2, then divide the result by 2.

#             We can easily set up a recursive routine to trace paths descending
#             through every node of the tree, with a base case summing the path
#             to the terminus and adding that total to the overall sum.

#             As a bonus, we'll gather the completed paths at the termination
#             case and report on those paths found at the end.




#
#       2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:


# tree:
#                           3
#                4                     5
#           1         8           6         2
#        ∅     9   ∅     ∅     9     7   4     ∅
#
# paths: (3,4,1,9)  = 17
#        (3,4,8)    = 15
#        (3,5,6,9)  = 23
#        (3,5,6,7)  = 21
#        (3,5,2,4)  = 14
#                  ------
#                     90

our @tree = map { $_ eq 'undef' ? undef : $_ } @ARGV;
@ARGV == 0 and @tree = (   3,
                           4, 5,
                           1, 8, 6, 2,
                           undef, 9, undef, undef, 9, 7, 4, undef   );
our $sum = 0;
our @paths;

descend(0, []);

say "sum $sum\n";
say "paths found:";
say join ' → ', @$_ for @paths;

## ## ## ## ## SUBS:

sub descend {
    my ($idx, $partial_path) = @_;
    my @path = @$partial_path;
    push @path, $tree[$idx];

    ## base case
    unless ( defined $tree[2*$idx+1] or defined $tree[2*$idx+2]) {
        $sum += $_ for @path;
        push @paths, \@path;
        return;
    }

    for ( 1, 2 ) {
        descend( 2*$idx+$_, \@path ) if defined $tree[2*$idx+$_];
    }
}




