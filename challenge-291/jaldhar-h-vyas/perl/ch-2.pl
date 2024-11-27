#!/usr/bin/perl
use v5.38;
use builtin qw/ true false /;
use feature qw/ class /;
no warnings 'experimental::builtin';
no warnings 'experimental::class';

class Card {
    field $suit :param;
    field $rank :param;

    method suit() {
        return $suit;
    }

    method rank() {
        return $rank;
    }
}

sub combinations($listref, $length) {
    my @list = @{$listref};

    if ($length <= 1) {
        return map [$_], @list;
    }

    my @combos;

    for (my $i = 0; $i + $length <= scalar @list; $i++) {
        my $val  = $list[$i];
        my @rest = @list[$i + 1 .. $#list];
        for my $c (combinations(\@rest, $length - 1)) {
            push @combos, [$val, @{$c}] ;
        }
    }

    return @combos;
}

sub compare($listref1, $listref2) {
    if (scalar @{$listref1} != scalar @{$listref1}) {
        return false;
    }

    for my $i (keys @{$listref1}) {
        if ($listref1->[$i] != $listref2->[$i]) {
            return false;
        }
    }

    return true;
}

sub sum(@list) {
    my $total;
    for my $n (@list) {
        $total += $n;
    }

    return $total;
}

sub classify(@hand) {
    my %suitFreq;
    my %rankFreq;

    for my $card (@hand) {
        $suitFreq{$card->suit}++;
        $rankFreq{$card->rank}++;
    }

    my @sorted = sort (values %rankFreq);
    # say join q{, }, @sorted;

    if (compare(\@sorted, [1, 4])) { return 'fourofakind'; }

    if (compare(\@sorted, [2, 3])) { return 'fullhouse'; }

    if (compare(\@sorted, [1, 1, 3])) { return 'threeofakind'; } 

    if (compare(\@sorted, [1, 2, 2])) { return 'twopair'; }

    if (compare(\@sorted, [1, 1, 1, 2])) { return 'pair'; }

    if (compare(\@sorted, [1, 1, 1, 1, 1])) {
        my $sameSuit = scalar keys %suitFreq == 1;
        my @ranks = sort { $a <=> $b } keys %rankFreq;
        my $aceHigh = compare(\@ranks, [1, 10, 11, 12, 13]);
        my $sequential = $ranks[4] - $ranks[0] == 4;

        if ($sameSuit) {
            if ($aceHigh) {
                return 'royalflush';
            } elsif ($sequential) {
                return 'straightflush';
            } else {
                return 'flush';
            }
        } else {
            if ($sequential || $aceHigh) {
                return 'straight';
            } else {
                return 'highcard';
            }
        }
    }

    return q{};
}

my Card @cards;

for my $suit (1 .. 4) {
    for my $rank (1 .. 13) {
        push @cards, Card->new(suit => $suit, rank => $rank);
    }
}

my %frequencies;

my @hands = combinations(\@cards, 5);
my $total = scalar @hands;

for my $hand (@hands) {
    $frequencies{classify(@{$hand})}++;
}

say 'Total Possible Hands = ', $total;
say 'Royal Flush = ', $frequencies{royalflush};
say 'Straight Flush = ', $frequencies{straightflush};
say 'Four of a Kind = ', $frequencies{fourofakind};
say 'Full house = ', $frequencies{fullhouse};
say 'Flush = ', $frequencies{flush};
say 'Straight = ', $frequencies{straight};
say 'Three of a Kind = ', $frequencies{threeofakind};
say 'Two Pair = ', $frequencies{twopair};
say 'Pair = ', $frequencies{pair};
say 'High Card = ', $frequencies{highcard};
say 'Does Total Possible Hands equal the sum of all rank frequencies? ', $total == sum(values %frequencies) ? 'True' : 'False';
