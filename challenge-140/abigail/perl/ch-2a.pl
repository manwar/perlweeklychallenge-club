#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-140/#TASK2
#

#
# Run as: perl ch-2a.pl < input-file
#

#
# This solution scans the multiplication table in order, only generating
# as many numbers are needed:
#
#  * Assume i <= j (else, just swap i and j)
#
#  * Create i pairs. Initialize each pair P_n as [n, 1], 1 <= n <= i.
#    Each pair corresponds to the column in the multiplication table.
#    Since the values in a column are sorted, we only need to keep
#    track of the highest element we haven't descarded yet.
#  * Store each pair in a heap, ordered on P_n [0] * P_n [1], such
#    that the pair with the smallest product is on top.
#  * Let c = 0; while c < k:
#        + Let Q be the pair on top of the heap.
#        + Q [1] = Q [1] >= j ? Q [i * j + 1] : Q [1] + 1   [*]
#        + Restore the heap
#  * If c == k, then the wanted number is product of the pair at
#    the top of the heap.
#
# [*] If Q [1] >= j, we have reached the bottom of the column, so the
#     answer we're seeking cannot be in this column. By setting Q [1]
#     to i * j + 1, it will be larger than the answer we're looking for,
#     and we'll never consult this column again.
#
#  Building the heap is O (i) (trivial in this case, as we can generate
#  the elements in a sorted way). Restoring the heap takes O (log (i)).
#  Hence, the total running time is O (i + k * log (i)), using O (i)
#  memory. 
#


sub prod  ($pair)  {$$pair [0] * $$pair [1]}
sub left  ($index) {2 * $index + 1}
sub right ($index) {2 * $index + 2}

sub make_heap ($i) {[map {[$_, 1]} 1 .. $i]}
sub rebalance ($heap, $index = 0) {
    my $index1 = left  $index;    # Left  child
    my $index2 = right $index;    # Right child
    return if $index1 > $#$heap;  # No children, so we're done.
    my $p = prod $$heap [$index];
    #
    # Find the smallest of the children
    #
    my $p1 = prod $$heap [$index1];
    if ($index2 <= $#$heap) {
        my $p2 = prod $$heap [$index2];
        #
        # Right child is smaller than left child, so right child wins
        #
        if ($p2 < $p1) {
            $p1 = $p2;
            $index1 = $index2;
        }
    }
    #
    # Now, $p1 is the smallest child, and on index $index1.
    # If the smallest child is smaller than the current element,
    # swap, and recurse. Else, we're done.
    #
    if ($p1 < $p) {
        @$heap [$index, $index1] = @$heap [$index1, $index];
        rebalance ($heap, $index1);
    }
}


while (<>) {
    my ($i, $j, $k) = split;
    ($j, $i) = ($i, $j) if $j < $i;
    my $heap = make_heap ($i);
    while ($k -- > 1) {
        $$heap [0] [1] = $$heap [0] [1] >= $j ? $i * $j + 1
                                              : $$heap [0] [1] + 1;
        rebalance ($heap);
    }
    say prod $$heap [0];
}

