#!/usr/bin/perl
# 
# Task 2: "Path Sum
# 
# You are given a binary tree and a sum, write a script to find if the tree
# has a path such that adding up all the values along the path equals the
# given sum. Only complete paths (from root to leaf node) may be considered
# for a sum.
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
# For the given binary tree, the partial path sum 5 - 8 - 9 = 22 is not valid.
# 
# The script should return the path 5 - 4 - 11 - 2 whose sum is 22.
# "
# 
# My notes: First obvious question is: how do we represent a binary tree.  Let's go with..
# a traditional Perl OO self-printing package inline in the main program.
# Second question: we'll need to parse a binary tree from the command line,
# so what text format do we want to represent a parsable binary tree on the command line?
#
# Haskell style would be the incredibly verbose:
# node(5,node(4,node(11,leaf(7),leaf(2)),nil),node(8,leaf(13),node(9,nil,leaf(1))))
#
# A simplified style, with node() abbreviated to (),
# leaf abbreviated to 'l', and nil to 'n', would be
# (5,(4,(11,l(7),l(2)),n),(8,l(13),(9,n,l(1))))
#
# or a still simpler form, removing the () on leaves..
# (5,(4,(11,l7,l2),n),(8,l13,(9,n,1)))
#
# So here:
# (N,L,R) represents a node with value N, left tree L and right tree R;
# lN represents a leaf with value N
# n represents nil
#
# let's go with that form..  of course, you'll need to single quote the command line arguments
# as () are treated specially by Unix shells.
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;


die "Usage: path-sum sum bin-tree\n" unless @ARGV==2;
my $sum = shift;
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

# Part 2 of the problem: finding a particular path sum in the tree
my( $found, @list ) = find_sum( $bintree, $sum );
if( $found )
{
	say "$sum found: ", join(',',@list);
} else
{
	say "$sum not found";
}


#
# my( $found, @list ) = find_sum( $bintree, $sum );
#	Sum up the values (leaf values and node values)
#	along a path from the root to each leaf, and find
#	one (if possible) that sums to $sum.
#	Return (1, list_values_from_root_to_leaf ) if
#	you find one such path, or (0) if no such path exists.
#
fun find_sum( $bintree, $sum )
{
	return find_sum_rec( $bintree, $sum, () );
}

#
# my( $found, @list ) = find_sum_rec( $bintree, $sum, @listsofar );
#	Given a bintree $bintree, a sum $sum to aim for, and a @listsofar
#	of values on the path above this point, Sum up the values (leaf and node values)
#	along a path from the root to each leaf, and find the first such path that sums to $sum.
#	Return (1, list_values_from_root_to_leaf ) if you find one such path,
#	or (0) if no such path exists.
#
fun find_sum_rec( $bintree, $sum, @listsofar )
{
	my( $kind, @pieces ) = $bintree->breakapart();
	if( $kind eq "node" )
	{
		my( $n, $l, $r ) = @pieces;
		return ( 0 ) if $sum<$n;
		$sum -= $n;
		push @listsofar, $n;
		my( $found, @list ) = find_sum_rec( $l, $sum, @listsofar );
		return( $found, @list ) if $found;

		( $found, @list ) = find_sum_rec( $r, $sum, @listsofar );
		return( $found, @list );

	} elsif( $kind eq "leaf" )
	{
		my( $n ) = @pieces;
		return ( 0 ) if $sum != $n;
		push @listsofar, $n;
		return( 1, @listsofar );
	} elsif( $kind eq "nil" )
	{
		return ( 0 );
	} else
	{
		die "bintree->find_sum: given bintree has impossible kind $kind: ", Dumper($bintree);
	}
}
