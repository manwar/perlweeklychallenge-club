#!/usr/bin/env perl6
use v6;

class Item {
    has Int $.val;
    has Int $.priority;
}

class PriorityQueue is Array {

    method is_empty {
	return self.elems==0
    }

    method insert_with_priority($val,$priority) {
	my $item=Item.new(val=>$val, priority=>$priority);
	my @rhs=self.grep({ $_.priority >= $priority });
	@rhs.unshift: $item;
	self=(|self.grep({ $_.priority < $priority }), |@rhs)
    }

    method pull_highest_priority_element {
	return self.pop.val
    }

    
}

my $prq = PriorityQueue.new;

say "Is the queue empty initially? ", $prq.is_empty;

for ( 1=>2, 3=>2, -1=>0, 10=>5 ) {
    $prq.insert_with_priority($_.key,$_.value);
}

say "Queue after adding some items: ", $prq;
say "Is the queue empty now? ", $prq.is_empty;
say "Highest-priority item: ", $prq.pull_highest_priority_element;

# run as <script> 
