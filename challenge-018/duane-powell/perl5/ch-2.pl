#!/usr/bin/perl
use Modern::Perl;

# Write a script to implement Priority Queue. It is like regular queue except each element has a priority associated with it. 
# In a priority queue, an element with high priority is served before an element with low priority.

my $p = PriorityQueue->new();
$p->pull_highest_priority_element();
$p->insert_with_priority(200,"milkshake!");
$p->insert_with_priority(300,"pizza?");
$p->insert_with_priority(500,"cheeseburgers!");
sleep 1; # sleep a second so nodes have different date values
$p->insert_with_priority(250,"steak and eggs!");
$p->queue_print();
$p->pull_highest_priority_element();
$p->insert_with_priority(350,"hotdogs?");
$p->insert_with_priority(550,"pancakces and syrup!");
$p->insert_with_priority(650,"donuts!");
$p->insert_with_priority(600,"cookies!");
$p->queue_print();
$p->pull_highest_priority_element();
$p->queue_print();
$p->pull_highest_priority_element();
$p->pull_highest_priority_element();
sleep 1; # sleep a second so nodes have different date values
$p->insert_with_priority(200,"dr peppers!");
$p->insert_with_priority(300,"pizza?");
$p->insert_with_priority(500,"cheeseburgers!");
$p->insert_with_priority(250,"steak and eggs!");
$p->insert_with_priority(350,"hotdogs?");
$p->insert_with_priority(550,"pancakces and syrup!");
$p->queue_print();
$p->pull_highest_priority_element();
$p->pull_highest_priority_element();
$p->pull_highest_priority_element();
$p->pull_highest_priority_element();
$p->pull_highest_priority_element();
$p->pull_highest_priority_element();
$p->pull_highest_priority_element();
$p->pull_highest_priority_element();
$p->queue_print();
sleep 1; # sleep a second so nodes have different date values
$p->insert_with_priority(350,"hotdogs?");
$p->insert_with_priority(550,"pancakces and syrup!");
$p->queue_print();
$p->pull_highest_priority_element();
$p->pull_highest_priority_element();
$p->pull_highest_priority_element();
$p->pull_highest_priority_element();
$p->pull_highest_priority_element();
$p->queue_print();
exit;

package PriorityQueue;
sub new {
	my $class = shift;
	# Simple class to represent a priority queue.
	# The queue is made of nested hash refs, linked by _next
	# _next=>{ ..., _next=>{ ..., _next=>undef}}
	my $self = {
		_next => undef, # undef signals empty queue
	};
	return bless $self, $class;
}

sub is_empty {
	my $self = shift;
	return not defined $self->{_next};
}

sub insert_with_priority {
	my $self = shift;

	# init new node
	my $priority = shift;
	my $data     = shift;
	my $i = {
		priority => $priority || 100,
		data     => $data,
		date     => time,   
		_next    => undef,  # undef signals end of queue
	};

	# empty queue, insert first node and return
	if ($self->is_empty()) {
		$self->{_next} = $i;
		return;
	}

	# iterate over queue nodes and insert $i where it belongs 
	my $here = $self;
	my $n = $self->{_next};
	while ($n) {
	        if ($n->{priority} >= $i->{priority}) {
			if (defined $n->{_next}) {
				# iterate
				$here = $n;
				$n = $n->{_next};
			} else {
				# we're at the end of queue 
				$n->{_next} = $i;
				return;
			} 
		} else {
			# insert $i here
			$i->{_next} = $here->{_next}; 
			$here->{_next} = $i;
			return;
		}	
	}
}

sub pull_highest_priority_element {
	my $self = shift;
	if ($self->is_empty()) {
		say "nothing to pop, queue is empty.";
		return;
	} else {
		my $n = $self->{_next};
		$self->{_next} = $n->{_next};
		say "popping $n->{priority} $n->{date} $n->{data}";
		return $n;
	} 
}

sub queue_print {
	my $self = shift;
	my $n = $self->{_next};
	my $depth = 0;
	say "queue print:";
	while ($n) {
		my $space = (' ' x $depth);
		say "$space $n->{priority} $n->{date} $n->{data}";
		$n = $n->{_next};
		$depth++;
	}
}


1;

__END__

./ch2.pl 
nothing to pop, queue is empty.
queue print:
 500 1563884736 cheeseburgers!
  300 1563884736 pizza?
   250 1563884737 steak and eggs!
    200 1563884736 milkshake!
popping 500 1563884736 cheeseburgers!
queue print:
 650 1563884737 donuts!
  600 1563884737 cookies!
   550 1563884737 pancakces and syrup!
    350 1563884737 hotdogs?
     300 1563884736 pizza?
      250 1563884737 steak and eggs!
       200 1563884736 milkshake!
popping 650 1563884737 donuts!
queue print:
 600 1563884737 cookies!
  550 1563884737 pancakces and syrup!
   350 1563884737 hotdogs?
    300 1563884736 pizza?
     250 1563884737 steak and eggs!
      200 1563884736 milkshake!
popping 600 1563884737 cookies!
popping 550 1563884737 pancakces and syrup!
queue print:
 550 1563884738 pancakces and syrup!
  500 1563884738 cheeseburgers!
   350 1563884737 hotdogs?
    350 1563884738 hotdogs?
     300 1563884736 pizza?
      300 1563884738 pizza?
       250 1563884737 steak and eggs!
        250 1563884738 steak and eggs!
         200 1563884736 milkshake!
          200 1563884738 dr peppers!
popping 550 1563884738 pancakces and syrup!
popping 500 1563884738 cheeseburgers!
popping 350 1563884737 hotdogs?
popping 350 1563884738 hotdogs?
popping 300 1563884736 pizza?
popping 300 1563884738 pizza?
popping 250 1563884737 steak and eggs!
popping 250 1563884738 steak and eggs!
queue print:
 200 1563884736 milkshake!
  200 1563884738 dr peppers!
queue print:
 550 1563884739 pancakces and syrup!
  350 1563884739 hotdogs?
   200 1563884736 milkshake!
    200 1563884738 dr peppers!
popping 550 1563884739 pancakces and syrup!
popping 350 1563884739 hotdogs?
popping 200 1563884736 milkshake!
popping 200 1563884738 dr peppers!
nothing to pop, queue is empty.
queue print:

