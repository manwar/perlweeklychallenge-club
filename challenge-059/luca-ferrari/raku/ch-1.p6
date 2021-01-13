#!env raku


# You are given a linked list and a value k.
# Write a script to partition the linked list such that all nodes
# less than k come before nodes greater than or equal to k.
# Make sure you preserve the original
# relative order of the nodes in each of the two partitions.
#
#    For example:
#
#    Linked List: 1 → 4 → 3 → 2 → 5 → 2
#
#    k = 3
#
#    Expected Output: 1 → 2 → 2 → 4 → 3 → 5.


# example of invocation
# % raku ch-1.p6 --k=4
# Index 4 makes 1 4 3 2 5 2 to become 1 3 2 2 4 5

sub MAIN( Int:D :$k = 3 ) {

    my @L = 1, 4, 3, 2, 5, 2 ;
    my @l = | @L.grep( * < $k ),  | @L.grep( * >= $k );
    say "Index $k makes { @L } to become { @l }";
}
