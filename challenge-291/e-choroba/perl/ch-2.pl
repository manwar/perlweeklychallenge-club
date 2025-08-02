#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };
use utf8;

use open ':encoding(UTF-8)', ':std';

use enum qw( RANK SUIT );

use Math::Combinatorics;
use List::Util qw{ sum };

my %RANK = (J => 11, Q => 12, K => 13, A => 1, map { $_ => $_ } 2 .. 10);

my @cards = map {
    my $suit = $_;
    map [$_, $suit], 'A', 2 .. 10, 'J', 'Q', 'K'
} "\N{BLACK SPADE SUIT}", "\N{BLACK HEART SUIT}", "\N{ BLACK DIAMOND SUIT}",
    "\N{ BLACK CLUB SUIT }";

my $hands = 'Math::Combinatorics'->new(count => 5,
                                       data  => \@cards);

my %tally;
my %HAND = (
    '1 4'     => 'FOUR',
    '2 3'     => 'FULL_HOUSE',
    '1 1 3'   => 'THREE',
    '1 2 2'   => 'TWO_PAIR',
    '1 1 1 2' => 'PAIR',
);

while (my @c = $hands->next_combination) {
    ++$tally{ALL_HANDS};
    @c = sort { $RANK{ $a->[RANK] } <=> $RANK{ $b->[RANK] } } @c;
    my %suits;
    @suits{ map $_->[SUIT], @c } = ();
    if (1 == keys %suits) {
        if ($RANK{ $c[0][RANK] } + 4 == $RANK{ $c[4][RANK] }
            || $c[0][RANK] eq 'A' && $c[1][RANK] eq '10') {
            ++$tally{STRAIGHT_FLUSH};
        } else {
            ++$tally{FLUSH};
        }
    } else {
        my %rank;
        ++$rank{ $_->[RANK] } for @c;
        my $hand = join ' ', sort { $a <=> $b } values %rank;
        if (exists $HAND{$hand}) {
            ++$tally{ $HAND{$hand} };
        } else {
            my $seq = grep $RANK{ $c[$_][RANK] } + 1
                           == $RANK{ $c[ $_ + 1 ][RANK] },
                      0 .. $#c - 1;
            if (4 == $seq || 'A10JQK' eq join "", map $_->[RANK], @c) {
                ++$tally{STRAIGHT};
            } else {
                ++$tally{HIGH_CARD};
            }
        }
    }
}
for my $hand (sort { $tally{$a} <=> $tally{$b} } keys %tally) {
    say $hand, "\t", $tally{$hand};
}

my $total = delete $tally{ALL_HANDS};

# See https://en.wikipedia.org/wiki/Poker_probability
my %EXPECTED = (
    STRAIGHT_FLUSH =>    4 + 36,
    FOUR           =>       624,
    FULL_HOUSE     =>     3_744,
    FLUSH          =>     5_108,
    STRAIGHT       =>    10_200,
    THREE          =>    54_912,
    TWO_PAIR       =>   123_552,
    PAIR           => 1_098_240,
    HIGH_CARD      => 1_302_540,
);

use Test::More tests => 3;

is scalar @cards, 52, 'Number of cards';
is sum(values %tally), $total, 'Sum all hands';
is_deeply \%tally, \%EXPECTED, 'Hand counts';
