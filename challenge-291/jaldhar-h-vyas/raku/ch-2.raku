#!/usr/bin/raku

class Card {
    has Int $.suit;
    has Int $.rank;
}

sub classify(@hand) {
    my %suitFreq;
    my %rankFreq;

    for @hand -> $card {
        %suitFreq{$card.suit}++;
        %rankFreq{$card.rank}++;
    }

    given %rankFreq.values.sort {

        when [1, 4] { return 'fourofakind'; }

        when [2, 3] { return 'fullhouse'; }

        when [1, 1, 3] { return 'threeofakind'; } 

        when [1, 2, 2] { return 'twopair'; }

        when [1, 1, 1, 2] { return 'pair'; }

        when [1, 1, 1, 1, 1] {
            my $sameSuit = %suitFreq.elems == 1;
            my @ranks = %rankFreq.keys.sort({ $^a <=> $^b });
            my $aceHigh = @ranks ~~ [1, 10, 11, 12, 13];
            my $sequential = @ranks[4] - @ranks[0] == 4;

            if $sameSuit {
                if $aceHigh {
                    return 'royalflush';
                } elsif $sequential {
                    return 'straightflush';
                } else {
                    return 'flush';
                }
            } else {
                if $sequential || $aceHigh {
                    return 'straight';
                } else {
                    return 'highcard';
                }
            }
        }

        default { return q{}; }
    }
}

sub MAIN() {
    my Card @cards;

    for (1 .. 4) -> $suit {
        for (1 .. 13) -> $rank {
            @cards.push(Card.new(suit => $suit, rank => $rank));
        }
    }

    my %frequencies;

    my @hands = @cards.combinations(5);
    my $total = @hands.elems;

    for @hands -> $hand {
        %frequencies{classify(@$hand)}++;
    }

    say 'Total Possible Hands = ', $total;
    say 'Royal Flush = ', %frequencies<royalflush>;
    say 'Straight Flush = ', %frequencies<straightflush>;
    say 'Four of a Kind = ', %frequencies<fourofakind>;
    say 'Full house = ', %frequencies<fullhouse>;
    say 'Flush = ', %frequencies<flush>;
    say 'Straight = ', %frequencies<straight>;
    say 'Three of a Kind = ', %frequencies<threeofakind>;
    say 'Two Pair = ', %frequencies<twopair>;
    say 'Pair = ', %frequencies<pair>;
    say 'High Card = ', %frequencies<highcard>;
    say 'Does Total Possible Hands equal the sum of all rank frequencies? ', $total == %frequencies.values.sum;
}