#!/usr/env/perl
# Task 2 Challenge 056 Solution by saiftynet
# Path Sum
# You are given a binary tree and a sum, write a script to find 
# if the tree has a path such that adding up all the values along 
# the path equals the given sum. Only complete paths (from root 
# to leaf node) may be considered for a sum.
# Example
# Given the below binary tree and sum = 22,
#         5
#        / \ 
#       4   8
#      /   / \
#     11  13   9 
#    /  \       \ 
#   7    2       1
# For the given binary tree,the partial path sum 5 → 8 → 9 = 22 is not valid.
# The script should return the path 5 → 4 → 11 → 2 whose sum is 
# 22.


# I have no experience of using binary trees.
# There are implementations described in the Perl Cookbook
# There are variations also on MetaCPAN. 
# Visualising such trees is also bit tricky (havent explored it fully)
# Having not the time to learn this, I have developed a much simpler
# simulated tree-like structure.  The tree nodes are defined by
# a binary string starting with "1" (the root node),and the children
# of nodes are left or right by adding ones or zeros. so for a path that goes
# "left,left,right,left" would be described as "1101", and is the key
# in a hash containing a value at that node. This has several advantages,
# allowing quick and easy identification of parents, children, depth etc.
# and is probably more performant and space saving than other nested
# hashes or object orientated methods I have come across.
# The values at the nodes can be any scalar or reference.
# The display() routine traverses the tree displaying a reasonable
# representation ..(provided values are small)

use strict;use warnings;

my %binTree=();  # the hash containing the binary tree data

# test();        # uncomment to test the implementation

# The following four statements assembles the 9 node example tree
insertNode ("1"=>5);                          #          5
                                              #         / \
insertNode ("11"=>4,  "10"=>8 );              #        4   8
                                              #       /   / \
insertNode ("111"=>11,"101"=>13,"100"=>9 );   #      11  13  9
                                              #     /  \      \
insertNode ("1111"=>7,"1110"=>2,"1000"=>1);   #    7    2      1

# check that the correct tree has been drawn
drawTree();

print "The paths that add up to 22 are:-\n";
# find all the leaves (nodes with no children) and do a pathSum
foreach (keys %binTree){                    # examining each node
	 if (leafNode($_)){                 # if its a leaf
		 my ($sum,@pathValues)=pathSum($_); # get the sum and path values  
		 print join "──>",reverse @pathValues if $sum ==22; # draw path if $sum is target
	 }
}

# insert into a node, prevent over-writes or orphans but allow duplicates
# multiple node string/value pairs can be supplied at the same time,
# allowing quick assembly of the tree
sub insertNode{
  my (@pairs)=@_;
  while (@pairs>=2) {
	my ($node,$value )=(shift @pairs, shift @pairs);
    if (orphanNode($node) or defined $binTree{$node}){
      print "Can not insert  into $node (is orphan or exists)\n";
	}
	else {
		$binTree{$node}=$value;
	}
  }
}

# get the all the parent nodes and add their values, return both.
sub pathSum{
	my $node=shift;
	my $sum=0; my @pathValues=();
	while ($node){
		push @pathValues,$binTree{$node};
		$sum+=$binTree{$node};
		chop $node;
	}
    return ($sum,@pathValues)
}

# has no left or right children
sub leafNode{  
	my $node=shift;
	return not (defined $binTree{$node."0"} or defined $binTree{$node."1"} );
}

# has no parents but root is not an orphan
sub orphanNode{ 
	my $node=shift;
	return (parentNode($node) or $node eq "1")?0:1
}

# get parent node (simply lop off end of node string)
sub parentNode{
	chop (my $node=shift);
	return  $node;
}

# deletes a node and all its branches, deleting root node deletes all nodes
sub deleteNode{
	my $node=shift;
	 foreach (keys %binTree)
	    { delete $binTree{$_} if ($_=~/^$node/)}
}

# this is an attempt to draw the tree...required for visual verification that 
# the tree generated reflects what is required.  the output is colourised 
# to identify leaves, is drawn on its side to save space (left is down right is up)
# ASCII line symbols are used to draw branches
sub drawTree{
  our @downs=();                        # collection of left branches
  print "\n";
  nextNode("1");                        # start with root node
  print "\n";
  sub nextNode{                         # call function that parses nodes
    my $node=shift;
    my $format=leafNode($node)?"──>\033[92;1m%2s\033[0m":"──>%2s"; 
    printf $format,$binTree{$node};     # color the leaves
                                        # collect nodes with left branches
    push @downs,$node."1" if (defined $binTree{$node."1"}); 
    if (defined $binTree{$node."0"}){   # go along right side if possible
       nextNode($node."0") 
    }
    else{               # otherwise go back up to the next node with left branch
       return unless $node=pop @downs;  # no more lefts...finish
       my %vDashes;
			$vDashes{ length $_ }=1 foreach (@downs);  # vertical lines
			print "\n";
			print "    ",$vDashes{$_}?"│":" "foreach (2..(length $node)-1);
			print "    └";              # elbow 
			nextNode($node);
		}
	}
}

# test function  
sub test{
  print "Assembling random 'ordered tree' \n";
  byValue ("insert",int(100*rand()) ) foreach (0..30); # random number ordered insert
  drawTree();              # draw tree     
  sleep 5;
  
  print "\033[2J\033[0;0H";#clear screen and jump to 0,0 
  print "Deleting node '101' if it exists\n";
  deleteNode("101");       # delete node (and any children
  drawTree();
  sleep 5;
  print "\033[2J\033[0;0H";#clear screen and jump to 0,0 
  print "Creating new node '101' and some non numeric children\n";
  insertNode("101","Hello","1010","there!","1011","It's","10110","me!",);    
  drawTree();              # draw tree      
  sleep 5;
  deleteNode("1");
  print "\033[2J\033[0;0H";#clear screen and jump to 0,0 
             # draw tree      
}

# this is the classic tree builder with values which are larger to left
# and smaller to the right.  This function can be used to insert the data
# as well as search for values inthe tree. $action is either "insert" or "search" 
sub byValue{
  my ($action,$value,$node,$side)=@_;
  $node //= "1";
  my $found  = 0;
  while (defined $binTree{$node}){
    if    ($binTree{$node}<$value) { $node=$node."1" }
    elsif ($binTree{$node}>$value) { $node=$node."0" }
    else  {$found=1;last}
  }
  return $node if $action eq "search" and $found;
  $binTree{$node}=$value;
}

