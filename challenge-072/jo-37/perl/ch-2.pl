#!/usr/bin/perl -T

use strict;
use warnings;

sub print_range {
	my $file = shift;
	my ($A) = shift =~ /^(\d+)/;
	my ($B) = shift =~ /^(\d+)/;

	return if !$file || $A < 1 || $B < $A;

	open my $fh, '<', $file or die "$file: $!\n";
	eval <<EOS;
	while (<\$fh>) {
		print if $A .. $B;
	}
EOS
	die $@ if $@;
	close $fh or warn "$file: $!\n";
}

if (@ARGV) {
	print_range @ARGV;
} else {
	print_range 'ch-2.in', 3, 5;
}
