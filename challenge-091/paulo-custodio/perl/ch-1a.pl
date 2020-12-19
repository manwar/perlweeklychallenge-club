#!/usr/bin/env perl

# THE WEEKLY CHALLENGE - 091
# TASK #1: Count Number
#
# You are given a positive number $N. Write a script to count number and display as you read it.
# Numeric recursive solution
use strict;
use warnings;

my $N = shift;
read_number($N);

sub read_number {
	my($n) = @_;
	read_number_($n);
	print "\n";
}

sub read_number_ {
	my($n) = @_;
	return unless $n > 0;	# end condition
	
	# count number of equal digits at the end
	my $digit = $n % 10;
	my $count = 0;
	while ($n > 0 && ($n % 10) == $digit) {
		$n = int($n / 10);
		$count++;
	}

	# recurse to print top part
	read_number_($n);
	
	# print last digits
	print $count,$digit;
}
