#!/usr/bin/env perl

# THE WEEKLY CHALLENGE - 091
# TASK #1: Count Number
#
# You are given a positive number $N. Write a script to count number and display as you read it.
# Solution with regular expressions
use strict;
use warnings;

my $N = shift;
while ($N ne '') {
	$N =~ s/^((\d)\2*)// or die;
	print length($1), $2;
}
print "\n";
