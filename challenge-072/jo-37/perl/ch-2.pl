#!/usr/bin/perl

use strict;
use warnings;

sub print_range {
	my ($file, $A, $B) = (shift, shift() + 0, shift() + 0);

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

print_range 'ch-2.in', 3, 5;
