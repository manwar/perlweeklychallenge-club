use v5.30;
use warnings;

# the solution is based on my own module Quantum::Superpositions::Lazy from CPAN
use Quantum::Superpositions::Lazy;

sub get_majority
{
	# a superposition will automate all the counting for us
	my $list = superpos(@_);

	# superpositions have a built in statistics module
	my $majority = $list->stats->most_probable;

	# majority is actually a new superposition, it can have multiple states
	return -1 if $majority->states->@* != 1;

	# we now know that this element is certainly a majority, but does it have a proper weight?
	my $state = $majority->states->[0];
	return $state->weight > 0.5 ? $state->value : -1;
}

use Test::More;

is get_majority(1, 1, 1, 2), 1;
is get_majority(1, 1, 2, 2), -1;
is get_majority(1, 1, 2, 2, 2), 2;
is get_majority(1, 2, 3, 4), -1;
is get_majority(6), 6;

done_testing;
