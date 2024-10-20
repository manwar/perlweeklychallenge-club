#!/usr/bin/env python3

from collections import Counter, defaultdict
from itertools import combinations


def get_hand(cards):
    # Split the cards by numbers and suits
    cards_by_rank = defaultdict(list)
    cards_by_suit = defaultdict(list)

    for card in cards:
        number, suit = card
        cards_by_rank[number].append(card[1])
        cards_by_suit[suit].append(card[0])

    # Count the frequency of each rank
    count_by_rank = Counter(len(cards_by_rank[r]) for r in cards_by_rank)

    # Check for a flush / straight flush
    if len(cards_by_suit) == 1:
        # Get the card ranks in the flush
        cards = sorted(cards_by_rank)
        # If the first card is an ace and the last card is king, move the ace to the end
        if cards[0] == 1 and cards[4] == 13:
            cards.pop(0)
            cards.append(14)

        # Check for a straight
        if cards[4] - cards[0] == 4:
            return 'Straight flush'

        return 'Flush'

    # Four of a kind (same rank on four cards)
    if count_by_rank[4]:
        return 'Four of a kind'

    # Full House (three of one rank, two of another)
    if count_by_rank[3] and count_by_rank[2]:
        return 'Full house'

    # Straight
    if len(cards_by_rank) == 5:
        # Get the card ranks in the possible flush
        cards = sorted(cards_by_rank)
        # If the first card is an ace and the last card is king, move the ace to the end
        if cards[0] == 1 and cards[4] == 13:
            cards.pop(0)
            cards.append(14)

        # Check for a straight
        if cards[4] - cards[0] == 4:
            return 'Straight'

    # Three of a kind
    if count_by_rank[3]:
        return 'Three of a kind'

    # Two pair
    if count_by_rank[2] == 2:
        return 'Two pair'

    # One pair
    if count_by_rank[2]:
        return 'One pair'

    # Nothing special
    return 'High card'


def display_results(hands):
    hand_names = [
        'Straight flush', 'Four of a kind', 'Full house', 'Flush', 'Straight',
        'Three of a kind', 'Two pair', 'One pair', 'High card',
    ]

    fmt = '{:16} {:>17,} {:>12,}'

    print('Hand                  Combinations Permutations')
    print('-------------------   ------------ ------------')

    for hand in hand_names:
        print(fmt.format(hand, hands[hand], hands[hand] * 120))

    print('-------------------   ------------ ------------')
    print(fmt.format('Total', sum(hands.values()), sum(hands.values()) * 120))


def main():
    # Let's deal some cards
    deck = [(rank, suit) for rank in range(1, 14)
            for suit in ('s', 'c', 'd', 'h')]
    hands = defaultdict(int)

    # Now work through all combinations
    for cards in combinations(deck, 5):
        hand = get_hand(cards)
        hands[hand] += 1

    # Print the results
    display_results(hands)


if __name__ == '__main__':
    main()
