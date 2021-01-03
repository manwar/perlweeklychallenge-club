#!/usr/bin/perl
# 
# Task 2: "Sum Path
# 
# You are given binary tree containing numbers 0-9 only.
# 
# Write a script to sum all possible paths from root to leaf.
# 
# Example 1:
# 
# 	Input:
# 	     1
# 	    /
# 	   2
# 	  / \
# 	 3   4
# 
# 	Output: 13
# 	as sum two paths (1->2->3) and (1->2->4)
# 
# Example 2:
# 
# 	Input:
# 	     1
# 	    / \
# 	   2   3
# 	  /   / \
# 	 4   5   6
# 
# 	Output: 26
# 	as sum three paths (1->2->4), (1->3->5) and (1->3->6)
# "
# 
# My notes: interesting.  No notes on how to represent binary tree, or how
# to input it from the command line, but I think we did this in an earlier task.
# Oh yes, challenge 56 was also about path summing over binary trees, but that time
# we were looking for a specific path sum, whereas now we're summing all the path sums..
# so let's reuse most of that mechanism.
# For the given binary tree, the partial path sum 5 - 8 - 9 = 22 is not valid.
# 
# The script should return the path 5 - 4 - 11 - 2 whose sum is 22.
# "
# 
# Notes from challenge 56: First obvious question is: how do we represent a binary tree.
# Let's go with.. a traditional Perl OO self-printing package inline in the main program.
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
# In our form, Example 1 is:
# 
#	Invoke as: ./ch-2.pl '(1,(2,l3,l4),n)'
# 	Expected Output: 13
# 	as sum two paths (1->2->3) and (1->2->4)
# 
# In our form, Example 2 is:
# 
# 	Invoke as: ./ch-2.pl '(1,(2,l4,n),(3,l5,l6))'
# 	Expected Output: 26
# 	as sum three paths (1->2->4), (1->3->5) and (1->3->6)

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use List::Util 'sum';
use Data::Dumper;


my $debug=0;
die "Usage: sum-path-sums [--debug] bin-tree\n" unless GetOptions( "debug" => \$debug ) && @ARGV==1;
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

# Part 2 of the problem: summing up all sums in the tree
my $sum=0;
find_all_paths( $bintree,
	fun (@v)
	{
		$sum += sum(@v);
	} );
say $sum;


#
# find_all_paths( $bintree, $path_callback );
#	Find all paths through $bintree from the top all the way
#	down to the leaves, invoking the $path_callback function
#	each time we find a path, passing the list of values (node and leaf values)
#	we passed from root down to the leaves, into that callback function.
#
fun find_all_paths( $bintree, $callback )
{
	find_all_rec( $bintree, $callback, () );
}

#
# find_all_rec( $bintree, $callback, @listsofar )
#	Given a bintree $bintree, a path callback $callback to invoke, and a @listsofar
#	of values on the path above this point, traverse the $bintree, calling $callback
#	for each such complete path sum, passing it the list of values from root to leaf.
#
fun find_all_rec( $bintree, $callback, @listsofar )
{
	my( $kind, @pieces ) = $bintree->breakapart();
	if( $kind eq "node" )
	{
		my( $n, $l, $r ) = @pieces;
		push @listsofar, $n;
		find_all_rec( $l, $callback, @listsofar );
		find_all_rec( $r, $callback, @listsofar );

	} elsif( $kind eq "leaf" )
	{
		my( $n ) = @pieces;
		push @listsofar, $n;
		say "found path ", join(',',@listsofar) if $debug;
		$callback->( @listsofar );
	} elsif( $kind eq "nil" )
	{
	} else
	{
		die "bintree->find_all_rec: given bintree has impossible kind $kind: ", Dumper($bintree);
	}
}
