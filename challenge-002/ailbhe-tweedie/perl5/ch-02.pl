#!/usr/bin/env perl
#
# Solution to challenge #2 of the Perl Weekly Challenge 002.
#
# Task: Write a script that can convert integers to and from a base35
# representation, using the characters 0-9 and A-Y. 
#
# Prerequisites: cpan install Scalar::Util::Numeric
#
# Usage: echo {0.999} | ./ch-02.pl

use strict;
use warnings;
use Scalar::Util::Numeric qw(isint);
use Data::Dump;

my $BASE = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXY";

# TODO: add command-line switch to pick between converting TO and FROM

while (<>) {
	chomp;
	# TODO: find out how to stream input, instead of saving it to an array first
	my @input = split;
	for my $i (@input) {
		next unless isint $i;
		my $output = toBase35($i);
		printf "%-4s\t==>\t%-4s\n", $i, $output;
	}
}

sub toBase35 {
	my $input = shift;
	my @base = split "", $BASE;
	my @convert;
	my $baseNum = @base;
	my $max = 0;
	while (1) {
		last unless $baseNum ** ++$max <= $input;
	}
	while ($max > 0) {
		my $exp = $max - 1;
		#print "$baseNum to the $exp is ", $baseNum ** $exp, " which is smaller than $input\n";
		my $pow = $baseNum ** $exp;
		my $place = 0;
		while ($pow <= $input) {
			$input -= $pow;
			$place++;
			#print "input $input; place $place\n";
		}
		push @convert, $place;
		$max--;
	}
	#print "@convert: ";
	#dd @convert;
	#print "\n";
	my $output = join "", @base[@convert];
}
