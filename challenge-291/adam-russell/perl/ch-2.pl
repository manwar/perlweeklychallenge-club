use v5.40;

use constant CARDS_DECK => 52;
use constant CARDS_HAND => 5;
use constant SUITS => 4; 
use constant CARDS_SUIT => CARDS_DECK / SUITS;
use constant CARDS_PAIR => 2;

sub factorial{
    my ($n) = @_;
    my $factorial = 1;
    $factorial *= $_ for 1 .. $n;
    return $factorial;
}

sub combinations{
    my($n, $k) = @_; 
    return factorial($n) / (factorial($k) * factorial($n - $k));
}

sub num_hands_per_rank {
    my %ranks = (
        'High Card'      => high_card_hands(),
        'One Pair'       => one_pair_hands(),
        'Two Pair'       => two_pair_hands(),
        'Three of a Kind'=> three_of_a_kind_hands(),
        'Straight'       => straight_hands(),
        'Flush'          => flush_hands(),
        'Full House'     => full_house_hands(),
        'Four of a Kind' => four_of_a_kind_hands(),
        'Straight Flush' => straight_flush_hands(),
        'Royal Flush'    => royal_flush_hands(),
    );
    return %ranks;
}

sub five_card_hands{
    return combinations(CARDS_DECK, CARDS_HAND);   
}

sub high_card_hands {
    return combinations(CARDS_SUIT, CARDS_HAND) * combinations(SUITS, 1)**CARDS_HAND - straight_hands() - flush_hands() - straight_flush_hands(); 
}

sub one_pair_hands {
    return combinations(CARDS_SUIT, 1) * combinations(SUITS, CARDS_PAIR) * combinations(CARDS_SUIT - 1, SUITS - 1) * combinations(SUITS, 1)**(SUITS - 1);
}

sub two_pair_hands {
    return combinations(CARDS_SUIT, CARDS_PAIR) * combinations(SUITS, CARDS_PAIR)**CARDS_PAIR * combinations(CARDS_SUIT - 2, 1) * combinations(SUITS, 1);
}

sub three_of_a_kind_hands {
    return combinations(CARDS_SUIT, 1) * combinations(SUITS, 3) * combinations(CARDS_SUIT - 1, 2) * combinations(SUITS, 1)**2;
}

sub straight_hands {
    return combinations(10, 1) * combinations(4, 1)**5 - straight_flush_hands();
}

sub flush_hands {
    return combinations(4, 1) * (combinations(13, 5) - straight_hands());
}

sub full_house_hands {
    return combinations(13, 1) * combinations(4, 3) * combinations(12, 1) * combinations(4, 2);
}

sub four_of_a_kind_hands {
    return combinations(13, 1) * combinations(4, 4) * combinations(12, 1) * combinations(4, 1);
}

sub straight_flush_hands {
    return combinations(10, 1) * combinations(4, 1);
}

sub royal_flush_hands {
    return 4;  
}

sub check_total_hands {
    my %ranks = num_hands_per_rank();
    my $sum = 0;

    foreach my $rank (keys %ranks) {
        $sum += $ranks{$rank};
    }
    $sum -= royal_flush_hands; # or else the royal flushes get counted twice!

    my $total_hands = five_card_hands();
    
    if ($sum == $total_hands) {
        print "The sum of all poker hands ($sum) matches the total number of 5-card hands: $total_hands\n";
    } else {
        print "Mismatch: The sum of all poker hands ($sum) does not match the total number of 5-card hands: $total_hands\n";
    }
}

MAIN:{ 
    check_total_hands;
}  
