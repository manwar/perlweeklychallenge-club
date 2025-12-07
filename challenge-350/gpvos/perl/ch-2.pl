#!/usr/bin/perl -w

use v5.34;
use strict;

die "$0 from to count\n"
	unless @ARGV == 3;

my($from, $to, $count) = @ARGV;
my $num_enough_pairs = 0;

foreach my $i ($from .. $to) {
	my @p = shuffle_pairs($i);
	#print $i, ' ', join(' ', map { "$_->[0]:$_->[1]" } @p), "\n"
	#	if @p >= $count;
	++$num_enough_pairs
		if @p >= $count;
}

print "$num_enough_pairs\n";
exit;


sub shuffle_pairs {
	my($n) = @_;
	my $len = length $n;
	my @p;

	# Witnesses cannot be greater than 9 if the length is the same.

	# Larger numbers.
	foreach my $i (2..9) {
		my $m = $n * $i;
		last if length $m > $len;
		push @p, [ $i, $m ];
	}

	# Smaller numbers.
	foreach my $i (2..9) {
		my $m = $n / $i;
		last if length int $m < $len;
		push @p, [ $i, $m ] if length $m == $len; # if float, no witness
	}

	my $s = signature($n);
	return grep { signature($_->[1]) eq $s } @p;
}


sub signature {
	# Count how many times each digit occurs,
	# and summarize as a string for easy comparison.
	my @n;
	++$n[$_] foreach (split //, $_[0]);
	return join ':', map { $n[$_] || 0 } (0..9);
}

