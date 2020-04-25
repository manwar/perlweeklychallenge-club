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
#   '(1,(2,l4,l5),(3,l6,l7))'
# - longer input trees are:
#   '(1,(2,(4,l8,l9),(5,l10,l11)),(3,(6,l12,l13),(7,l14,l15)))'
#   '(1,(2,(4,(8,l16,l17),(9,l18,l19)),(5,(10,l20,l21),(11,l22,l23))),
#    (3,(6,(12,l24,l25),(13,l26,l27)),(7,(14,l28,l29),(15,l30,l31))))'
#
# here:
#   (N,L,R) represents a node with value N, left tree L and right tree R;
#   lN represents a leaf with value N
#   n represents nil
#
# The "flip-left-right" algorithm looks very simple.  Not sure why "full"
# is stressed, AFAIK any obvious algorithm for this would deal with any
# binary tree.  The only difference that dealing with a "full" binary tree
# makes is that all the leaves are at the bottom level.
#
# In Haskell, it's as simple as:
# 
# fliplr e = e
# fliplr leaf(n) = leaf(n)
# fliplr node(n,l,r) = node(n, fliplr(r), fliplr(l))
# 
# The bonus is the most difficult part, as best layout may be slightly
# subjective, and it's not clear algorithmically what spacing is needed
# at each level.  An obvious alternative would be to use GraphViz to
# draw the directed graph (our tree), I did that first and it worked fine,
# but in this version I attempt the fullblown ASCII art layout..  new:
# decided to generalise it to deal properly with non-full binary trees too,
# ie. missing elements.
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;
use List::Util qw(max);


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


#
# my @levels = findlevels( $bintree );
#	Find all the levels of the binary tree $bintree, returning
#	an array of levels, where each level is a reference to an array
#	containing 2^level entries: all integer values from that level,
#	with "undef" filling in for missing entries.
#
fun findlevels( $bintree )
{
	my @levels;
	buildlevels( $bintree, 0, 0, \@levels );
	return @levels;
}

