use v5.30;
use warnings;

# the solution is based on my own module Quantum::Superpositions::Lazy from CPAN
use Quantum::Superpositions::Lazy;

sub get_majority
{
	# a superposition will automate all the counting for us
	my $list = superpos(@_);

	# superpositions have a built in statistics module
	# the result of most_probable is actually a new superposition, it can have multiple states
	my ($state) = $list->stats->most_probable->states->@*;

	# we now know that this element is certainly most frequent, but does it have proper weight?
	return $state->weight > 0.5 ? $state->value : -1;
}

use Test::More;

is get_majority(1, 1, 1, 2), 1;
is get_majority(1, 1, 2, 2), -1;
is get_majority(1, 1, 2, 2, 2), 2;
is get_majority(1, 2, 3, 4), -1;
is get_majority(6), 6;

done_testing;
