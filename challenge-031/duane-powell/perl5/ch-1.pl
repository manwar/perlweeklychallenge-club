#!/usr/bin/perl
use warnings;
use strict;

# Create a function to check divide by zero error without checking if the denominator is zero.

my %h = @ARGV;
while ( my ($n, $d) = each (%h) ) {
	my $o;	
	eval { $o = $n/$d };
	if ( $@ ) {
		print "$n/$d = division by zero.\n";
	} else {
		print "$n/$d = $o\n";
	}
}

__END__

./ch-1.pl 10 5 99 1 5 0 7 0 8 5
8/5 = 1.6
7/0 = division by zero.
10/5 = 2
99/1 = 99
5/0 = division by zero.

