# You are given a linked list and a value k. Write a script to partition the
# linked list such that all nodes less than k come before nodes greater than or
# equal to k. Make sure you preserve the original relative order of the nodes
# in each of the two partitions.
#
# For example:
#
# Linked List: 1 → 4 → 3 → 2 → 5 → 2
#
# k = 3
#
# Expected Output: 1 → 2 → 2 → 4 → 3 → 5.

sub partition(@l, $k) {
    return [|(@l.grep({ $_ < $k })), |(@l.grep({ $_ >= $k }))];
}

say partition([1, 4, 3, 2, 5, 2], 3).join(' → ');
