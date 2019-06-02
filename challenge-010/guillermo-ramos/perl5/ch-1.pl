#!/usr/bin/env perl
#
# Write a script to encode/decode Roman numerals. For example, given Roman
# numeral CCXLVI, it should return 246. Similarly, for decimal number 39, it
# should return XXXIX. Checkout wikipedia page for more information.
# (https://en.wikipedia.org/wiki/Roman_numerals)
################################################################################

use strict;
use warnings;

# CLI usage
sub usage {
	print "$0 {-e ARABIC | -d ROMAN | --test}\n";
	exit shift;
}
usage -1 unless @ARGV > 0;
if ($ARGV[0] eq "--test") {
	test();
} else {
	usage -1 unless @ARGV == 2;
	if ($ARGV[0] eq "-d") {
		print decode($ARGV[1]), "\n";
	} elsif ($ARGV[0] eq "-e") {
		print encode($ARGV[1]), "\n";
	} else {
		usage -1;
	}
}

# roman -> arabic
sub decode {
	my @roman = split //, shift;

	# Decimal value of each roman symbol
	my %dec = (
		M => 1000,
		D =>  500,
		C =>  100,
		L =>   50,
		X =>   10,
		V =>    5,
		I =>    1,
	);
	my $arabic = 0; # Return value

	# Iterate over roman symbols
	for (my $i = 0; $i < @roman; $i++) {
		# Get current and next symbols
		my ($currsym, $nextsym) = @roman[$i .. $i+1];
		my $val = $dec{$currsym};

		# Sub current value if next symbol is bigger; add it otherwise
		if (defined $nextsym && $val < $dec{$nextsym}) {
			$arabic -= $val;
		} else {
			$arabic += $val;
		}
	}

	return $arabic;
}

# arabic -> roman
sub encode {
	die "ERROR: Unable to encode numbers bigger than 9999" if $_[0] > 9999;

	my @arabic = split //, shift;

	my @symbols = ("I", "V", "X", "L", "C", "D", "M");
	my @roman; # Return value (roman symbols)

	# Iterate arabic digits from right to left (upward units)
	for (my $i = $#arabic; $i >= 0; $i--) {
		my $digit = $arabic[$i];

		# Roman symbols corresponding to (1-5-10) given the current base
		my ($one, $five, $ten) = @symbols;

		# Roman symbols to add at the beginning of the current result
		my @to_add;

		# 4 and 9 are (5-1) and (10-1) respectively
		if ($one ne "M" && ($digit == 4 || $digit == 9)) {
			push @to_add, $one;
			$digit++;
		}

		# Add the roman equivalents to the current digit
		if ($one eq "M") {
			# For 4000-9999, just add as much M's as needed
			push @to_add, (map $one, (1..$digit));
		} elsif ($digit == 10) {
			push @to_add, $ten;
		} elsif ($digit > 4) {
			push @to_add, ($five, map $one, (6..$digit));
		} elsif ($digit > 0) {
			push @to_add, (map $one, (1..$digit));
		}
		unshift @roman, @to_add;

		# For the next decimal, discard two roman symbols (one + five)
		shift @symbols foreach (1..2);
	}

	return join "", @roman;
}

# Property:
#   forall (x : Arabic). x == decode(encode(x))
sub test {
	foreach my $i (1..9999) {
		my $roman = encode($i);
		my $arabic = decode($roman);
		die "ERROR: $i -> $roman -> $arabic" if $i != $arabic;
	}
	print "Test successful\n";
}
