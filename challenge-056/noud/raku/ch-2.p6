# Path Sum
#
# You are given a binary tree and a sum, write a script to find if the tree has
# a path such that adding up all the values along the path equals the given
# sum. Only complete paths (from root to leaf node) may be considered for a
# sum.
#
# Example
#
# Given the below binary tree and sum = 22,
#
#           5
#          / \
#         4   8
#        /   / \
#       11  13  9
#      /  \      \
#     7    2      1
#
# For the given binary tree, the partial path sum 5 → 8 → 9 = 22 is not valid.
#
# The script should return the path 5 → 4 → 11 → 2 whose sum is 22.

class Node {
    has Node $.left;
    has Node $.right;
    has $.value;
}

# This subroutine returns all possible full path sums.
sub path-sum($tree, $sum) {
    if ($tree.value == $sum) {
        if ($tree.left || $tree.right) {
            return [];
        } else {
            return [[$tree.value],];
        }
    }

    my @ret = [];
    if ($tree.left) {
        for path-sum($tree.left, $sum - $tree.value) -> @r {
            @ret.push([$tree.value, |(@r)]);
        }
    }
    if ($tree.right) {
        for path-sum($tree.right, $sum - $tree.value) -> @r {
            @ret.push([$tree.value, |(@r)]);
        }

    }
    return @ret;
}


my Node $tree .= new(
    value => 5,
    left => Node.new(
        value => 4,
        left => Node.new(
            value => 11,
            left => Node.new(
                value => 7),
            right => Node.new(
                value => 2))),
    right => Node.new(
        value => 8,
        left => Node.new(
            value => 13),
        right => Node.new(
            value => 9,
            right => Node.new(
                value => 1))));

for path-sum($tree, 22) -> @full-path {
    say @full-path.join(' -> ');
}
