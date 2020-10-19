#!/usr/bin/perl

use Test2::V0;
use Benchmark 'cmpthese';

# Test if $C is interleaved from $A and $B. The strings must not contain
# newlines.
sub interleaved {
	my ($A, $B, $C) = @_;

	# Combine newline joined input strings into default argument.
	local $_ = "$C\n$A\n$B";

	# More than two newlines signify invalid input data.
	die 'input data must not contain newline' if (() = /\n/g) > 2;

	my $len = length $C;

	# Partition $C into $num nonempty parts.
	for my $num (2 .. $len) {
		# maximum length of each part
		my $lmax = $len - $num + 1;

		# quantifier: non-greedy sequence up to length $lmax or
		# none for a single character.
		my $quant = $lmax > 1 ? "{1,$lmax}?" : '';

		# regex that matches every possible decomposition into
		# $num nonempty substrings capturing all parts.
		my $decomp = "(.$quant)" x $num;

		# regexes that match the concatenation of all odd / even numbered
		# captured groups.
		my ($odd, $even);
		$odd .= "\\g{$_}" for grep $_ % 2 == 1, 1 .. $num;
		$even .= "\\g{$_}" for grep $_ % 2 == 0, 2 .. $num;

		# The finally constructed regex matches if $C, partioned into
		# $num parts, is interleaved from $A and $B, where $C, $A and $B
		# are joined together with newlines.  As the strings don't
		# contain newlines and "dot" doesn't match newline, this is
		# safe.  The efford grows exponentially with the number of
		# interleaved parts or, if $C is not interleaved from $A and $B,
		# the length of $C.  For longer strings a different approach
		# would be required.

		return 1 if /^$decomp\n(?:$odd\n$even|$even\n$odd)\z/;
	}

	0;
}

ok dies {interleaved '', '', "\n"}, 'sanity check fails';
ok interleaved('XY', 'X', 'XXY'), 'first example';
ok interleaved('XXY', 'XXZ', 'XXXXYZ'), 'second example';
ok ! interleaved('YX', 'X', 'XXY'), 'third example';
ok interleaved('ABCD', '123', 'A1B2C3D'), 'zipper 1';
ok interleaved('ABC', '1234', '1A2B3C4'), 'zipper 2';
ok interleaved('AAACCC', 'BBB', 'AAABBBCCC'), 'blockwise';

SKIP: {
	skip 'optional benchmark', 3;

	# Heavy increase with additional interleaved parts.
	cmpthese 1, {
		18 => sub {ok interleaved('X' x 9, 'Y' x 9, 'XY' x 9)},
		19 => sub {ok interleaved('X' x 10, 'Y' x 9, 'XY' x 9 . 'X')},
		20 => sub {ok interleaved('X' x 10, 'Y' x 10, 'XY' x 10)}
	};

	#      Rate   20   19   18
	# 20 1.67/s   -- -50% -77%
	# 19 3.33/s 100%   -- -53%
	# 18 7.14/s 329% 114%   --
}

done_testing;
