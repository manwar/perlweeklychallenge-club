#!/usr/bin/env perl
#
=head1 Task 1: Special Bit Characters

Submitted by: Mohammad S Anwar

You are given an array of binary bits that ends with 0.

Valid sequences in the bit string are:

	[0] -decodes-to-> "a"
	[1, 0] -> "b"
	[1, 1] -> "c"

Write a script to print 1 if the last character is an "a" otherwise print 0.

=head2 Example 1

	Input: @bits = (1, 0, 0)
	Output: 1

	The given array bits can be decoded as 2-bits character (10) followed by 1-bit
	character (0).

=head2 Example 2

	Input: @bits = (1, 1, 1, 0)
	Output: 0

	Possible decode can be 2-bits character (11) followed by 2-bits character (10)
	i.e. the last character is not 1-bit character.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[[1, 0, 0],       1, 'Example 1'],
	[[1, 1, 1, 0],    0, 'Example 2'],
	[[1, 1, 0, 1, 0], 0, 'Example 3'],
];

sub special_bit_characters
{
    my $l = shift;

    my @l = split /(10|11)/, join('', @$l);
    return ($l[-1] == 0) ? 1 : 0;
}

for (@$cases) {
    is(special_bit_characters($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
