#!/usr/bin/perl
# 
# Task 2: "Binary Search Tree
# 
# You are given a tree.
# 
# Write a script to find out if the given tree is Binary Search Tree (BST).
# 
# According to wikipedia, the definition of BST:
# 
# A binary search tree is a rooted binary tree, whose internal nodes
# each store a key (and optionally, an associated value), and each has
# two distinguished sub-trees, commonly denoted left and right. The tree
# additionally satisfies the binary search property: the key in each node
# is greater than or equal to any key stored in the left sub-tree, and less
# than or equal to any key stored in the right sub-tree. The leaves (final
# nodes) of the tree contain no key and have no structure to distinguish
# them from one another.
# 
# Example 1
# 
# Input:
#         8
#        / \
#       5   9
#      / \
#     4   6
# 
# Output: 1 as the given tree is a BST.
# 
# Example 2
# 
# Input:
#         5
#        / \
#       4   7
#      / \
#     3   6
# 
# Output: 0 as the given tree is a not BST.
# "
# 
# My notes: this is a variation of ch-2.pl in which all the constraints are
# checked via a constraint function pointer [whose body has to check inherited
# constraints and fresh constraints].  It's approx 10 lines shorter, is more
# wonderfully higher-order functiony, but it's not (to my mind) anywhere as
# clear as the "list of <=N|>=N" constraints.
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;

my $debug = 0;

die "Usage: is-bst [-d|--debug] tree\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;
my $treestr = shift;


package Tree;

# Part 1 of the problem: being able to represent a Bin Tree,
# and parsing a string representation of one.

use overload '""' => \&as_string;

#
# my $Tree = Tree->node( $n, $l, $r );
#	create a Tree node with number $n, left tree $l and right tree $r.
#
method node($class: $n, $l, $r )
{
	return bless [
		'node', $n, $l, $r
	], $class;
}

#
# my $Tree = Tree->leaf( $n );
#	create a Tree leaf with number $n.
#
method leaf($class: $n )
{
	return bless [
		'leaf', $n
	], $class;
}

#
# my $Tree = Tree->nil();
#	create a Tree nil.
#
method nil($class:)
{
	return bless [
		'nil'
	], $class;
}

#
# my $Tree = Tree->parse( $str );
#	Build a new Tree by parsing the whole of $str.
#	An example binary tree string might be:
#		(5,(4,(11,l7,l2),n),(8,l13,(9,n,1)))
#	die if $str is not a valid representation of the a Tree.
#
method parse( $str )
{
	$str =~ s/\s+//;
	my( $Tree, $leftover ) = Tree->parse_rec( $str );
	die "Tree->parse( $str ): '$leftover' left over at end\n" if $leftover;
	return $Tree;
}

#
# my( $Tree, $leftover ) = Tree->parse_rec( $str );
#	Build a new Tree by parsing $str, telling us what suffix of $str is leftover (in $leftover).
#	die if $str is not a valid representation of the a Tree.
#
method parse_rec( $str )
{
	return ( Tree->nil(), $str ) if $str =~ s/^n//;
	return ( Tree->leaf($1), $str ) if $str =~ s/^l(\d+)//;

	# node: format (\d+,tree,tree)
	die "Tree->parse_rec( $str ): 'n', 'l', or '(' expected\n" unless $str =~ s/^\(//;

	# what's left: \d+,tree,tree)
	die "Tree->parse_rec( $str ): digit expected\n" unless $str =~ s/^(\d+)//;
	my $n = $1;

	# what's left: ,tree,tree)
	die "Tree->parse( $str ): ',' expected (after number)\n" unless $str =~ s/^,//;

	# what's left: tree,tree)
	my( $l, $leftover ) = Tree->parse_rec( $str );

	# what's left: ,tree)
	die "Tree->parse( $leftover ): ',' expected (after left sub tree)\n" unless $leftover =~ s/^,//;

	# what's left: tree)
	my( $r, $rest ) = Tree->parse_rec( $leftover );

	die "Tree->parse( $str ): ')' expected\n" unless $rest =~ s/\)//;

	return ( Tree->node( $n, $l, $r ), $rest );
}

#
# my( $kind, @pieces ) = $Tree->breakapart();
#	Break the given $Tree apart into it's "kind" (node,left or nil),
#	and it's array of pieces..
#
method breakapart()
{
	die "Tree->breakapart: given Tree not an array; actually ", Dumper($self) unless ref($self) eq "Tree";
	return @$self;
}

#
# my $str = $Tree->as_string();
#	return the given $Tree as a nice printable string.
#
sub as_string($)
{
	my( $self ) = @_;

	die "Tree->as_string: given Tree not an array; actually ", Dumper($self) unless ref($self) eq "Tree";
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
		die "Tree->as_string: given Tree has impossible kind $kind\n";
	}
}


package main;

my $tree = Tree->parse( $treestr );
say "tree is $tree";

#
# my $isbst = is_bst( $tree, $constraintfunc );
#	Determine whether $tree is a BST that obeys $constraintfunc - return
#	1 iff yes, 0 otherwise.
#
fun is_bst( $tree, $constraintfunc )
{
	my( $kind, @pieces ) = $tree->breakapart();
	return 1 if $kind eq "nil";

	if( $kind eq "leaf" )
	{
		return $constraintfunc->( $pieces[0] ) ? 1 : 0;
	}

	# node, pieces are: nodeval,l,r
	my( $nodeval, $l, $r ) = @pieces;
	return 0 unless $constraintfunc->( $nodeval );
	return 0 unless is_bst( $l,
		fun ($v) { return $constraintfunc->( $v ) && $v <= $nodeval } );
	return 0 unless is_bst( $r,
		fun ($v) { return $constraintfunc->( $v ) && $v >= $nodeval } );
	return 1;
}


my $isbst = is_bst( $tree, fun ($v) { return 1 } );
say $isbst;
