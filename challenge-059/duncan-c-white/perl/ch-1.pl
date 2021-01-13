#!/usr/bin/perl
#
# Task 1: "Linked List
#
# You are given a linked list and a value k. Write a script to partition
# the linked list such that all nodes less than k come before nodes greater
# than or equal to k. Make sure you preserve the original relative order
# of the nodes in each of the two partitions.
# 
# For example:
# 
# Linked List: 1 -> 4 -> 3 -> 2 -> 5 -> 2
# 
# k = 3
# 
# Expected Output: 1 -> 2 -> 2 -> 4 -> 3 -> 5.
# "
# 
# My notes: why a linked list not an array, it would be so simple with an
# array.  Ok, ok, a linked list: but the question is: do we want to reuse
# the existing nodes or build fresh.  Building fresh would make it a "pure"
# functional-style implementation.  But let's try reusing the existing
# nodes..
# Build two lists (reusing the existing nodes), one "before", the other "after".
# Unlink each node, append it to whichever list is appropriate. Repeat.
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;


die "Usage: list-partition k elements\n" if @ARGV==0;
my( $k, @el ) = @ARGV;

# usually I would write the list as an inline bless() class.
# this time, just for the sake of variety, let's not bother with the gloss.

# how to represent the list?  [] for nil, [h,t] for cons(h,t)

fun nil() { return [] }
fun cons($h,$t) { return [$h,$t] }
fun single($h) { return [$h,[]] }
fun isnil($l) { return @$l==0?1:0 }


#
# my $list = a2l( @el );
#	Convert a plain Perl array @el into a nil/cons list.
#	Return the generated list.
#
fun a2l( @el )
{
	return nil() unless @el;
	my $first = shift @el;
	my $l = single($first);	# create one-element list
	my $last = $l;		# "pointer to last node"

	foreach my $x (@el)
	{
		# append $x to list $l via $last
		$last = $last->[1] = single($x);
	}

	return $l;
}


#
# my $str = l2s($l);
#	Generate printable (string) format of list $l.
#
fun l2s( $l )
{
	return "nil" unless @$l;
	( my $h, $l ) = @$l;

	my $s = "$h";

	# foreach element h in $l
	while( @$l )
	{
		( my $h, $l ) = @$l;
		$s .= " -> $h";
	}
	return $s;
}


#
# partition( $l, $k );
#	Partition list $l (modifying it in place)
#	such that all elements from $l that are < $k
#	come first (in the same order as they were found
#	in $l) followed by all elements from $l are >= $k
#	(also in the same order as found in $l).
#
fun partition( $l, $k )
{
	return if isnil($l);

	# before and after lists, and their last node pointer
	my $before = nil();
	my $lastb = $before;

	my $after = nil();
	my $lasta = $after;

	# keep the original array ref to change @$origl later
	my $origl = $l;

	# loop over $l, detaching each node, and appending it
	# to either $before or $after
	my $nil = nil();
	while( @$l )	# ! isnil
	{
		my $p = $l;
		( my $h, $l ) = @$l;
		$p->[1] = $nil;

		if( $h < $k )
		{
			# add to before
			if( @$lastb == 0 )
			{
				$lastb = $before = $p;
			} else
			{
				$lastb = $lastb->[1] = $p;
			}
		} else
		{
			# add to after
			if( @$lasta == 0 )
			{
				$lasta = $after = $p;
			} else
			{
				$lasta = $lasta->[1] = $p;
			}
		}
	}

	# now $l is logically empty, reconstruct it
	# from before++after
	if( @$before == 0 )
	{
		@$origl = @$after;
	} else
	{
		# connect after to end of before
		$lastb->[1] = $after;

		@$origl = @$before;
	}
}


# first, build input list from @el
my $list = a2l( @el );
say "input list: ", l2s($list);

# second, partition list
partition( $list, $k );
say "partition($k): ", l2s($list);
