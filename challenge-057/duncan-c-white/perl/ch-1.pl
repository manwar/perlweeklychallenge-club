#!/usr/bin/perl
#
# Task 1: "Invert Tree
#
# You are given a full binary tree of any height, similar to the one below:
# 
#        1
#      /   \
#      2    3
#     / \  / \
#     4 5  6 7
# 
# Write a script to invert the tree, by mirroring the children of every node,
# from left to right. The expected output from the tree above would be:
# 
#        1
#      /   \
#      3    2
#     / \  / \
#     7 6  5 4
# 
# The input can be any sensible machine-readable binary tree format of
# your choosing, and the output should be the same format.
# 
# BONUS
# 
# In addition to the above, you may wish to pretty-print your binary
# tree in a human readable text-based format similar to the above."
# 
# My notes: Let's reuse the same binary tree representation from last challenge:
# - representation: a traditional Perl OO self-printing package,
#   inlined in the main program.
# - input syntax also same as last challenge, ie the above input tree is:
#   (1,(2,l4,l5),(3,l6,l7))
#
# here:
#   (N,L,R) represents a node with value N, left tree L and right tree R;
#   lN represents a leaf with value N
#   n represents nil
#
# That's the bulk of the problem solved.
#
# The "flip-left-right" algorithm looks very simple.  Not sure why "full"
# is stressed, AFAIK any obvious algorithm for this would deal with any
# binary tree.  The only difference that dealing with a "full" binary tree
# makes is that nil is not used, and all the leaves are at the bottom level.
#
# In Haskell, it's as simple as:
# 
# fliplr e = e
# fliplr leaf(n) = leaf(n)
# fliplr node(n,l,r) = node(n, fliplr(r), fliplr(l))
# 
# For attempts at the bonus, see ch-1bonus*.pl
#


use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;



die "Usage: flip-lr bin-tree\n" unless @ARGV==1;
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
	$str =~ s/\s+//g;
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

#
# my $flipped = fliplr( $bintree );
#	Flip $bintree left-and-right, as described above.
#	Return a newly built flipped l-and-r binary tree.
#	Haskell solution would be:
#	fliplr e = e
#	fliplr leaf(n) = leaf(n)
#	fliplr node(n,l,r) = node(n, fliplr(r), fliplr(l))
#
fun fliplr( $bintree )
{
	my( $kind, @pieces ) = $bintree->breakapart();
	if( $kind eq "node" )
	{
		my( $n, $l, $r ) = @pieces;
		( $l, $r ) = ( fliplr($r), fliplr($l) );
		return BinTree->node( $n, $l, $r );

	} elsif( $kind eq "leaf" )
	{
		my( $n ) = @pieces;
		return BinTree->leaf($n);
	} elsif( $kind eq "nil" )
	{
		return BinTree->nil();
	} else
	{
		die "bintree->fliplr: given bintree has impossible kind $kind: ", Dumper($bintree);
	}
}


my $bintree = BinTree->parse( $treestr );
say "tree is $bintree";

my $flipped = fliplr( $bintree );
say "flipped tree is $flipped";
