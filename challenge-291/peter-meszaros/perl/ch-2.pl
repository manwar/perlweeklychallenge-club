#!/usr/bin/env perl
#
=head1 Task 2: Poker Hand Rankings

Submitted by: Robbie Hatley

A draw poker hand consists of 5 cards, drawn from a pack of 52: no jokers, no
wild cards. An ace can rank either high or low.

Write a script to determine the following three things:

    1. How many different 5-card hands can be dealt?

    2. How many different hands of each of the 10 ranks can be dealt?
       See here for descriptions of the 10 ranks of Poker hands:
       https://en.wikipedia.org/wiki/List_of_poker_hands#Hand-ranking_categories

    3. Check the ten numbers you get in step 2 by adding them together
       and showing that they're equal to the number you get in step 1.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use Algorithm::Combinatorics qw/combinations/;
use List::Util qw/max all/;

#$Data::Dumper::Sortkeys = 1;

my $cases = [
    [undef, 1, 'Example 1'],
];

#  https://eng.libretexts.org/Bookshelves/Computer_Science/Programming_and_Computation_Fundamentals/Mathematics_for_Computer_Science_(Lehman_Leighton_and_Meyer)/03%3A_Counting/14%3A_Cardinality_Rules/14.07%3A__Counting_Practice_-_Poker_Hands

my @deck = (
    [1,  1],
    [1,  2],
    [1,  3],
    [1,  4],
    [1,  5],
    [1,  6],
    [1,  7],
    [1,  8],
    [1,  9],
    [1, 10],
    [1, 11],
    [1, 12],
    [1, 13],
    [2,  1],
    [2,  2],
    [2,  3],
    [2,  4],
    [2,  5],
    [2,  6],
    [2,  7],
    [2,  8],
    [2,  9],
    [2, 10],
    [2, 11],
    [2, 12],
    [2, 13],
    [3,  1],
    [3,  2],
    [3,  3],
    [3,  4],
    [3,  5],
    [3,  6],
    [3,  7],
    [3,  8],
    [3,  9],
    [3, 10],
    [3, 11],
    [3, 12],
    [3, 13],
    [4,  1],
    [4,  2],
    [4,  3],
    [4,  4],
    [4,  5],
    [4,  6],
    [4,  7],
    [4,  8],
    [4,  9],
    [4, 10],
    [4, 11],
    [4, 12],
    [4, 13],
);

my $cat = {
    five_of_a_kind  => 0, #         0
    straight_flush  => 0, #        40
    four_of_a_kind  => 0, #       624
    full_house      => 0, #     3_744
    flush           => 0, #     5_108
    straight        => 0, #    10_200
    three_of_a_kind => 0, #    54_912
    two_pair        => 0, #   123_552
    one_pair        => 0, # 1_098_240
    high_card       => 0, # 1_302_540 
                          # 2_598_960 <== sum
};

sub is_straight
{
    my $l = shift;

    my @r = (0) x 14;
    for my $i (@$l) {
        $r[$i] = 1;
        $r[0]  = 1 if $i == 13; # 'A'
    }

    for my $i (0 .. 9) {
        return 1 if (all {$_ == 1} @r[$i .. $i+4]);
    }

    return 0;
}

sub poker_hand_rankings
{
    my @data = (0 .. 51);
    my $cnt = 0;
    my $iter = combinations(\@deck, 5);
    while (my $p = $iter->next) {
        ++$cnt;
        my %clor_stat;
        my %rank_stat;
        for my $c (@$p) {
            ++$clor_stat{$c->[0]};
            ++$rank_stat{$c->[1]};
        }
        my $num_clors = keys %clor_stat;
        my $num_ranks = keys %rank_stat;
        my @values    = values %rank_stat;
        my @keys      = keys %rank_stat;
        if ($num_clors == 4 && $num_ranks <= 2 && max(@values) == 4) {
			++$cat->{four_of_a_kind};
		} elsif ($num_ranks == 2 && 
            (($values[0] == 2 && $values[1] == 3) ||
             ($values[0] == 3 && $values[1] == 2))) {
			++$cat->{full_house};
        } elsif ($num_ranks == 3 &&
            (($values[0] == 2 && $values[1] == 2) ||
             ($values[1] == 2 && $values[2] == 2) ||
             ($values[2] == 2 && $values[0] == 2))) {
			++$cat->{two_pair};
        } elsif ($num_ranks == 4 &&
            ($values[0] == 2 ||
             $values[1] == 2 ||
             $values[2] == 2 ||
             $values[3] == 2)) {
			++$cat->{one_pair};
        } elsif ($num_ranks == 3 &&
            ($values[0] == 3 ||
             $values[1] == 3 ||
             $values[2] == 3)) {
			++$cat->{three_of_a_kind};
        } elsif ($num_clors == 1) {
            if (is_straight(\@keys)) {
                ++$cat->{straight_flush};
            } else {
                ++$cat->{flush};
            }
        } else {
            if (is_straight(\@keys)) {
                ++$cat->{straight};
            } else {
                ++$cat->{high_card};
            }
        }
    }
	#print Dumper($cat), "\n";

    my $sum = 0;
    $sum += $_ for values %$cat;
    return $cnt == $sum;
}

for (@$cases) {
    is(poker_hand_rankings($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;


__END__
