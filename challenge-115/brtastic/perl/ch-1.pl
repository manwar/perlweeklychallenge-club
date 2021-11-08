use v5.34;
use warnings;

use Algorithm::Permute;
use List::Util qw(zip all);

sub comes_after
{
	my ($previous, $next) = @_;

	return substr($previous, -1) eq substr($next, 0, 1);
}

sub check_string_chain
{
	my @string_list = @_;

	my $iterator = Algorithm::Permute->new(\@string_list);

	while (my @case = $iterator->next) {
		my @to_compare = @case;
		push @to_compare, shift @to_compare;

		return 1 if all {
			comes_after $_->@*
		} zip \@case, \@to_compare;
	}

	return 0;
}

use Test::More;

is check_string_chain(qw<abc dea cd>), 1;
is check_string_chain(qw<ade cbd fgh>), 0;
is check_string_chain(qw<ab bc cd de ef fg gh hi ia>), 1;
is check_string_chain(qw<ab bc cd de ef fg gh hi>), 0;
is check_string_chain(qw<bc cd de ef fg gh hi ia>), 0;

done_testing;
