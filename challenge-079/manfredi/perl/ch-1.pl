#!/usr/bin/env perl
use strict;
use warnings;

my $N = $ARGV[0] || 5;
my $one = 0;

print "Input: \$N = $N\n";

for my $n (1..$N) {
	$_ = sprintf("%b", $n);
	my $bit = tr/1//d;
	printf "\tDecimal: %d\n\tBinary: 0b%08b\n\tSet Bit Count: %d\n\n", $n, $n, $bit;
	$one += $bit;
}

my $z = $one % 1000000007;
print "Total set bit count: ($one % 1000000007) = $z\n";
