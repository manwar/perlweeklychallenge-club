#!/usr/bin/env perl
#
# Solution to challenge #1 of the Perl Weekly Challenge 002.

while (<>) {
	chomp;
	$_ =~ s/^0+//;
	print "$_\n";
}
