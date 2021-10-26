#!/usr/bin/env perl

# TASK #2 > Add Linked Lists
# Submitted by: Mohammad S Anwar
# You are given two linked list having single digit positive numbers.
# 
# Write a script to add the two linked list and create a new linked representing
# the sum of the two linked list numbers. The two linked lists may or may not
# have the same number of elements.
# 
# HINT: Just a suggestion, feel free to come up with your own unique way to deal
# with the task. I am expecting a class representing linked list. It should have
# methods to create a linked list given list of single digit positive numbers
# and a method to add new member. Also have a method that takes 2 linked list
# objects and returns a new linked list. Finally a method to print the linked
# list object in a user friendly format.
#
# Example 1:
# Input: L1 = 1 -> 2 -> 3
#        L2 = 3 -> 2 -> 1
# Output: 4 -> 4 -> 4
# 
# Example 2:
# Input: L1 = 1 -> 2 -> 3 -> 4 -> 5
#        L2 =           6 -> 5 -> 5
# Output:     1 -> 3 -> 0 -> 0 -> 0

use Modern::Perl;
use HOP::Stream ':all';

use Data::Dump 'dump';

@ARGV==2 or die "Usage: ch-2.pl l1 l2\n";
my $l1 = list_to_stream(split //, $ARGV[0]);
my $l2 = list_to_stream(split //, $ARGV[1]);
my $sum = add_streams($l1, $l2);
say show($sum);

sub reverse_stream {
	my($in) = @_;
	my $out;
	while ($in) {
		my $n = drop($in);
		$out = node($n, $out);
	}
	return $out;
}

sub add_streams {
	my($l1, $l2) = @_;
	$l1 = reverse_stream($l1);
	$l2 = reverse_stream($l2);
	my($sum);
	my $carry = 0;
	while ($l1 || $l2 || $carry) {
		my $n1 = drop($l1) // 0;
		my $n2 = drop($l2) // 0;
		my $s = $n1+$n2+$carry;
		$sum = node($s % 10, $sum);
		$carry = int($s / 10);
	}
	return $sum;
}
