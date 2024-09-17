#!/usr/bin/perl
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use v5.16;
use strict;
use warnings;

use List::Util qw(min max pairs);

use constant PWC_QUIET => ($ENV{PWC_QUIET} // '') eq 1;

my @TEST_STRINGS = (
	'1',
	'a',
	'.',
	'1.2e4.2',
	'-1.',
	'+1E-8',
	'.44',
);

my $re_valid_number = qr{
	^
	# There may or may not be a sign
	[+-]?

	# The first part is...
	(?:
		(?:
			# ...either a number that starts with some digits...
			[0-9]+
			# ...possibly followed by a decimal point and some more digits...
			(?: \. [0-9]* )?
		)
		|
		(?:
			# ...or a decimal point necessarily followed by some digits.
			\. [0-9]+
		)
	)

	# And then there may be an exponent.
	(?: [Ee] [+-]? [0-9]+ )?
	$
}x;

sub diag($) {
	say STDERR $_[0] unless PWC_QUIET;
}

sub valid_number($)
{
	my ($str) = @_;

	($str =~ /$re_valid_number/) ? 'true' : 'false'
}

sub parse_stdin()
{
	my $line = <STDIN>;
	if (!defined $line) {
		die "Could not read an expression on a line from the standard input\n";
	}
	chomp $line;
	$line
}

MAIN:
{
	if (($ENV{PWC_FROM_STDIN} // '') eq '1') {
		my $str = parse_stdin;
		say valid_number $str;
	} else {
		for my $str (@TEST_STRINGS) {
			say valid_number $str;
		}
	}
}
