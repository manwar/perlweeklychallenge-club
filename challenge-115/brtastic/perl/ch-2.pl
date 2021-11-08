use v5.34;
use warnings;

use List::Util qw(first);

sub largest_multiple
{
	my @digits = @_;

	my @sorted_asc = sort { $a <=> $b } @digits;
	my $smallest_index = first { $sorted_asc[$_] % 2 == 0 } keys @sorted_asc;

	die 'no result divisible by 2 can be achieved'
		unless defined $smallest_index;

	my $smallest = splice @sorted_asc, $smallest_index, 1;
	return join '', reverse(@sorted_asc), $smallest;

}

use Test::More;

is largest_multiple(1, 0, 2, 6), 6210;
is largest_multiple(1, 4, 2, 8), 8412;
is largest_multiple(4, 1, 7, 6), 7614;
is largest_multiple(1, 2, 3, 4, 5, 6, 7, 8, 9, 0), 9876543210;

# this will throw
eval {
	largest_multiple(1, 1, 1, 1, 3);
	fail;
};

done_testing;
