#!/usr/bin/raku
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

my Str:D @TEST_NUMBERS = '1', 'a', '.', '1.2e4.2', '-1.', '+1E-8', '.44';

grammar ValidNumber
{
	token TOP { <mantissa> <exponent>? };

	token mantissa { <large-number> | <small-number> };
	token exponent { <[Ee]> <int-sign>? <int-digit>+ }

	token large-number { <int-sign>? <int-digit>+ <large-fractional-part>? };
	token large-fractional-part { <[.]> <int-digit>* }
	token small-number { <[.]> <int-digit>+ }

	token int-sign { <[+-]> };
	token int-digit { <[0 .. 9]> };
}

sub valid-number(Str:D $str) returns Str:D
{
	my $parsed = try ValidNumber.parse($str);
	!$! && $parsed.defined ?? 'true' !! 'false'
}

{
	if (%*ENV{'PWC_FROM_STDIN'} // '') eq '1' {
		my $line = $*IN.get;
		say valid-number $line;
	} else {
        	for @TEST_NUMBERS {
        		say valid-number $^str;
        	}
	}
}
