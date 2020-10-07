#!/usr/bin/perl

use Test2::V0;

# Find common base strings in two given strings.
sub cbs {

	# Combine both strings by joining them with a newline.
	# The strings must not contain newlines.
	local $_ = shift . "\n" . shift;

	# Collect all common base strings.
	# Note: "dot" does not match a newline here.
	my @base;
	m{
		^ (.+?) \1*+ \n \1++ \z	# capture base string for both
		(?{push @base, $1})		# collect captured base string
		(*FAIL)					# force backtracking
	}x;

	@base;
}

is [cbs("abcdabcd", "abcdabcdabcdabcd")], ["abcd", "abcdabcd"],
	"first example";

is [cbs("aaa", "aa")], ["a"], "second example";

is [cbs("abcabc", "abcdabcdabcd")], [], "no common base strings";

done_testing;
