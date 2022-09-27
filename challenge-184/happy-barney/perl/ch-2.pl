#!/usr/bin/env perl

use strict;
use warnings;

sub challenge_184_2 {
	my (@strings) = @_;

	my (@numbers, @letters);

	my $re_numbers = qr/[0-9]/;
	my $re_letters = qr/[a-z]/;

	for my $string (@strings) {
		push @numbers, split qr/ +/, $string =~ s/$re_letters ?//gr;
		push @letters, split qr/ +/, $string =~ s/$re_numbers ?//gr;
	}

	return (\@numbers, \@letters);
}

