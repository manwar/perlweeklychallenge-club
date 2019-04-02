#!/usr/bin/env perl
#
# Solution to challenge #2 of the Perl Weekly Challenge 002.
#
# Task: Write a script that can convert integers to and from a base35
# representation, using the characters 0-9 and A-Y. 
#
# Prerequisites: cpan install Scalar::Util::Numeric
#
# Usage:
# > echo {0.999} | ./ch-02.pl to
#
# Test with:
# >  echo {0..99} | ./ch-02.pl to | awk '{print $3}' | ./ch-02.pl from
#
# TODO: add tests

use strict;
use warnings;
use Scalar::Util::Numeric qw(isint);
use Data::Dump;

use v5.10;

# TODO: split the string right here into an array and don't keep the $BASE variable
my $BASE = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXY";

exit 1 unless @ARGV == 1;
my $switch = $ARGV[0];

while (<STDIN>) {
	chomp;
	# TODO: find out how to stream input, instead of saving it to an array first
	my @input = split;
	for my $i (@input) {
		my $output;
		if ($switch eq "to") {
			$output = toBase35($i);
		} elsif ($switch eq "from") {
			$output = fromBase35($i);
		} else {
			say "Please specify to/from";
			exit 2;
		}
		# `pretty' print output
		printf "%-4s\t==>\t%-4s\n", $i, $output;
	}
}
exit 0;

sub toBase35 {
	my $input = shift;

	my @base = split "", $BASE;
	my @convert;
	my $max = 0;

	# Figure out the highest power of the base we need by incrementing
	# base^power until it is bigger than the input. The exponent we're
	# looking for is 1 less.
	while (1) {
		last unless @base ** ++$max <= $input;
	}

	# Figure out the number's place values in a similar way by subtracting
	# base^power from the input until the input is smaller than the value
	# we're subtracting from it. The place values are saved in the array @convert.
	while ($max > 0) {
		my $exp = $max - 1;
		my $pow = @base ** $exp;
		my $place;
		while ($pow <= $input) {
			$input -= $pow;
			$place++;
		}
		push @convert, $place;
		$max--;
	}

	# Return our number in the new base, by indexing the @base array with
	# the @convert array.
	# TODO: figure out if this implict return is `bad style'
	my $output = join "", @base[@convert];
}

sub fromBase35 {
	my $input = shift;

	# We create a hash converting an alphanumeric character in the new base to
	# a base10 value
	# TODO: move this out of the function
	my %hash;
	my @base = split "", $BASE;
	for my $i (0..@base-1) {
		$hash{$base[$i]} = $i;
	}

	my @based = split "", $input; # bad variable name
	my $max = @based - 1;
	my $output;
	# TODO: A for loop would probably be more clear at this point.
	while ($max >= 0) {
		$output += ( @base ** $max ) * $hash{@based[@based - $max - 1]};
		$max--;
	}
	return $output;
}
