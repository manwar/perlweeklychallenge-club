#!/usr/bin/perl
# 
# Task 2: "Binary Tree Diameter
# 
# You are given binary tree as below:
# 
#     1
#    / \
#   2   5
#  / \ / \
# 3  4 6  7
#        / \
#       8  10
#      /
#     9
# 
# Write a script to find the diameter of the given binary tree.
# 
# The diameter of a binary tree is the length of the longest path between
# any two nodes in a tree. It doesn't have to pass through the root.
# 
# For the above given binary tree, possible diameters (6) are:
# 
# 3, 2, 1, 5, 7, 8, 9
# 
# or
# 
# 4, 2, 1, 5, 7, 8, 9
# 
# 
# UPDATE (2021-08-10 17:00:00 BST): Jorg Sommrey corrected the example.
# 
# The length of a path is the number of its edges, not the number of
# the vertices it connects. So the diameter should be 6, not 7.
# "
# 
# My notes: Looks quite tricky.  We can use generate and test - if we can
# generate all paths, then we could do a "max" test.  Also, how to represent
# the binary tree?  let's hard-code it for now.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;

my $debug = 0;

die "Usage: tree-diameter [hard code in program]\n" unless @ARGV==0;


# ======================= Tree building routines ====================


#
# my $t = l( $v );
#	Generate a tree leaf with value $v, and empty parent.
#
fun l( $v )
{
	return { tag => 'l', v => $v, parent => undef };
}


#
# my $t = n( $v );
#	Generate a tree node with empty left tree, empty right tree,
#	empty parent and value $v.
#
fun n( $v )
{
	return { tag => 'n', l => undef, v => $v, r => undef, parent => undef };
}


#
# setleft( $parent, $child );
#	Mark $child as the left child of $parent and vice versa
#
fun setleft( $parent, $child )
{
	$parent->{l} = $child;
	$child->{parent} = $parent;
}


#
# setright( $parent, $child );
#	Mark $child as the right child of $parent and vice versa
#
fun setright( $parent, $child )
{
	$parent->{r} = $child;
	$child->{parent} = $parent;
}


#     1
#    / \
#   2   5
#  / \ / \
# 3  4 6  7
#        / \
#       8  10
#      /
#     9
my $one = n( 1 );
my $two = n( 2 );
my $three = l( 3 );
my $four = l( 4 );

setleft( $one, $two );
setleft( $two, $three );
setright( $two, $four );

my $five = n( 5 );
setright( $one, $five );

my $six = l( 6 );
setleft( $five, $six );
my $seven = n( 7 );
setright( $five, $seven );
my $eight = n( 8 );
setleft( $seven, $eight );

my $nine = l( 9 );
setleft( $eight, $nine );
my $ten = l( 10 );
setright( $seven, $ten );

#die Dumper( $one );


# ======================= Pathfinding routines ====================


#
# findallpaths( $t, $pathfunc );
#	Find all complete paths through tree $t - and call
#	$pathfunc->( @nodes ) for each one.
#
fun findallpaths( $t, $pathfunc )
{
	say "find all paths starting at $t->{v}" if $debug>1;
	follow( $t, [$t->{v}], {}, $pathfunc );

	if( $t->{tag} eq 'n' )
	{
		findallpaths( $t->{l}, $pathfunc ) if $t->{l};
		findallpaths( $t->{r}, $pathfunc ) if $t->{r};
	}
}


#
# follow( $t, $been, $used, $pathfunc );
#	Follow all paths from $t (with elements we've visited @$been)
#	and used set %$used, calling $pathfunc->( @$been ) for each
#	complete path found.
#
fun follow( $t, $been, $used, $pathfunc )
{
	my $tv = $t->{v};
	my $edges = 0;
	foreach my $edge (qw(parent l r))
	{
		my $e = $t->{$edge};
		next unless defined $e;
		my $ev = $e->{v};
		next if $used->{$ev};
		$edges++;
		say "follow: go along $edge from $tv to $ev" if $debug>1;
		my @newb = @$been;
		push @newb, $ev;
		follow( $e, \@newb, { %$used, $tv=>1 }, $pathfunc );
	}
	$pathfunc->( @$been ) if $edges==0;
}


my $maxlen = 0;
my @longpath = ();
findallpaths( $one,
	fun(@p) {
		say "poss path: ", join( ',', @p ) if $debug;
		my $len = @p-1;
		if( $len > $maxlen )
		{
			$maxlen = $len;
			@longpath = @p;
		}
		} );
say "$maxlen: ", join(',',@longpath);
