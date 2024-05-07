#!/usr/bin/env perl
#
=head1 Task 2: Two out of Three

You are given three array of integers.

Write a script to return all the elements that are present in at least 2 out of
3 given arrays.

=head2 Example 1

Input: @array1 = (1, 1, 2, 4)
       @array2 = (2, 4)
       @array3 = (4)

Ouput: (2, 4)

=head2 Example 2

Input: @array1 = (4, 1)
       @array2 = (2, 4)
       @array3 = (1, 2)

Ouput: (1, 2, 4)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[[[1, 1, 2, 4], [2, 4], [4]   ], [2, 4]],
	[[[4, 1],       [2, 4], [1, 2]], [1, 2, 4]],
];

sub two_out_of_three
{
	my $ls = $_[0];

	my %h;
	my $n = 0;
	for my $l (@$ls) {
		$h{$_}->[$n] = 1 for @$l;
		++$n;
	}

	my @res;
	for my $k (keys %h) {
		my $n;
		$n += ($_ // 0) for $h{$k}->@*;
		push @res, $k if $n >= 2;
	}
	@res = sort {$a <=> $b} @res;
	return \@res;
}

for (@$cases) {
    is(two_out_of_three($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

