#!/usr/bin/perl

use Test2::V0;
use List::Util qw(min max);

# Caution! The following is a bit weird.
#
# After finishing task #1 I realized that my solution
# was very similar to that for task #1 of challenge 065.  So similar
# that it called for something common. (At the end I realized that
# task #2 might be solved alike.)
#
# All three have in common, that they require building a list of
# strings or arrays having a fixed length and following some given
# rules that can be applied recursively.
# They can be solved with one and the same approach:
# - Evaluate all possible leading items for a given length.
# - For each leading value, combine this value with all possible
#   continuations.  These continuations are found by recursing
#   into the same procedure with a decremented length and modified
#   parameters according to the specific task.
# - For the last item in each array there is an explicit solution
#   that breaks the recursion.
#
# An array generator for a specific task can be created by suitable
# parametrization. That is:
# - a subroutine that returns all possible leading items for the given
#   length.
# - a subroutine that transforms the parameters for the call
#   with a decremented length.
# - a subroutine that checks the validity of the given length and
#   parameters (optional).
#
#
# arraygenerator - recursive array generator factory
#
# options:
# single => subref returning a list of all possible single elements
# 			at the first position for given length and parameters
# step => subref returning new parameters for recursion to length - 1
# check => subref performing a validity check (optional)
#
# "single" and "check" subs are called with variables $a set to current
# length and $b to a ref to current parameters where $a is aliased
# to $length within "check".
# Additionally $_ is set to the current leading item for the "step"
# sub.
#
# The generated subroutine has to be called with two arguments:
# - desired length
# - a hashref containing parameters specific to the task as 
#   expected by the subrefs given to the factory.

sub arraygenerator {
	my %opts = @_;
	$opts{check} //= sub {1};

	my $genarray;
	$genarray = sub {
		my ($length, $parms) = @_;
		die 'check failed' unless do {
			local (*a, $b) = (\$length, $parms);
			$opts{check}->();
		};
		die 'length too short' if $length < 1;

		return [map [$_],
			do {local ($a, $b) = (1, $parms);
				$opts{single}->()}] if $length == 1;
		
		[map {
			my $leading = $_;
			map [$leading, @$_], @{$genarray->($length - 1,
				do {local ($a, $b, $_) = ($length, $parms, $leading);
				$opts{step}->()})};
		} do {local ($a, $b) = ($length, $parms);
			$opts{single}->()}];
	};
}

# Interpolate arrays to strings
$" = '';

# challenge 067 task 1: sorted number combinations
# numbers are in the range $from .. ($to - $length + 1) at all positions
# on recursion: $from = $leading + 1
# parms: from (optional, defaults to 1), to
my $ch067_1 = arraygenerator(
	single => sub {
		($b->{from} // 1 .. $b->{to} - $a + 1);
	},
	step => sub {
		{from => $_ + 1, to => $b->{to}};
	},
	check => sub {
		$b->{to} - ($b->{from} // 1) + 1 >= $a &&
		($b->{from} // 1) <= $b->{to};
	}
);

is $ch067_1->(2, {to => 5}),
	[[1,2], [1,3], [1,4], [1,5], [2,3], [2,4], [2,5], [3,4], [3,5], [4,5]],
	'challenge 067 task 1 - original';

is $ch067_1->(3, {to => 4}),
	[[1, 2, 3], [1, 2, 4], [1, 3, 4], [2, 3, 4]],
	'challenge 067 task 1 - other';

# challenge 065 task 1: digit sum
# first digit in range max(1, sum - maxsum) .. min(9, sum)
# following digits in range max(0, sum - maxsum) .. min(9, sum)
# (maxsum is the maximum possible sum for a given length)
# on recursion: sum = sum - digit
# parms: sum, zero_permitted (on recursion)
my $ch065_1 = arraygenerator(
	single => sub {
		(max(!$b->{zero_permitted}, $b->{sum} - 9 * ($a - 1))
		..
		min(9, $b->{sum}));
	},
	step => sub {
		{sum => $b->{sum} - $_, zero_permitted => 1};
	},
	check => sub {
		$b->{sum} <= 9 * $a;
	}
);

is [map "@$_", @{$ch065_1->(2, {sum => 4})}],
	[13, 22, 31, 40],
	'challenge 065 task 1 - original';

is [map "@$_", @{$ch065_1->(4, {sum => 3})}],
	[1002, 1011, 1020, 1101, 1110, 1200, 2001, 2010, 2100, 3000],
	'challenge 065 task 1 - other';
					
# challenge 067 task 2: letter phone
my %letters = (1 => ['_', ',', '@'], 2 => [qw(a b c)], 3 => [qw(d e f)],
			   4 => [qw(g h i)], 5 => [qw(j k l)], 6 => [qw(m n o)],
			   7 => [qw(p q r s)], 8 => [qw(t u v)], 9 => [qw(w x y z)]);

# character at any position: letters according to first digit of
# dial number
# on recursion: strip first character from dial number 
# parms: number
# (The length will be set from within "check"!)
#
# Using the generated sub for this task is very inefficient, because
# any trailing part is completely independend from the leading part and
# thus recursion is not required at all.
# See ch-2.pl for a better approach.
my $ch067_2 = arraygenerator(
	single => sub {
		@{$letters{substr $b->{number}, 0, 1}};
	},
	step => sub {
		{number => substr($b->{number}, 1)};
	},
	check => sub {$a = length $b->{number}}
);

is [map "@$_", @{$ch067_2->(0, {number => 35})}],
	['dj', 'dk', 'dl', 'ej', 'ek', 'el', 'fj', 'fk', 'fl'],
	'challenge 067 task 2 - original';

ok grep(/^weekly_pl$/, map "@$_", @{$ch067_2->(0, {number => 933559175})}),
	'challenge 067 task 2 - other';

done_testing;
