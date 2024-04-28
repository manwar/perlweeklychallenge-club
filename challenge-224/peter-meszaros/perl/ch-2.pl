#!/usr/bin/env perl
#
=head1 Task 2: Additive Number

You are given a string containing digits 0-9 only.

Write a script to find out if the given string is additive number. An additive
number is a string whose digits can form an additive sequence.

	A valid additive sequence should contain at least 3 numbers. Except the
	first 2 numbers, each subsequent number in the sequence must be the sum of the
	preceding two.

=head2 Example 1:

Input: $string = "112358"
Output: true

The additive sequence can be created using the given string digits: 1,1,2,3,5,8
1 + 1 => 2
1 + 2 => 3
2 + 3 => 5
3 + 5 => 8

=head2 Example 2:

Input: $string = "12345"
Output: false

No additive sequence can be created using the given string digits.

=head2 Example 3:

Input: $string = "199100199"
Output: true

The additive sequence can be created using the given string digits: 1,99,100,199
 1 +  99 => 100
99 + 100 => 199

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use Algorithm::Combinatorics qw/partitions/;

my $cases = [
	["112358",    1],
	["12345",     0],
	["199100199", 1],
];

sub additive_number
{
	my $n = shift;

    my @n = split '', $n;
    my $iter = partitions(\@n);
    while (my $p = $iter->next) {
        my @l = map { join('', @$_) } @$p;
        my @seq;
        for my $i (1..($#l-1)) {
            if (($l[$i-1] + $l[$i]) == $l[$i+1]) {
                push @seq, $l[$i];
                return 1 if @seq >= 2;
            } else {
                undef @seq;
            }
        }
    }
    return 0;
}

for (@$cases) {
    is(additive_number($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

