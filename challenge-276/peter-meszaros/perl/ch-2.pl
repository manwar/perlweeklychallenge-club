#!/usr/bin/env perl
#
=head1 Task 2: Maximum Frequency

You are given an array of positive integers, @ints.

Write a script to return the total number of elements in the given array which
have the highest frequency.

=head2 Example 1

	Input: @ints = (1, 2, 2, 4, 1, 5)
	Ouput: 4

	The maximum frequency is 2.
	The elements 1 and 2 has the maximum frequency.

=head2 Example 2

	Input: @ints = (1, 2, 3, 4, 5)
	Ouput: 5

	The maximum frequency is 1.
	The elements 1, 2, 3, 4 and 5 has the maximum frequency.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[[1, 2, 2, 4, 1, 5], 4, 'Example 1'],
	[[1, 2, 3, 4, 5],    5, 'Example 2'],
];

sub maximum_frequency
{
	my $l = shift;

    my %h;

    $h{$_}++ for @$l;
	my @l = sort {$h{$b} <=> $h{$a}} keys %h;

	my $freq = $h{$l[0]};

	my $n;
	for my $i (@l) {
        if ($h{$i} == $freq) {
            $n += $freq;
        } else {
            last;
        }
	}

	return $n;
}

for (@$cases) {
    is(maximum_frequency($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

