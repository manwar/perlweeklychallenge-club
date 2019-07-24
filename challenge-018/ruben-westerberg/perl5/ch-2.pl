#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw<max min>;
use v5.26;

#######
#Priority Queue IMPLEMENTATION
#######

#Returns true if no elements present in queue
#Requires a hash reference.
sub is_empty {
	my $sum=0;
	my $h=shift;
	$sum+=$$h{$_} for (keys %$h);
	$sum == 0;
}

#Inserts new element, into queue with priorty
#Requres hash reference, integer priority, list of elements to add to queue
sub insert_with_priority {
	my ($h,$p,@a)=@_;
	print "Adding to priority: $p -> ", (join ",", @a),"\n";
	my $sq=$$h{$p};
	$sq=[] unless defined $sq;
	push @$sq, $_ for @a;
	$$h{$p}=$sq;
}

#Prints out queue contents in decreasing priority
#Requires a hash reference
sub list_priorities {
	my $h=shift;
	for (sort { $a<=>$b} keys %$h) {
		print "Prioritory $_:\n";
		print "    ", join(", ", @{$$h{$_}});
		print "\n";
	}
}

#Returns the oldest, highest prioritory element
#Requres a hash reference
sub pull_highest_priority_element {
	my $h=shift;		#Queue reference
	my $p=min keys %$h;	#Get highest priority
	my $sq=$$h{$p};		#Get sub queue
	my $res=shift @$sq;	#Dequeue first (oldest)
	delete $$h{$p} if (@$sq == 0); 	#Remove priorit level
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
insert_with_priority(\%Q,10,"E1", "E2", "E3");
insert_with_priority(\%Q,1,"E4");
insert_with_priority(\%Q,10,"E5");
insert_with_priority(\%Q,2,"E6");

#list contents of queue
print "\nListing contents of Queue\n";
print "=========================\n";
list_priorities(\%Q);

#Drain the queue
print "\nPulling queue until empty\n";
print "==========================\n";
while ( ! is_empty(\%Q) ) {
	print "Pulling: ",pull_highest_priority_element(\%Q),"\n";
}
