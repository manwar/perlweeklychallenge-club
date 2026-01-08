#!/usr/bin/perl -w

use strict;
use feature 'say';
use Test::More tests => 5;

# Note that the ',' is the thousand separator in the English language,
# but many other languages use other separators, like '.', ' ' or "'".
sub english_thousand_separator {
	local($_) = @_;
	s#(\d+)(\d{3})$#english_thousand_separator($1) . ",$2"#e;
	return $_;
}

is(english_thousand_separator(123), "123", "Example 1");
is(english_thousand_separator(1234), "1,234", "Example 2");
is(english_thousand_separator(1000000), "1,000,000", "Example 3");
is(english_thousand_separator(1), "1", "Example 4");
is(english_thousand_separator(12345), "12,345", "Example 5");
done_testing();

