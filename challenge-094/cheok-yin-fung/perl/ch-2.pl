#!/usr/bin/perl
# The Weekly Challenge 094
# Task 2: Binary Tree to Linked List
use strict;
use warnings;
use Data::Dumper;

{
use strict;
package SLL::Node;

sub new {
    my ($class) = @_;
    bless {
        _value => $_[1],
        _nextnode => $_[2],
    }, $class; 
}


sub value { $_[0]->{_value} }

sub nextnode { $_[0]->{_nextnode} }

sub set_nextnode { $_[0]->{_nextnode} = $_[1]; }

sub print_linked_list {
    my $node = $_[0];
    while (defined $node->nextnode) {
        print $node->value, " -> ";
        $node = $node->nextnode;
    }
    print $node->value; #final value
    print "\n";
}


} # END of package SLL::Node


{
use strict;
package BinaryTreeNode;

our @ISA = qw/ SLL::Node /;

sub new {
    my ($class) = @_;
    bless {
        _value => $_[1],
        _leftchild => $_[2],
        _rightchild => $_[3],
    }, $class;
}

sub value { $_[0]->{_value} }

sub leftchild { $_[0]->{_leftchild} }

sub rightchild { $_[0]->{_rightchild} }

sub create_tree_from_list {
    my ($class,@arr) = @_;
    my $lastleaf = $#arr;
    my @tree;

    for my $k (reverse 0..$lastleaf) {
        if (defined($arr[$k])) {
            if (defined($arr[$k*2+1]) and defined($arr[$k*2+2])) {
                $tree[$k] = BinaryTreeNode->new(
                  $arr[$k], \$tree[$k*2+1], \$tree[$k*2+2]) 
            }
            if (defined($arr[$k*2+1]) and !defined($arr[$k*2+2])) {
                $tree[$k] = BinaryTreeNode->new(
                  $arr[$k], \$tree[$k*2+1], undef) 
            }
            if (!defined($arr[$k*2+1]) and defined($arr[$k*2+2])) {
                $tree[$k] = BinaryTreeNode->new(
                  $arr[$k], undef, \$tree[$k*2+2]) 
            }
            if (!defined($arr[$k*2+1]) and !defined($arr[$k*2+2])) {
                $tree[$k] = BinaryTreeNode->new(
                  $arr[$k], undef, undef) 
            }
        }
             
    }

    return $class, $tree[0];  #return tree root
}

my @tt_stack = ();

sub to_llnode {
    return SLL::Node->new(shift, undef);
}

sub tree_travel {
    my $self = shift;
    my $t = shift;
    my $baby = to_llnode($t->value);
    my $preserve = \$baby;
   
    if (defined $t->leftchild) {
        push @tt_stack, $t->rightchild if defined $t->rightchild ;
        $baby->set_nextnode(tree_travel($self,${$t->leftchild}));
    } elsif (defined $t->rightchild) {
        $baby->set_nextnode(tree_travel($self,${$t->rightchild}));
    
    } elsif (scalar @tt_stack != 0) {
        my $n = pop @tt_stack;
        $baby->set_nextnode(tree_travel($self,${$n}));
    }

    return $$preserve;
}


}  #END of package BinaryTreeNode



my $root = BinaryTreeNode->
        create_tree_from_list(1,2,3,4,5, undef, 
                              undef, undef, undef,6,7); # Example

my $rootnode = BinaryTreeNode->tree_travel($root);

print "Example\n";
$rootnode->print_linked_list;

print "\n";




print "A Test Case\n";
=pod
          1
        |---|
       /     \
      2       3
     /  \    /  \ 
    4    5  6    7
   / \   /\
  8  9  10 11
=cut

my $treeroot2 = BinaryTreeNode->
        create_tree_from_list(1, 2, 3, 4, 5, 6,7,8,9,10,11);  # test case

my $rootnode2 = BinaryTreeNode->tree_travel($treeroot2);
$rootnode2->print_linked_list;
