#!/usr/bin/env perl
#
=head1 Task 1: Shuffle String

You are given a string and an array of indices of same length as string.

Write a script to return the string after re-arranging the indices in the
correct order.

=head2 Example 1

    Input: $string = 'lacelengh', @indices = (3,2,0,5,4,8,6,7,1)
    Output: 'challenge'

=head2 Example 2

    Input: $string = 'rulepark', @indices = (4,7,3,1,0,5,2,6)
    Output: 'perlraku'

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[['lacelengh', [3,2,0,5,4,8,6,7,1]], 'challenge'],
	[['rulepark',  [4,7,3,1,0,5,2,6]],   'perlraku'],
];

sub shuffle_string
{
	my $str = $_[0]->[0];
	my $arr = $_[0]->[1];

	my @str = split '', $str;

    my @res;
    @res[@$arr] = @str;

	return join '', @res;
}

for (@$cases) {
    is(shuffle_string($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
