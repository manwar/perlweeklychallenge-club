#!/usr/bin/env perl6

#######
#Priority Queue IMPLEMENTATION
#######

#Returns true if no elements present in queue
#Requires a hash.
sub is_empty(%h) {
	my $sum=0;
	$sum+=%h{$_} for (keys %h);
	$sum == 0;
}

#Inserts new element, into queue with priorty
#Requres hash, integer priority, list of elements to add to queue
sub insert_with_priority(%h,$p,*@a)  {
	put "Adding to priority: $p -> ", @a.join: ",";
	my $sq=%h{$p};
	$sq=[] unless defined $sq;
	push @$sq, $_ for @a;
	%h{$p}=$sq;
}

#Prints out queue contents in decreasing priority
#Requires a hash
sub list_priorities(%h) {
	for (sort { $^a <=> $^b}, keys %h) {
		print "Prioritory $_:\n";
		print "    ", %h{$_}.join(", ");
		print "\n";
	}
}

#Returns the oldest, highest prioritory element
#Requres a hash
sub pull_highest_priority_element(%h) {
	my $p=min (keys %h)>>.Int;	#Get highest priority
	my $sq=%h{$p};		#Get sub queue
	my $res=shift $sq;	#Dequeue first (oldest)
	%h{$p}:delete if ($sq == 0); 	#Remove priorit level
					#when empty
	$res;			#return Result
}


#######
#Priority Queue DEMONSTRATION
#######
#Define our Queue
my %Q;

#Insert elements with prioritys
print "Inserting  Items \n";
print "=========================\n";
insert_with_priority(%Q,10,"E1", "E2", "E3");
insert_with_priority(%Q,1,"E4");
insert_with_priority(%Q,10,"E5");
insert_with_priority(%Q,2,"E6");

#list contents of queue
print "\nListing contents of Queue\n";
print "=========================\n";
list_priorities(%Q);

#Drain the queue
print "\nPulling queue until empty\n";
print "==========================\n";
while ( ! is_empty(%Q) ) {
	print "Pulling: ",pull_highest_priority_element(%Q),"\n";
}
