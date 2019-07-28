#!/usr/bin/perl

# 
# Challenge 2: "Write a script to implement Priority Queue. It is like
# regular queue except each element has a priority associated with it. In a
# priority queue, an element with high priority is served before an element
# with low priority. It should serve the following operations:
# 
# 1) is_empty: check whether the queue has no elements.
# 
# 2) insert_with_priority: add an element to the queue with an associated
#    priority.
# 
# 3) pull_highest_priority_element: remove the element from the queue that
#    has the highest priority, and return it. If two elements have the same
#    priority, then return element added first.
# 
# "
# 
# My notes: At last, a nicely specified problem to implement a nice data
# type.  meat and drink to me!  I've split out the Priority Queue
# implementation into the module PQ.pm, minimally-OO in order to
# get free magic PQ printing via interpolation and the magic of
# stringification.

use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;

use lib qw(.);	# I hate this!
use PQ;

my $pq = PQ->new();

foreach my $arg (@ARGV)
{
	if( $arg =~ /^(\d+):(.+)$/ )
	{
		$pq->enqueue( $1, $2 );
	}
	print "pq: $pq\n";
}

while( ! $pq->isempty() )
{
	my( $item, $priority ) = $pq->dequeue();
	print "item $item, priority $priority\n";
	print "pq: $pq\n";
}