#
# buildlevels( $bintree, $level, $pos, $levels );
#	Recursive routine to build @$levels, an array of levels,
#	where each level is a reference to an array of all values in that level.
#	$level is the starting level number, and $pos is the starting index
#	to write element values into.
#
fun buildlevels( $bintree, $level, $pos, $levels )
{
	my( $kind, @pieces ) = $bintree->breakapart();
	my $two_to_level = 1<<$level;
	if( $kind eq "node" || $kind eq "leaf" )
	{
		my $n = shift @pieces;
		my $lref = ($levels->[$level] //= [ (undef) x $two_to_level ]);
		$lref->[$pos] = $n;
		if( $kind eq "node" )
		{
			my( $l, $r ) = @pieces;
			buildlevels( $l, $level+1, 2*$pos, $levels );
			buildlevels( $r, $level+1, 2*$pos+1, $levels );
		}
	} elsif( $kind ne "nil" )
	{
		die "bintree->buildlevels: given bintree has impossible kind $kind: ", Dumper($bintree);
	}
}


#
# my @pos = bottomrow_positions( $nel, $w );
#	Determine the positions of the $nel elements (each of width $w)
#	in the bottom row of the ASCII art pretty printed binary tree.
#	Return the array of positions, each the LEFT HAND index of
#	the width $w field.
#
fun bottomrow_positions( $nel, $w )
{
	my $gap = $w+3;		# gap switches between w+3 and 2+3 each time, by adding delta to it
	my $delta = -1;		# delta changes sign each time
	my $currpos = 0;
	my @pos = ( 0 );
	foreach my $i (1..$nel-1)
	{
		$currpos += $gap;
		push @pos, $currpos;
		$gap += $delta;
		$delta = - $delta;
	}
	#die "debug: ", join(',',@pos);
	return @pos;
}


#
# my $rowstr = layoutrow( $rowlen, $w, $element, $pos );
#	Layout one row of elements (@$element) as ASCII art, displaying each
#	element in a field of width $w, using the positions in @$pos.
#	Return the ASCII art row string $rowstr.
#
fun layoutrow( $rowlen, $w, $element, $pos )
{
	my $str = '.' x $rowlen;
	my $left = 1;		# next element: left-aligned or right-aligned?
	my $n = @$element;
	foreach my $i (0..$n-1)
	{
		my $lr = $left?'-':'';
		substr( $str, $pos->[$i], $w ) = sprintf( "%$lr${w}d", $element->[$i] ) if defined $element->[$i];
		$left = ! $left;
	}
	return $str;
}


#
# my @pos = findmidpositions( @elementpos );
#	Find the middle positions between each pair of element positions in @elementpos.
#	Return the array of mid-positions (half as long as @elementpos).
#
fun findmidpositions( @elementpos )
{
	my @pos;
	while( @elementpos )
	{
		my $a = shift @elementpos;
		my $b = shift @elementpos;
		push @pos, int(($a+$b)/2);
	}
	return @pos;
}


#
# my $diagstr = makediag( $rowlen, $thispos, $nextpos, $nextrowelements );
#	Given $rowlen, the total length of a row string, and
#	@$thispos, an array of positions of one row's elements, and
#	@$nextpos, an array [twice as long] of positions of the NEXT row's elements,
#	@$nextrowelements, the NEXT row's elements themselves (to check for
#	undefinedness for incomplete trees),
#	build and return the /..\ diagonal line string BETWEEN those rows.
#	
#	For example:
#	
#	..2......3..
#	./.\..../.\.
#	4...5..6...7
#	
#	i.e. if @thispos = (2,9) [the positions of the "2" and "3"),
#	and @nextpos = (0,4,7,11) positions, then the /\ will be at positions:
#	1 [avg of 0 and 2], 3 [avg of 2 and 4],
#	8 [avg of 9 and 7] and 10 [avg of 9 and 11]
#
fun makediag( $rowlen, $thispos, $nextpos, $nextrowelements )
{
	my @nextpos = @$nextpos;
	my @diagpos;
	foreach my $tp (@$thispos)
	{
		my $np = shift @nextpos;
		push @diagpos, int(($tp+$np)/2);
		$np = shift @nextpos;
		push @diagpos, int(($tp+$np)/2);
	}
	#say "debug: makediag: rowlen=$rowlen, thispos=", join(',',@$thispos);
	#say "debug: makediag: nextpos=", join(',',@$nextpos);
	#say "debug: makediag: diagpos=", join(',',@diagpos);

	# now build the string containing / and \ at the position in @diagpos
	my $left = 1;
	my $str = '.' x $rowlen;
	foreach my $tpos (0..$#diagpos)
	{
		my $pos = $diagpos[$tpos];
		substr( $str, $pos, 1 ) = $left ? '/' : '\\' if
			defined $nextrowelements->[$tpos];
		$left = ! $left;
	}
	return $str;
}


#
# my $asciidata = pretty_print( $bintree );
#	Generate the pretty printed version of $bintree as ASCII art.
#
fun pretty_print( $bintree )
{
	# first, find the element values at which level:
	# levels[0] = [1], levels[1] = [2,3], levels[2] = [4,5,6,7] etc..

	my @levels = findlevels( $bintree );
	#say Dumper \@levels;

	# layout the bottom row first
	my @bottomrow = @{$levels[$#levels]};

	# find the element width
	my $w = max( map { length($_) // 0 } @bottomrow );

	# find the row length
	my $nel = @bottomrow;
	my $rowlen = $nel*$w + ($nel/2)*3 + ($nel/2-1)*2;
	#say "rowlen=$rowlen";

	my @pos = bottomrow_positions( $nel, $w );
	#say "debug: pos bottomrow = ", join(',',@pos);

	my $botrow = layoutrow( $rowlen, $w, \@bottomrow, \@pos );
	#say "row $#levels is: $botrow";

	my @asciirows = ( $botrow );

	# now iterate over all previous rows, generating row $rn (and
	# the /\ row between row $rn and row $rn+1) from row $rn+1

	my @nextpos = @pos;
	for( my $rn=$#levels-1; $rn>=0; $rn-- )
	{
		# row $rn, the positions are the averages of row $rn+1

		my @rowN = @{$levels[$rn]};

		my $w = max( map { length($_) // 0 } @rowN );

		# this row's positions are the middle of the next row's positions
		my @pos = findmidpositions( @nextpos );
		#say "debug: pos ", join(',',@pos);

		# layout for row N: gaps are differences between positions
		my $thisrow = layoutrow( $rowlen, $w, \@rowN, \@pos );
		#say "row $rn is: $thisrow";
		#say "debug: nextpos row $rn = ", join(',',@pos);

		# make diagonal lines row between this row and next row
		my @nextrowN = @{$levels[$rn+1]};
		my $diagstr = makediag( $rowlen, \@pos, \@nextpos, \@nextrowN );
		unshift @asciirows, $thisrow, $diagstr;

		@nextpos = @pos;
	}

	say foreach @asciirows;
}


my $bintree = BinTree->parse( $treestr );
say "tree is $bintree";

my $flipped = fliplr( $bintree );
say "flipped tree is $flipped";

say "bonus: pretty printing of original tree";
say pretty_print( $bintree );

say "bonus: pretty printing of flipped tree";
say pretty_print( $flipped );
