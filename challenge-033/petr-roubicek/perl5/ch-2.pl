#!/usr/bin/perl
use strict;
use warnings;

for my $x (1..11) {
	if ( $x == 1 ) {
		printf "% 3s|", 'x';
		map { printf "% 4s", $_ }1..11;
		print "\n", "---+", "-" x (44), "\n";
	}
	
	printf "% 3s|", $x;
	for my $y (1..11) {
		my $v = $y >= $x ? $x*$y : ' ';
		printf "% 4s", $v;
	}
	print "\n";
}
