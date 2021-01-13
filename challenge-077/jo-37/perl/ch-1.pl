#!/usr/bin/perl

use Test2::V0;
use Algorithm::Combinatorics 'combinations';
use List::Util 'sum';
use List::MoreUtils qw(before bsearch);

{
	# Caching:

	# @fib has all fibonacci numbers calculated so far.
	my @fib;

	# $sa and $sb hold the starting values to continue the sequence.
	my $sa = 1;
	my $sb = 1;

	# @sum has the partial sums of calculated fibonacci numbers.
	my @sum = (0);


	# Check if $n is a fibonacci number.  Afterwards all fibonacci
	# numbers up to the smallest not less than $n are known.
	sub is_fib {
		my $n = shift;

		# Return result from cache if applicable for $n.
		return bsearch {$_ <=> $n} @fib if $n <= $sa;

		# Otherwise continue the sequence until $n is exceeded.
		for (my ($fa, $fb) = ($sa, $sb);
				$fa <= $n;
				($fa, $fb) = ($fb, $fa + $fb)) {

			# Cache intermediate results.
			push @fib, $fb;

			# Record next starting point.
			($sa, $sb) = ($fb, $fa + $fb);

			# Augment partial sums.
			push @sum, $sum[$#sum] + $fb;

			return 1 if $fb == $n;
		}

		undef;
	}

	# Return the sequence of fibonacci numbers not larger than $n from
	# the cache.
	sub fib_seq {
		my $n = shift;
		die "cache limit: $sa, requested: $n" if $n > $sa;

		before {$_ > $n} @fib;
	}

	# The smallest sum of l nonrepeated fibonacci numbers is the sum of
	# the first l fibonacci numbers.  This gives an upper limit for the
	# length of combinations to add up as n.
	sub lmax {
		my $n = shift;
		die "cache limit: $sa, requested: $n" if $n > $sa;

		my $lmax = 0;
		$lmax++ while $sum[$lmax + 1] <= $n;

		$lmax;
	}
}

# Get all possible summations of $n from nonrepeated fibonacci numbers.
sub fib_sum {
	my $n = shift;
	
	my @res;
	# Fill cache for use with $n and pre-handle combinations of length 1.
	push @res, [$n] if is_fib $n;

	# Get sequence from cache.
	my @fib = fib_seq $n - 1;

	# Try lengths to be considered.
	foreach my $l (2 .. lmax $n) {
		# Try all combinations of length $l
		my $it = combinations \@fib, $l;
		while (my $c = $it->next) {
			push @res, $c if sum(@$c) == $n;
		}
	}
	@res;
}

is [fib_sum(6)], [[1, 5], [1, 2, 3]], 'first example';
is [fib_sum(9)], [[1, 8], [1, 3, 5]], 'second example';
is [fib_sum(8)], [[8], [3, 5], [1, 2, 5]], 'fibonacci hit';
is is_fib(90), F(), 'check 90 and fill cache up to 144';
is [fib_seq(144)], meta {prop size => 11}, 'check cache for 144';
eval {fib_seq(145)};
is $@, T(), 'check cache miss';
is lmax(18), 4, 'check lmax below sum';
is lmax(19), 5, 'check lmax at sum';
is lmax(20), 5, 'check lmax above sum';

done_testing;
