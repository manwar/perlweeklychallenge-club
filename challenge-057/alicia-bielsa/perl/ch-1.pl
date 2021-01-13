use strict;
use warnings;
use Data::Dumper;
use lib 'lib';
use Moose;
use BinaryTreeNode;
use BinaryTree;



#TASK #1 › Invert Tree
#You are given a full binary tree of any height, similar to the one below:


#       1              
#      /  \
#     2    3             
#    / \  / \
#   4   5 6  7           

#Write a script to invert the tree, by mirroring the children of every node, from left to right.
# The expected output from the tree above would be:


#      1
#     /  \
#    3    2
#   / \  / \
#  7   6 5  4

#The input can be any sensible machine-readable binary tree format of your choosing, and the output should be the same format.

#BONUS
#In addition to the above, you may wish to pretty-print your binary tree in a human readable text-based format similar to the following:

#       1
#     /  \
#    3    2
#   / \  / \
#  7   6 5  4

my @aValuesTree  =(1 , 2 ,3,4,5,6,7);
my $nimberValuesTree = scalar( @aValuesTree);
my $heightBinaryTree =  getHeightFullBinaryTree( $nimberValuesTree);

unless ($heightBinaryTree){
    die "$nimberValuesTree is not a valid number of values for a full binary tree\n";
}

my $oBinaryTree = BinaryTree->new( height => $heightBinaryTree);
$oBinaryTree->addValues(@aValuesTree);
$oBinaryTree->drawBinaryTree();
$oBinaryTree->mirrorTree();
$oBinaryTree->drawBinaryTree();


sub getHeightFullBinaryTree {
    my $numberValues = shift;
    my $height = 1;
    my $total = 1;
    my $valorAnterior =1;
    while  ($numberValues >= $total ){
       $total = $total + $valorAnterior * 2 ;       
       $valorAnterior = $valorAnterior * 2;
       $height++;
       if ($total == $numberValues){
            return $height;  
       }
    }
    return 0;
}


