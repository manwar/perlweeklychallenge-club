#!/usr/bin/env perl
#
=head1 Task 2: Sort by 1 bits

You are give an array of integers, @ints.

Write a script to sort the integers in ascending order by the number of 1 bits
in their binary representation. In case more than one integers have the same
number of 1 bits then sort them in ascending order.

=head2 Example 1

	Input: @ints = (0, 1, 2, 3, 4, 5, 6, 7, 8)
	Output: (0, 1, 2, 4, 8, 3, 5, 6, 7)

	0 = 0 one bits
	1 = 1 one bits
	2 = 1 one bits
	4 = 1 one bits
	8 = 1 one bits
	3 = 2 one bits
	5 = 2 one bits
	6 = 2 one bits
	7 = 3 one bits

=head2 Example 2

	Input: @ints = (1024, 512, 256, 128, 64)
	Output: (64, 128, 256, 512, 1024)

All integers in the given array have one 1-bits, so just sort them in ascending
order.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/sum0/;

my $cases = [
	[[0, 1, 2, 3, 4, 5, 6, 7, 8], [0, 1, 2, 4, 8, 3, 5, 6, 7]],
	[[1024, 512, 256, 128, 64],   [64, 128, 256, 512, 1024]],
];

sub sort_by_1_bits
{
    my $l = shift;

    my @v;
    for my $i (0.. $#$l) {
        my $binstr = unpack("B32", pack("N", $l->[$i]));
        $binstr =~ s/^0+(?=[0-9])//;
        $v[$i] = sum0(split(//, $binstr));
    }

    my @l = sort { if ($v[$a] == $v[$b]) {
                    return $l->[$a] <=> $l->[$b]
                   } else {
                    return $v[$a] <=> $v[$b]
                   }} 0 .. $#$l;

    return [$l->@[@l]];
}

for (@$cases) {
    is(sort_by_1_bits($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

