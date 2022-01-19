#!/usr/bin/perl

# Peter Campbell Smith - 2021-12-06
# PWC 142 task 2

use v5.20;
use warnings;
use strict;

# Implement Sleep Sort. In this sorting technique, we create different threads for 
# each individual element present in the array. The thread is then made to sleep 
# for an amount of time that is eproprotionate to value of the element for which 
# it was created.

use Parallel::ForkManager;

my @array = (4, 6, 42, 3, 38, 54, 1, 17);
say qq[Sleep sort of: ] . join(' ', @array);

my $pm = Parallel::ForkManager->new(scalar @array); # number of parallel processes
for my $a (@array) {
	my $pid = $pm->start;   # if this is the parent create a child
	next if $pid;   # ... and don't do the rest ogf the loop
	sleep $a / 2;   # if this is a child, sleep for $a/2 seconds
	say $a;   		# ... and print $a
  	$pm->finish;    # ... and stop
}

$pm->wait_all_children;
