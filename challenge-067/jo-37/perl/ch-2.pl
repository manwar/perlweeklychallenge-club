#!/usr/bin/perl

use Test2::V0;
use List::Util qw(reduce);

my %letters = (1 => ['_', ',', '@'], 2 => [qw(a b c)], 3 => [qw(d e f)],
			   4 => [qw(g h i)], 5 => [qw(j k l)], 6 => [qw(m n o)],
			   7 => [qw(p q r s)], 8 => [qw(t u v)], 9 => [qw(w x y z)]);

# Outer product of two arrays of strings:
# Concatenate every element of the left array with every element
# of the right array.
sub prod {
	my ($left, $right) = @_;

	[map {my $l = $_; map $l . $_, @$right} @$left];
}

# Build the outer product of all dial letters
sub dialstrings {
	reduce {prod $a, $letters{$b}} [''], split '', shift;
}

is dialstrings(35),
	["dj", "dk", "dl", "ej", "ek", "el", "fj", "fk", "fl"],
	'example from challenge';
ok grep(/^perl_weekly$/, @{dialstrings(73751933559)}), 'perl weekly';

done_testing;
