use strict;
use warnings;
use feature 'say';

sub com  {
    # Binomial coefficient formula for: n choose k
    my ($n, $k) = @_;
    my $fact_k = 1;
    $fact_k *= $_ for 1..$k;
    my $nr_of_com_numerator = 1;
    $nr_of_com_numerator *= $_ for ($n -$k + 1)..$n;
    return $nr_of_com_numerator/ $fact_k;
}

sub poker_hands {
    my %hands =
       ("0. Royal flush" => com(4, 1),
        "1. Straight flush" => com(10, 1) * com(4, 1)
            - com(4, 1),
        "2. Four of a kind" => com(13, 1) * com(12, 1)
            * com(4, 1),
        "3. Full house" => com(13, 1) * com(4, 3)
            * com(12, 1) * com(4, 2),
        "4. Flush" => com(13, 5) * com(4, 1) - com(10, 1)
            * com(4, 1),       # Flush (excl. RF and SF)
        "5. Straight" => com(10, 1) * com(4, 1)**5 - com(10, 1)
            * com(4, 1),       # Straight (excl. RF and SF)
        "6. Three of a kind" => com(13, 1) * com(4, 3)
            * com(12, 2) * com(4, 1) ** 2,
        "7. Two pairs" => com(13, 2) * com(4, 2)**2
            * com(11, 1) * com(4, 1),
        "8. One pair" => com(13, 1) * com(4, 2) * com(12, 3)
            * com(4, 1)**3,    #
        "9. No pair" => (com(13, 5) - com(10,1))
            * (com(4, 1)**5 - com(4, 1)),
            # No pair or High card
    );
    return %hands;
}

my %hand_count = poker_hands;
my $num_hands = com 52, 5;
say "Total number of hands (direct count) => $num_hands";

for my $key (sort keys %hand_count) {
    printf "  - %-20s => %-10i \n", $key, $hand_count{$key};
}
my $sum = 0;
$sum += $_ for values %hand_count;
say "Sum of the hands by type => ", $sum
