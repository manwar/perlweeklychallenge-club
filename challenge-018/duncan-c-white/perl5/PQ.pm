package PQ;

# 
# Priority Queue module.
# each element has a priority associated with it. an element with high
# priority is served before an element with low priority.
# Has the following operations:
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
# type.  meat and drink to me!

use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;

# ok, a priority queue can be an array of pairs, each pair
# is [priority, item]

use overload '""' => \&as_string;

#
# my $pq = PQ->new();
#	Create an empty priority Queue.
#
method new( $class: )
{
	return bless( [], 'PQ' );
}


#
# my $isempty = $pq->isempty();
#	Check whether or not the given Priority Queue is empty.
#	Return boolean - true iff $pq is empty, else false
#
method isempty(  )
{
	return @$self == 0 ? 1 : 0;
}


#
# $pq->enqueue( $priority, $item );
#	Modify the Priority Queue $pq, adding the given $item with
#	the given $priority.
#
method enqueue( $priority, $item )
{
	my $pair = [ $priority, $item ];
	if( @$self == 0 )
	{
		@$self = $pair;
	} else
	{
		# find insertion point, the largest pos $p 
		# whose priority is less than or equal to $priority
		my $p;
		for( $p=0; $p<@$self && $self->[$p][0]<=$priority; $p++ )
		{
		}
		splice( @$self, $p, 0, $pair );
	}
}


#
# my( $item, $priority ) = $pq->dequeue();
#	Dequeue the item with the lowest priority from $pq.
#
method dequeue(  )
{
	die if @$self==0;
	my $pair = shift @$self;
	return @$pair;
}


#
# my $str = $pq->as_string();
#	Generate the printable form of the priority queue.
#
method as_string( $x, $y )
{
	my $result = join(', ', map { "$_->[0]: $_->[1]" } @$self );
	return "[$result]";
}


1;
