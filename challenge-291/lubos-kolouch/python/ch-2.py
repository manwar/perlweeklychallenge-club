import math


def nCr(n, r):
    return math.comb(n, r)


# Total number of 5-card hands
total_hands = nCr(52, 5)

# Initialize counts for each hand rank
hand_counts = {}

# Royal Flush
# There are 4 suits, and each suit has one Royal Flush
hand_counts['Royal Flush'] = 4

# Straight Flush (excluding Royal Flush)
# There are 9 possible sequences for a Straight Flush in each suit
hand_counts['Straight Flush'] = (9 * 4)

# Four of a Kind
# Choose rank for the quadruple and choose one card from remaining 48 cards
hand_counts['Four of a Kind'] = 13 * nCr(48, 1)

# Full House
# Choose rank for triple, choose 3 suits out of 4
# Choose rank for pair, choose 2 suits out of 4
hand_counts['Full House'] = 13 * nCr(4, 3) * 12 * nCr(4, 2)

# Flush (excluding Royal Flush and Straight Flush)
# Total Flushes = Number of suits * Number of ways to choose 5 cards from 13
# Exclude Royal Flushes and Straight Flushes
total_flushes = 4 * nCr(13, 5)
hand_counts['Flush'] = total_flushes - hand_counts[
    'Royal Flush'] - hand_counts['Straight Flush']

# Straight (excluding Royal Flush and Straight Flush)
# Total sequences: 10 (Ace low to 10 high)
# Total straights = Number of sequences * (4 suits)^5 combinations - Straight Flushes
total_straights = 10 * nCr(4, 1)**5
hand_counts['Straight'] = total_straights - hand_counts[
    'Royal Flush'] - hand_counts['Straight Flush']

# Three of a Kind
# Choose rank for triple, choose 3 suits out of 4
# Choose 2 different ranks from remaining 12 ranks, choose one suit from 4 for each
hand_counts['Three of a Kind'] = 13 * nCr(4, 3) * nCr(12, 2) * (4**2)

# Two Pair
# Choose 2 ranks out of 13 for pairs, choose 2 suits out of 4 for each
# Choose one rank from remaining 11 ranks, choose one suit out of 4
hand_counts['Two Pair'] = nCr(13, 2) * (nCr(4, 2)**2) * 11 * 4

# One Pair
# Choose one rank for the pair, choose 2 suits out of 4
# Choose 3 different ranks from remaining 12, choose one suit from 4 for each
hand_counts['One Pair'] = 13 * nCr(4, 2) * nCr(12, 3) * (4**3)

# High Card (Nothing)
# Total possible hands excluding all other hands
hand_counts['High Card'] = total_hands
for hand in hand_counts:
    if hand != 'High Card':
        hand_counts['High Card'] -= hand_counts[hand]

# Output the results
print(f"Total number of 5-card hands: {total_hands}\n")
print("Number of hands for each rank:")
for hand in [
        'Royal Flush', 'Straight Flush', 'Four of a Kind', 'Full House',
        'Flush', 'Straight', 'Three of a Kind', 'Two Pair', 'One Pair',
        'High Card'
]:
    print(f"{hand:15}: {hand_counts[hand]}")

# Verify the sum
sum_of_counts = sum(hand_counts[hand] for hand in hand_counts)
print(f"\nSum of all hand counts: {sum_of_counts}")
print(
    f"Verification: {'Passed' if sum_of_counts == total_hands else 'Failed'}")
