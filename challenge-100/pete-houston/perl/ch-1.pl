#!/usr/bin/env perl
#===============================================================================
#
#         FILE: 10001.pl
#
#        USAGE: ./10001.pl [ STRING ]
#
#  DESCRIPTION: Analyses input to determine if it is 12 or 24 hour clock
#               and converts to the other. Runs tests if no argument.
#
# REQUIREMENTS: Test::More for the test suite.
#        NOTES: The leading zero pad comes from the spec examples.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 15/02/21
#===============================================================================

use strict;
use warnings;
use Test::More;

if (0 < @ARGV) {
	print clockit($ARGV[0]) . "\n";
	exit;
}

sub clockit {
	my $in = shift;
	my ($h, $m, $i) = $in =~ /(\d{2})(:\d{2})(\s?[ap]m)?/i;
	if ($i) {
		# 12 to 24
		if ($i =~ /am/i) {
			$h = '00' if $h eq '12';
		} elsif ($h < 12) {
			$h += 12;
		}
		return "$h$m";
	} else {
		# 24 to 12
		$i = $h > 11 ? 'pm' : 'am';
		$h %= 12 if $h > 12;
		$h = '12' if $h eq '00';
		# Spec (examples) show padded leading zero
		return sprintf "%2.2i$m$i", $h;
	}
}

my @tests = (
	{ in => '05:15 pm', out => '17:15'   },
	{ in => '05:15pm',  out => '17:15'   },
	{ in => '05:15am',  out => '05:15'   },
	{ in => '12:15am',  out => '00:15'   },
	{ in => '12:15pm',  out => '12:15'   },
	{ in => '00:15',    out => '12:15am' },
	{ in => '05:59',    out => '05:59am' },
	{ in => '12:15',    out => '12:15pm' },
	{ in => '13:42',    out => '01:42pm' },
);

plan tests => scalar @tests;

for my $t (@tests) {
	is clockit($t->{in}), $t->{out}, "$t->{in} becomes $t->{out}";
}
