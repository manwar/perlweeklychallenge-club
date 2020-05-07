#!/usr/bin/perl

# expects input in @ARGV
# prints result to STDOUT
# numbers must be in the range 0 .. 2**64 - 1

use strict;
use warnings;

my $sum;
while (defined (my $x = shift)) {
	my $bits = pack 'Q', $x;
	$sum += unpack '%64b*', $bits ^ $_ foreach map {pack 'Q', $_} @ARGV;
}
print $sum, "\n";
