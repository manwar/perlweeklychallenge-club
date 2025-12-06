#!/usr/bin/env perl
#
=head1 Task 2: Shuffle Pairs

Submitted by: E. Choroba

If two integers A <= B have the same digits but in different orders, we say
that they belong to the same shuffle pair if and only if there is an integer k
such that B = A * k where k is called the witness of the pair.

For example, 1359 and 9513 belong to the same shuffle pair, because 1359 * 7 =
9513.

Interestingly, some integers belong to several different shuffle pairs. For
example, 123876 forms one shuffle pair with 371628, and another with 867132, as
123876 * 3 = 371628, and 123876 * 7 = 867132.

Write a function that for a given $from, $to, and $count returns the number of
integers $i in the range $from <= $i <= $to that belong to at least $count
different shuffle pairs.

PS: Inspired by a conversation between Mark Dominus and Simon Tatham at
Mastodon.

=head2 Example 1

    Input: $from = 1, $to = 1000, $count = 1
    Output: 0

    There are no shuffle pairs with elements less than 1000.

=head2 Example 2

    Input: $from = 1500, $to = 2500, $count = 1
    Output: 3

    There are 3 integers between 1500 and 2500 that belong to shuffle pairs.

    1782, the other element is 7128 (witness 4)
    2178, the other element is 8712 (witness 4)
    2475, the other element is 7425 (witness 3)

=head2 Example 3

    Input: $from = 1_000_000, $to = 1_500_000, $count = 5
    Output: 2

    There are 2 integers in the given range that belong to 5 different shuffle
    pairs.

    1428570 pairs with 2857140, 4285710, 5714280, 7142850, and 8571420
    1429857 pairs with 2859714, 4289571, 5719428, 7149285, and 8579142

    The witnesses are 2, 3, 4, 5, and 6 for both the integers.

=head2 Example 4

    Input: $from = 13_427_000, $to = 14_100_000, $count = 2
    Output: 11

    6 integers in the given range belong to 3 different shuffle pairs, 5
    integers belong to 2 different ones.

=head2 Example 5

    Input: $from = 1030, $to = 1130, $count = 1
    Output: 2

    There are 2 integers between 1020 and 1120 that belong to at least one
    shuffle pair:
    1035, the other element is 3105 (witness k = 3)
    1089, the other element is 9801 (witness k = 9)

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[          1,       1000, 1],  0, "Example 1"],
    [[       1500,       2500, 1],  3, "Example 2"],
    [[  1_000_000,  1_500_000, 5],  2, "Example 3"],
    [[ 13_427_000, 14_100_000, 2], 11, "Example 4"],
    [[       1030,       1130, 1],  2, "Example 5"],
];

sub shuffle_pairs
{
    my $fm    = $_[0]->[0];
    my $to    = $_[0]->[1];
    my $count = $_[0]->[2];
    my %pairs;

    for my $i ($fm .. $to) {
        my $sorted = join '', sort split //, $i;
        for my $k (2 .. 9) {
            my $j = $i * $k;
            last if length($j) > length($i);
            my $sorted_j = join '', sort split //, $j;
            if ($sorted eq $sorted_j) {
                $pairs{$i}{$k} = true;
            }
        }
    }

    my $result = 0;
    for my $i (keys %pairs) {
        if (keys %{$pairs{$i}} >= $count) {
            $result++;
        }
    }

    return $result;
}

for (@$cases) {
    is(shuffle_pairs($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
