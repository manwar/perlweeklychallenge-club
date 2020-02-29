#!/usr/bin/perl
use warnings;
use strict;
use feature 'say';

# Problem: https://perlweeklychallenge.org/blog/perl-weekly-challenge-049/ TASK #2
# This one is easy to write but I fear will be hard to read later. Needs to be polished.

my $capacity = shift || 3;
my $verbose  = shift; 
my $q = LRU_Cache->new($capacity, $verbose);

$q->set(1,'red');
$q->set(2,'orange');
$q->set(3,'yellow');
$q->queue_say();
$q->get(2);
$q->queue_say();
$q->get(1);
$q->queue_say();
$q->get(4);
$q->queue_say();
$q->set(4,'green');
$q->queue_say();
$q->get(3);
# $q->queue_dump(); # see the object internals
exit;

package LRU_Cache;
use Data::Dumper;
use constant {
	EVICTED => '-1',
	VERBOSE => 1,
	SILENT  => 1,
};

sub new {
	my $class    = shift;
	my $capacity = shift;
	my $verbose  = shift;
	my $self = {
		cap   => $capacity, # size limit of the cache
		verb  => $verbose,   
		set   => 0,         # how many times set() has been called
		head  => undef,     # most recent key
		tail  => undef,     # least recent key
		cache => {
			# the cache is a hash of hashes, called nodes
			# see node_generate()
		},
	};
	say "capacity = $capacity" if ($verbose);
	return bless $self, $class;
}
sub node_generate {
	my $self = shift;
	my $data = shift;
	return { # double linked list node
		prev => undef,
		next => undef,
		data => $data,
	}
}
sub set {
	my $self = shift;
	my $curr = shift;
	my $data = shift;

	# Count how many times we've been called
	$self->{set}++;

	# On first call the vars head, current and tail are all the same 
	if ( $self->{set} == 1 ) { 
		$self->{tail} = $curr;
		$self->{head} = $curr; 
	}

	# Try to get data before setting data.
	# As written cache values can not be changed, they 
	# must be evicted and then re-set
	if ( $self->get($curr, SILENT) eq EVICTED) {
		# Generate new node, set it as the head. 
		# Update caches internal pointers.
		my $node = $self->node_generate($data);
		my $old_head = $self->{head};
		my $new_head = $curr;
		$self->{cache}{$old_head}{prev} = $new_head;
		$self->{cache}{$new_head} = $node;
		$self->{cache}{$new_head}{next} = $old_head;
		$self->{head} = $new_head; 

		# If the cache is full set new tail and evict old tail
		if ($self->{set} > $self->{cap}) {
			my $old_tail  = $self->{tail};
			$self->{tail} = $self->{cache}{$old_tail}{prev};
			delete $self->{cache}{$old_tail};
		}
	}
	say "set($curr,$data)" if ($self->{verb});
	return $data;
}
sub get {
	my $self   = shift;
	my $curr   = shift;
	my $silent = shift; 

	# If get() is called internally by set() be quiet
	my $verbose = ($silent) ? 0 : $self->{verb};

	my $data = EVICTED; # Assume cache miss
	if ($self->{cache}{$curr}{data}) {
		# Cache hit
		$data = $self->{cache}{$curr}{data};

		# Update cache internal pointers, there are three cases 
		if ($self->{head} == $curr) {
			# Nothing to do, we are already most recently used, aka the head
			say "get($curr)        # returns $data" if ($verbose);
			return $data;
		} 
		elsif ($self->{tail} == $curr) {
			# We are the tail node, make our previous node the new tail
			my $prev = $self->{cache}{$curr}{prev};
			$self->{cache}{$prev}{next} = undef; # tail doesn't have a next
			$self->{tail} = $prev;
		} 
		else {
			# We are being pulled from the middle, fill our
			# gap by linking our prev and next nodes together
			my $prev = $self->{cache}{$curr}{prev};
			my $next = $self->{cache}{$curr}{next};
			$self->{cache}{$prev}{next} = $next;
			$self->{cache}{$next}{prev} = $prev; 
		}
	
		# Finally, make current the node the most recently used
		# and changle old head's pointers
		my $old_head = $self->{head}; 
		$self->{cache}{$curr}{next} = $old_head; # I am on top the old head
		$self->{cache}{$old_head}{prev} = $curr;
		$self->{cache}{$curr}{prev} = undef;     # head doesn't have a previous
		$self->{head} = $curr;
	}
	say "get($curr)        # returns $data" if ($verbose);
	return $data;
}
sub queue_dump {
	my $self = shift;
	say Dumper($self);
}
sub queue_say {
	my $self = shift;
	print "\n[LRU] ";
	my $node = $self->{tail};
	until ($node == $self->{head}) {
		print "$node=>", $self->{cache}{$node}{data}, ", ";
		$node = $self->{cache}{$node}{prev};
	}
	say "$node=>", $self->{cache}{$node}{data}, " [MRU]\n";
}

__END__

capacity = 3
set(1,red)
set(2,orange)
set(3,yellow)
[LRU] 1 => red, 2 => orange, 3 => yellow [MRU]

get(2) # returns orange

[LRU] 1 => red, 3 => yellow, 2 => orange [MRU]

get(1) # returns red

[LRU] 3 => yellow, 2 => orange, 1 => red [MRU]

get(4) # returns -1

[LRU] 3 => yellow, 2 => orange, 1 => red [MRU]

set(4,green)
[LRU] 2 => orange, 1 => red, 4 => green [MRU]

get(3) # returns -1




