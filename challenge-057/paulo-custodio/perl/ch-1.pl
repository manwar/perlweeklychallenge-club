#!/usr/bin/env perl

# Challenge 057
#
# TASK #1 › Invert Tree
# You are given a full binary tree of any height, similar to the one below:
#
#
#
# Write a script to invert the tree, by mirroring the children of every node,
# from left to right. The expected output from the tree above would be:
#
#
#
# The input can be any sensible machine-readable binary tree format of your
# choosing, and the output should be the same format.
#
# BONUS
# In addition to the above, you may wish to pretty-print your binary tree in a
# human readable text-based format similar to the following:
#
#        1
#       /  \
#      3    2
#     / \  / \
#    7   6 5  4

use Modern::Perl;

# tree object
{
    package Tree;
    use Object::Tiny::RW qw( value left right );
}

my $tree = parse_tree();
invert_tree($tree);
dump_tree($tree);

sub parse_tree {
    chomp(my @lines = <>);
    @lines or die "malformed tree\n";
    $lines[0] =~ /^( +)\d/ or die "malformed tree\n";
    my $tree = parse_subtree(\@lines, 0, length($1));
    return $tree;
}

sub parse_subtree {
    my($lines, $row, $col) = @_;

    # parse root
    my $value = substr($lines->[$row], $col, 1);
    $value =~ /\d/ or die "malformed tree\n";
    my $node = Tree->new(value => $value);

    # parse children
    if ($row+2 <= $#{$lines}) {
        # parse left subtree
        if ($col-2 >= 0 &&
            $col-2 < length($lines->[$row+1]) &&
            substr($lines->[$row+1], $col-1, 1) eq '/') {
            my $child = parse_subtree($lines, $row+2, $col-2);
            $node->left($child);
        }
        # parse right subtree
        if ($col+2 < length($lines->[$row+2]) &&
            substr($lines->[$row+1], $col+1, 1) eq '\\') {
            my $child = parse_subtree($lines, $row+2, $col+2);
            $node->right($child);
        }
    }
    return $node;
}

sub invert_tree {
    my($tree) = @_;
    if ($tree) {
        ($tree->{left}, $tree->{right}) = ($tree->{right}, $tree->{left});
        invert_tree($tree->left);
        invert_tree($tree->right);
    }
}

sub dump_tree {
    my($tree) = @_;
    print $tree->value;
    if ($tree->left || $tree->right) {
        print "(";
        dump_tree($tree->left);
        print "|";
        dump_tree($tree->right);
        print ")";
    }
}
