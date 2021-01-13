use v5.30;
use warnings;
use List::Util qw(first);

# the solution is based on my own module Quantum::Superpositions::Lazy from CPAN
use Quantum::Superpositions::Lazy;

sub first_non_repeating
{
	my sub find_fnt
	{
		my @split = split "", shift;

		# a superposition will automate some of the counting for us
		my $split_pos = superpos(@split);

		# the default weight for an element is 1, and weights are merged by values
		my @non_repeating = grep { $_->weight == 1 } $split_pos->states->@*;

		return "#" if @non_repeating == 0;
		return (shift @non_repeating)->value if @non_repeating == 1;

		# since we have a couple of non-repeating characters, we get the first one
		# (the superposition here helps so that we solve this by a simple eq)
		my $alternatives = superpos(@non_repeating);
		return first { $_ eq $alternatives } @split;
	}

	my ($string) = @_;
	my $result = "";
	for (1 .. length $string) {
		$result .= find_fnt(substr $string, 0, $_);
	}
	return $result;
}

use Test::More;

is first_non_repeating("ababc"), "aab#c";
is first_non_repeating("xyzzyx"), "xxxxx#";
is first_non_repeating("geeksforgeeksandgeeksquizfor"), "ggggggggkkksfffffffffffffora";

done_testing;
