=begin
A draw poker hand consists of 5 cards, drawn from a pack of 52: no jokers, no wild cards. An ace can rank either high or low.

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
use Math::BigInt;

# Function to calculate combinations (n choose k)
sub combinations {
    my ($n, $k) = @_;
    return Math::BigInt->new(factorial($n)) / (Math::BigInt->new(factorial($k)) * Math::BigInt->new(factorial($n - $k)));
}

# Total number of 5-card hands
my $total_hands = combinations(52, 5);
print "Total different 5-card hands: ", $total_hands, "\n";

# Function to calculate the number of hands for each poker rank
sub calculate_hand_counts {
    my %hands_count;

    # High Card
    $hands_count{'High Card'} = combinations(13, 5) * combinations(4, 1) ** 5 - combinations(13, 5) * combinations(4, 2);

    # One Pair
    $hands_count{'One Pair'} = combinations(13, 1) * combinations(4, 2) * combinations(12, 3) * combinations(4, 1) ** 3;

    # Two Pair
    $hands_count{'Two Pair'} = combinations(13, 2) * combinations(4, 2) ** 2 * combinations(11, 1) * combinations(4, 1);

    # Three of a Kind
    $hands_count{'Three of a Kind'} = combinations(13, 1) * combinations(4, 3) * combinations(12, 2) * combinations(4, 1) ** 2;

    # Straight
    $hands_count{'Straight'} = combinations(10, 1) * combinations(4, 1) ** 5 - combinations(10, 1) * combinations(4, 1) ** 4 * 2;

    # Flush
    $hands_count{'Flush'} = combinations(13, 5) * combinations(4, 1) - 10 * combinations(13, 5) * combinations(4, 1);

    # Full House
    $hands_count{'Full House'} = combinations(13, 1) * combinations(4, 3) * combinations(12, 1) * combinations(4, 2);

    # Four of a Kind
    $hands_count{'Four of a Kind'} = combinations(13, 1) * combinations(4, 4) * combinations(12, 1) * combinations(4, 1);

    # Straight Flush
    $hands_count{'Straight Flush'} = combinations(10, 1) * combinations(4, 1);

    # Royal Flush
    $hands_count{'Royal Flush'} = combinations(1, 1) * combinations(4, 1);

    return %hands_count;
}

# Calculate hand counts for each rank
my %hands_count = calculate_hand_counts();

# Display hands count for each rank
foreach my $rank (sort keys %hands_count) {
    print "$rank: ", $hands_count{$rank}, "\n";
}

# Verify total hands count
my $total_calculated_hands = 0;
$total_calculated_hands += $_ for values %hands_count;

print "Total calculated hands of each rank: ", $total_calculated_hands, "\n";
print "Does total calculated hands equal total hands? ", ($total_calculated_hands == $total_hands ? "Yes" : "No"), "\n";

# Factorial function
sub factorial {
    my $n = shift;
    return $n <= 1 ? 1 : $n * factorial($n - 1);
}
