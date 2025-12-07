#!/usr/bin/perl -w

use v5.34;
use strict;

foreach (@ARGV) {
	my @g = good_substrings($_);
	#print scalar(@g), ' ', join(' ', @g), "\n";
	print scalar(@g), "\n";
}


sub good_substrings {
	my($a) = @_;
	return grep { !/(.).*\1/ }
		map { substr($a, $_, 3) }
		(0 .. length($a) - 3);
}

