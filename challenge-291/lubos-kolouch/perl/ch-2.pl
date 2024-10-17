#!/usr/bin/perl
use strict;
use warnings;
use bignum;  # For handling large numbers

# Factorial function
sub factorial {
    my ($n) = @_;
    return 1 if $n == 0;
    my $product = 1;
    $product *= $_ for 1 .. $n;
    return $product;
}

# Combination function nCr
sub nCr {
    my ($n, $r) = @_;
    return factorial($n) / (factorial($r) * factorial($n - $r));
}

# Total number of 5-card hands
my $total_hands = nCr(52, 5);

# Initialize counts for each hand rank
my %hand_counts;

# Royal Flush
# There are 4 suits, and each suit has one Royal Flush
$hand_counts{'Royal Flush'} = 4;

# Straight Flush (excluding Royal Flush)
# Total Straight Flushes = (Number of sequences starting from Ace to 10) * Number of suits - Royal Flushes
# There are 9 possible sequences (A-2-3-4-5 to 10-J-Q-K-A)
$hand_counts{'Straight Flush'} = (9 * 4) - $hand_counts{'Royal Flush'};

# Four of a Kind
# Choose rank for the quadruple and choose one card from remaining 48 cards
$hand_counts{'Four of a Kind'} = 13 * nCr(48, 1);

# Full House
# Choose rank for triple, choose 3 suits out of 4
# Choose rank for pair, choose 2 suits out of 4
$hand_counts{'Full House'} = 13 * nCr(4,3) * 12 * nCr(4,2);

# Flush (excluding Royal Flush and Straight Flush)
# Total Flushes - Royal Flushes - Straight Flushes
# Total Flushes = Number of suits * Number of ways to choose 5 cards from 13
my $total_flushes = 4 * nCr(13,5);
$hand_counts{'Flush'} = $total_flushes - $hand_counts{'Royal Flush'} - $hand_counts{'Straight Flush'};

# Straight (excluding Royal Flush and Straight Flush)
# Total Straights = Number of sequences * Number of suits^5 - Straight Flushes
my $total_straights = 10 * 4**5;  # 10 sequences from A-2-3-4-5 to 10-J-Q-K-A
$hand_counts{'Straight'} = $total_straights - $hand_counts{'Royal Flush'} - $hand_counts{'Straight Flush'};

# Three of a Kind
# Choose rank for triple, choose 3 suits out of 4
# Choose 2 different ranks from remaining 12 ranks, choose one card from each
$hand_counts{'Three of a Kind'} = 13 * nCr(4,3) * nCr(12,2) * (4**2);

# Two Pair
# Choose 2 ranks out of 13 for pairs, choose 2 suits out of 4 for each
# Choose one rank from remaining 11 ranks, choose one suit out of 4
$hand_counts{'Two Pair'} = nCr(13,2) * (nCr(4,2)**2) * 11 * 4;

# One Pair
# Choose one rank for the pair, choose 2 suits out of 4
# Choose 3 different ranks from remaining 12, choose one suit out of 4 for each
$hand_counts{'One Pair'} = 13 * nCr(4,2) * nCr(12,3) * (4**3);

# High Card (Nothing)
# Total possible hands excluding all other hands
$hand_counts{'High Card'} = $total_hands;
for my $hand (keys %hand_counts) {
    next if $hand eq 'High Card';
    $hand_counts{'High Card'} -= $hand_counts{$hand};
}

# Output the results
print "Total number of 5-card hands: $total_hands\n\n";
print "Number of hands for each rank:\n";
for my $hand (
    'Royal Flush', 'Straight Flush', 'Four of a Kind', 'Full House',
    'Flush', 'Straight', 'Three of a Kind', 'Two Pair', 'One Pair', 'High Card'
) {
    printf "%-15s: %d\n", $hand, $hand_counts{$hand};
}

# Verify the sum
my $sum = 0;
$sum += $hand_counts{$_} for keys %hand_counts;
print "\nSum of all hand counts: $sum\n";
print "Verification: ", ($sum == $total_hands) ? "Passed" : "Failed", "\n";

