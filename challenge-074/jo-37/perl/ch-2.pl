#!/usr/bin/perl

use v5.16;
use Test2::V0;
use warnings FATAL => 'all';

use List::Util qw(first);

# The description of the task and the given examples are - to my
# understanding - not consistent.
# 
# "Write a script to print the series of first non-repeating character
# (left -> right) for the given string."
#
# Input: $S = 'ababc'
# Output: 'abb#c'
# Pass 1: "a", the FNR character is 'a'
# Pass 2: "ab", the FNR character is 'b'
#
# The characters chosen in the examples are apparently the "first
# non-repeating character (right -> left). I'd rather call this
# the "last non-repeating" character (LNR).
#
# Maybe this little ambiguity is intentional.  At least it adds a nice
# new aspect.  So this sub provides both variants.

sub nr_char {
	my @arr = split //, shift;
	# mode: fnr or lnr
	my $lnr = shift;
	my (%freq, @head);

	join '', map {
		# While traversing the input string character-wise,
		# count frequencies and collect the (reversed) head.
		$freq{$_}++;

		# Emulate unshift (lnr, reversed) or push (fnr, forward)
		# to augment the head.
		splice @head, $lnr ? 0 : @head, 0, $_;

		# The first singleton character from the (reversed) head
		# is the requested output character.
		(first {$freq{$_} == 1} @head) // '#';
	} @arr;
}

is nr_char('ababc', 1), 'abb#c', 'first example, lnr';
is nr_char('xyzzyx', 1), 'xyzyx#', 'second example, lnr';
is nr_char('ababc'), 'aab#c', 'first example, fnr';
is nr_char('xyzzyx'), 'xxxxx#', 'second example, fnr';

done_testing;
