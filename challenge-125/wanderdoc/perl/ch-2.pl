#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given binary tree as below:

    1
   / \
  2   5
 / \ / \
3  4 6  7
       / \
      8  10
     /
    9

Write a script to find the diameter of the given binary tree. The diameter of a binary tree is the length of the longest path between any two nodes in a tree. It doesn’t have to pass through the root.
For the above given binary tree, possible diameters (6) are:
3, 2, 1, 5, 7, 8, 9
or
4, 2, 1, 5, 7, 8, 9
The length of a path is the number of its edges, not the number of the vertices it connects. So the diameter should be 6, not 7.

=cut




use Struct::Dumb;
use List::Util qw(max); 
struct Node => [qw( left right value )], named_constructor => 1;;


sub createNode
{
     return Node(value => $_[0], left => undef, right => undef);
}


sub height_iter
{
     my $node = $_[0];

     my @queue;
     push @queue, $node;
     my $height = 0;


     while ( @queue )
     {
          my $size = scalar @queue;
          for my $i ( 0 .. $size - 1 )
          {
               my $n = shift @queue;
               push @queue, $n->left if $n->left;
               push @queue, $n->right if $n->right;

          }
          $height++;
     }
     return $height;
}

sub diameter_iter
{

     my $node = $_[0];
     my @queue;
     push @queue, $node;

     my $diameter = 0;

     while ( @queue )
     {

          my $size = scalar @queue;

          for my $i ( 0 .. $size - 1 )
          {
               my $n = shift @queue;
               my $height_left  = $n->left ?  height_iter( $n->left )  : 0;
               my $height_right = $n->right ? height_iter( $n->right ) : 0;
               $diameter = max($diameter, $height_left + $height_right); # + 1

               push @queue, $n->left  if $n->left;
               push @queue, $n->right if $n->right;
          }
     }
     return $diameter;
}




my $root = createNode(1);
$root->left = createNode(2);
$root->left->left = createNode(3);
$root->left->right = createNode(4);
$root->right = createNode(5);
$root->right->left = createNode(6);
$root->right->right = createNode(7);


my $seven = $root->right->right;

$seven->left = createNode(8);
$seven->left->left = createNode(9);
$seven->right = createNode(10);

print diameter_iter($root), $/;