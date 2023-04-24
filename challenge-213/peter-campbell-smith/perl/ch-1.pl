#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-04-17
use utf8;     # Week 213 task 1 - Fun sort
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

my ($j, @list);

fun_sort([1, 2, 3, 4, 5, 6]);
fun_sort([1, 2]);
fun_sort([1]);

# longer example
for $j (1 .. 50) {
	push @list, int(rand(50) + 1);
}
fun_sort(\@list);

sub fun_sort {
	
	# add a million to all the odd numbers, then
	# sort and then subtract a million from the odd ones
	my @list = map {$_ & 1 ? $_ - 1000000 : $_} 
		sort {$a <=> $b} 
		map {$_ & 1 ? $_ + 1000000 : $_} @{$_[0]};
	
	say qq[\nInput:  \@list = (] . join(', ', @{$_[0]}) . q[)];
	say qq[Output: \@list = (] . join(', ', @list) . q[)];
}
