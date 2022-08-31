#!/usr/bin/env perl
#
# Task 1: First Unique Character
#	You are given a string, $s.
#	Write a script to find out the first unique character in the given string and print its index (0-based).
#
#	./TWC-180-c1.pl 'Perl Weekly Challenge'
#	 The first unique letter is: P at index: 0
#	./TWC-180-c1.pl 'Long Live Perl'
#	 The first unique letter is: o at index: 1
#

use strict;
use warnings;

die "Missing mandatory arg!\n" unless defined $ARGV[0];

my $String = $ARGV[0];
my $i=0;

foreach my $letter (split(//, $String)) {
	my @matches = $String =~ /$letter/g;
	if ( scalar(@matches) eq 1 )
	{
		print ("The first unique letter is: $letter at index: $i\n");
		last;
	}
	$i++;
}
