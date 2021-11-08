#!/usr/bin/perl
# The Weekly Challenge 129
# Task 1 Root Distance
# Usage: $ ch-1.pl 
use v5.12.0;
use warnings;
use Test::More tests => 9;
use Object::Pad 0.51;
use Object::Pad::SlotAttr::Isa;

class TreeNode {
    has $parent :reader :writer :param :Isa(TreeNode) = undef;
    has $list_of_children :reader :writer :param = [];
    has $is_root :reader :param = 0;

    method set_children {
        my $c = $_[0];
        $c->set_parent($self);
        push $list_of_children->@*, $c;
    }

    method root_distance {
        my $p = $self;
        my $d = 0;
        while (!$p->is_root) {
            $p = $p->parent;
            $d++;
        }
        return $d;
    }

    BUILD {
        if (defined($parent)) {
            $parent->set_children($self);
        }
        else {
            $is_root = 1;
        }
    }
}

# Example 1
my $n1 = TreeNode->new();
my $n2 = TreeNode->new(parent => $n1);
my $n3 = TreeNode->new(parent => $n1);

my $n4 = TreeNode->new(parent => $n3);
my $n5 = TreeNode->new(parent => $n4);
my $n6 = TreeNode->new(parent => $n4);

# Example 2
my $t1 = TreeNode->new();
my $t2 = TreeNode->new(parent => $t1);
my $t3 = TreeNode->new(parent => $t1);

my $t4 = TreeNode->new(parent => $t2);
my $t5 = TreeNode->new(parent => $t3);
my $t6 = TreeNode->new(parent => $t4);

my $t7 = TreeNode->new(parent => $t5);
my $t8 = TreeNode->new(parent => $t6);
my $t9 = TreeNode->new(parent => $t6);

ok $n6->root_distance() == 3, "Example 1 - Node 6";
ok $n5->root_distance() == 3, "Example 1 - Node 5";
ok $n2->root_distance() == 1, "Example 1 - Node 2";
ok $n4->root_distance() == 2, "Example 1 - Node 4";

ok $t7->root_distance() == 3, "Example 2 - Node 7";
ok $t8->root_distance() == 4, "Example 2 - Node 8";
ok $t6->root_distance() == 3, "Example 2 - Node 6";

ok $n1->root_distance() == 0, "Example 1 - Node 1";
ok $t1->root_distance() == 0, "Example 2 - Node 1";
