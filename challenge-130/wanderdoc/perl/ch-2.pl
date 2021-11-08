#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a tree. Write a script to find out if the given tree is Binary Search Tree (BST).
A binary search tree is a rooted binary tree, whose internal nodes each store a key (and optionally, an associated value), and each has two distinguished sub-trees, commonly denoted left and right. The tree additionally satisfies the binary search property: the key in each node is greater than or equal to any key stored in the left sub-tree, and less than or equal to any key stored in the right sub-tree. The leaves (final nodes) of the tree contain no key and have no structure to distinguish them from one another.

=cut





use Struct::Dumb;
use List::Util qw(max); 
struct Node => [qw( left right value )], named_constructor => 1;

my $root = createNode(8);
$root->left = createNode(5);
$root->right = createNode(9);
$root->left->left = createNode(4);
$root->left->right = createNode(6);

print isBST($root, 0, 1e6), $/;

$root = undef;

$root = createNode(5);
$root->left = createNode(4);
$root->right = createNode(7);
$root->left->left = createNode(3);
$root->left->right = createNode(6);
print isBST($root, 0, 1e6), $/;






sub createNode
{
     my $value = $_[0];
     my $node = Node(value => $value, left => undef, right => undef);
     return $node;
}



sub isBST # wikipedia
{
     my ($node, $min, $max) = @_;
     if ( $node )
     {
          return 0 if ( $node->value < $min or $node->value > $max );
          return
               ( isBST($node->left, $min, $node->value)

                 and
               isBST($node->right, $node->value, $max) );
     }
     else
     {
          return 1;
     }
}