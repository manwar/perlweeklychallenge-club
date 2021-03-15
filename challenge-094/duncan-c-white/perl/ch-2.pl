#!/usr/bin/perl
# 
# Task 2: "Binary Tree to Linked List
# 
# You are given a binary tree.
# 
# Write a script to represent the given binary tree as an object and flatten it to a linked list object. Finally print the linked list object.
# 
# Example:
# 
#     Input:
# 
#         1
#        / \
#       2   3
#      / \
#     4   5
#        / \
#       6   7
# 
#     Output:
# 
#         1 -> 2 -> 4 -> 5 -> 6 -> 7 -> 3
# "
# 
# My notes: again with the binary trees - no notes on representation, so I'll reuse the one I've used before.
# I think the "flatten to a linked list object" means "perform a pre-order traversal producing a list".
# Challenges 56 and 93 had tasks about traversing binary trees, so let's reuse most of that mechanism.
# 
# Notes from challenge 56: First obvious question is: how do we represent a binary tree.
# Let's go with.. a traditional Perl OO self-printing package inline in the main program.
# Second question: we'll need to parse a binary tree from the command line,
# so what text format do we want to represent a parsable binary tree on the command line?
#
# let's go with:
# (5,(4,(11,l7,l2),n),(8,l13,(9,n,1)))
#
# where:
# (N,L,R) represents a node with value N, left tree L and right tree R;
# lN represents a leaf with value N
# n represents nil
#
# let's go with that form..  of course, you'll need to single quote the command line arguments
# as () are treated specially by Unix shells.
#
# In our form, the Example is:
# 
#	Invoke as: ./ch-2.pl '(1,(2,l4,(5,l6,l7)),l3)'
# 	Expected Output: 1 2 4 5 6 7 3
#
use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;


my $debug=0;
die "Usage: flatten-tree-list [--debug] bin-tree\n" unless GetOptions( "debug" => \$debug ) && @ARGV==1;
my $treestr = shift;


package BinTree;

# Part 1 of the problem: being able to represent a Bin Tree,
# and parsing a string representation of one.

use overload '""' => \&as_string;

#
# my $bintree = BinTree->node( $n, $l, $r );
#	create a BinTree node with number $n, left tree $l and right tree $r.
#
method node($class: $n, $l, $r )
{
	return bless [
		'node', $n, $l, $r
	], $class;
}

#
# my $bintree = BinTree->leaf( $n );
#	create a BinTree leaf with number $n.
#
method leaf($class: $n )
{
	return bless [
		'leaf', $n
	], $class;
}

#
# my $bintree = BinTree->nil();
#	create a BinTree nil.
#
method nil($class:)
{
	return bless [
		'nil'
	], $class;
}

#
# my $bintree = BinTree->parse( $str );
#	Build a new BinTree by parsing the whole of $str.
#	An example binary tree string might be:
#		(5,(4,(11,l7,l2),n),(8,l13,(9,n,1)))
#	die if $str is not a valid representation of the a BinTree.
#
method parse( $str )
{
	$str =~ s/\s+//;
	my( $bintree, $leftover ) = BinTree->parse_rec( $str );
	die "BinTree->parse( $str ): '$leftover' left over at end\n" if $leftover;
	return $bintree;
}

#
# my( $bintree, $leftover ) = BinTree->parse_rec( $str );
#	Build a new BinTree by parsing $str, telling us what suffix of $str is leftover (in $leftover).
#	die if $str is not a valid representation of the a BinTree.
#
method parse_rec( $str )
{
	return ( BinTree->nil(), $str ) if $str =~ s/^n//;
	return ( BinTree->leaf($1), $str ) if $str =~ s/^l(\d+)//;

	# node: format (\d+,tree,tree)
	die "BinTree->parse_rec( $str ): 'n', 'l', or '(' expected\n" unless $str =~ s/^\(//;

	# what's left: \d+,tree,tree)
	die "BinTree->parse_rec( $str ): digit expected\n" unless $str =~ s/^(\d+)//;
	my $n = $1;

	# what's left: ,tree,tree)
	die "BinTree->parse( $str ): ',' expected (after number)\n" unless $str =~ s/^,//;

	# what's left: tree,tree)
	my( $l, $leftover ) = BinTree->parse_rec( $str );

	# what's left: ,tree)
	die "BinTree->parse( $leftover ): ',' expected (after left sub tree)\n" unless $leftover =~ s/^,//;

	# what's left: tree)
	my( $r, $rest ) = BinTree->parse_rec( $leftover );

	die "BinTree->parse( $str ): ')' expected\n" unless $rest =~ s/\)//;

	return ( BinTree->node( $n, $l, $r ), $rest );
}

#
# my( $kind, @pieces ) = $bintree->breakapart();
#	Break the given $bintree apart into it's "kind" (node,left or nil),
#	and it's array of pieces..
#
method breakapart()
{
	die "bintree->breakapart: given bintree not an array; actually ", Dumper($self) unless ref($self) eq "BinTree";
	return @$self;
}

#
# my $str = $bintree->as_string();
#	return the given $bintree as a nice printable string.
#
sub as_string($)
{
	my( $self ) = @_;

	die "bintree->as_string: given bintree not an array; actually ", Dumper($self) unless ref($self) eq "BinTree";
	my @x = @$self;
	my $kind = shift @x;
	if( $kind eq "node" )
	{
		my( $n, $l, $r ) = @x;
		$l = $l->as_string();
		$r = $r->as_string();
		return "($n,$l,$r)";
	} elsif( $kind eq "leaf" )
	{
		my( $n ) = @x;
		return "l$n";
	} elsif( $kind eq "nil" )
	{
		return "n";
	} else
	{
		die "bintree->as_string: given bintree has impossible kind $kind\n";
	}
}


package main;

my $bintree = BinTree->parse( $treestr );
say "tree is $bintree";

# Part 2 of the problem: produce a list, pre-order traversal
my @l;
preorder( $bintree, \@l );
say join(',',@l);


#
# preorder( $bintree, $aref );
#	Traverse $bintree in pre-order fashion (visiting the number in a node,
#	then everything in the left subtree, then everything in the right
#	subtree), appending every leaf and node value onto @$aref.
#
fun preorder( $bintree, $aref )
{
	my( $kind, @pieces ) = $bintree->breakapart();
	if( $kind eq "node" )
	{
		my( $n, $l, $r ) = @pieces;
		push @$aref, $n;
		preorder( $l, $aref );
		preorder( $r, $aref );

	} elsif( $kind eq "leaf" )
	{
		my( $n ) = @pieces;
		push @$aref, $n;
	} elsif( $kind eq "nil" )
	{
	} else
	{
		die "bintree->preorder: given bintree has impossible kind $kind: ", Dumper($bintree);
	}
}
