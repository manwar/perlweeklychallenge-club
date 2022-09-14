#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub challenge_182_2 {
	my ($paths) = @_;

	my $length;
	my @common_parts;

	my $trailing_slash = qr:(?<=.)/$:;

	for my $path (@$paths) {
		$path =~ s/$trailing_slash//;
		my @parts = split qr:(?<=/):, $path;

		unless (defined $length) {
			@common_parts = @parts;
			$length = $#common_parts;
			next;
		}

		$length = $#parts
			if $length > $#parts;

		for my $i (reverse 0 .. $length) {
			--$length
				unless $common_parts[$i] eq $parts[$i];
		}
	}

	return ''
		unless defined $length;

	$common_parts[$length] =~ s/$trailing_slash//;

	join '', @common_parts[0 .. $length];
}

