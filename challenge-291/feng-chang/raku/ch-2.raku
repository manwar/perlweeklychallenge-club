#!/bin/env raku

enum HandType <HighCard OnePair TwoPair Triple Straight Flush FullHouse Quadruple StraightFlush Quintuple>;

sub hand-type_(@hand --> HandType:D) {
    my %suit = @hand.map(*[0]).Bag;
    my \suit-type = %suit.values.max == 5 ?? HandType::Flush !! HandType::HighCard;

    my %face = @hand.map(*[1]).Bag;
    my \face-type = do given +%face.keys {
        when 1 { HandType::Quintuple }
        when 2 { 
            given %face.values.sort {
                when [1, 4] { HandType::Quadruple }
                when [2, 3] { HandType::FullHouse }
            }
        }
        when 3 {
            given %face.values.sort {
                when [1, 1, 3] { HandType::Triple  }
                when [1, 2, 2] { HandType::TwoPair }
            }
        }
        when 4 { HandType::OnePair }
        when 5 {
            my @faces = @hand.map(*[1]).sort;
            @faces[*-1] - @faces[0] == 4 ?? HandType::Straight !! HandType::HighCard
        }
    }

    return HandType::StraightFlush if suit-type == HandType::Flush && face-type == HandType::Straight;
    max(suit-type, face-type)
}

sub hand-type(@hand --> HandType:D) {
    my @hand_ = @hand.map({ $_[1] == 1 ?? ($_[0], 14) !! $_ });
    max(hand-type_(@hand), hand-type_(@hand_))
}

my @suit = <♠ ♥ ♢ ♣>;
my @cards = @suit X 1..13;
my @hands = @cards.combinations(5);
put 'counts of all hands: ', +@hands;

my %type-counts;
@hands.map({ ++%type-counts{hand-type($_)} });

put %type-counts.raku;
# {:Flush(5108), :FullHouse(3744), :HighCard(1302540), :OnePair(1098240), :Quadruple(624), :Straight(10200), :StraightFlush(40), :Triple(54912), :TwoPair(123552)}
put 'sum of all types: ', %type-counts.values.sum;
