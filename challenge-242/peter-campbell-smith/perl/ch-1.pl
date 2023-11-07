#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-11-06
use utf8;     # Week 242 task 1 - Missing members
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use List::Uniq 'uniq';

missing_members([1, 2, 3], [2, 4, 6]);
missing_members([1, 2, 3, 3], [1, 1, 2, 2]);
missing_members([1, 2, 3, 4, 5, 6, 7, 8, 9], [2, 4, 6, 8, 10]);

# make bigger example
my ($j, @arr1, @arr2);
for $j (0 .. 29) {
	push @arr1, int(rand(15) + 1);
	push @arr2, int(rand(15) + 1);
}
missing_members(\@arr1, \@arr2);

sub missing_members {
	
	printf('%sInput:  ([%s], [%s])%s', "\n", join(', ', @{$_[0]}), join(', ', @{$_[1]}), "\n");
	printf('Output: ([%s], [%s])%s', mm($_[0], $_[1]), mm($_[1], $_[0]), "\n");
}

sub mm {
	
	my (@one, @two, $j);
	
	# make each array unique
	@one = uniq(@{$_[0]});
	@two = uniq(@{$_[1]});
	
	# delete from @one anything that occurs in @two
	for $j (@two) {
		@one = grep { $_ != $j } @one;
	}
	
	# and return what's left
	return join(', ', @one);
}
	