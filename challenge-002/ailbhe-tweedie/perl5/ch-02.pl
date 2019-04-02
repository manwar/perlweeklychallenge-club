#!/usr/bin/env perl
#
# Solution to challenge #2 of the Perl Weekly Challenge 002.
#
# Task: Write a script that can convert integers to and from a base35
# representation, using the characters 0-9 and A-Y. 
#
# Prerequisites: cpan install Scalar::Util::Numeric

use strict;
use warnings;
use Scalar::Util::Numeric qw(isint);
use Data::Dump;

my $BASE = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXY";

while (<>) {
	chomp;
	my $input = $_;
	next unless isint $input;
	my $output = convertToBase35($input);
	print "output: $output\n";
}

sub convertToBase35 {
	my $input = shift;
	my $orig = $input;
	my @base = split "", $BASE;
	my @convert;
	my $baseNum = @base;
	print "$baseNum\n";
	my $max = 0;
	while (1) {
		last unless $baseNum ** ++$max < $input;
	}
	while ($max > 0) {
		my $exp = $max - 1;
		print "$baseNum to the $exp is ", $baseNum ** $exp, " which is smaller than $input\n";
		my $pow = $baseNum ** $exp;
		my $place = 0;
		while ($pow <= $input) {
			$input -= $pow;
			$place++;
			print "$input; $place\n";
		}
		push @convert, $place;
		$max--;
	}
	dd @convert;
	foreach my $b (@base) {
		print "-$b-\n";
	}
	my $output = join "", @base[@convert];
}
