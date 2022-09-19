#!/usr/bin/env perl

A: for my $n (1 .. 100) {
	my @digits = split //, $n+reverse($n);

	for my $digit (@digits) {
		($digit % 2 == 0) && (next A); 	
	}
	print "$n ";
}
print "\n";

