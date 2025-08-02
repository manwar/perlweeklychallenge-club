#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';


sub factorial {
    my ($n) = @_;

    # Base case: factorial of 0 is 1
    return 1 if $n == 0;

    # Recursive case: factorial(n) = n * factorial(n-1)
    return $n * factorial($n - 1);
}

sub combination {
    my ($first, $second) = @_;
    return factorial($first)/(factorial($second) * (factorial($first - $second)))
}

my $deck = 52;
my $card_in_hand = 5;

my $all_posibilty = factorial($deck)/(factorial($card_in_hand) * (factorial($deck - $card_in_hand)));

my $royal_flush     = combination(4,1);
my $straight_flush  = combination(10,1) * $royal_flush - $royal_flush;
my $four_of_a_kind  = combination(13,1)*combination(4,4)*combination(48,1);
my $full_house      = combination(13,1)*combination(4,3)*combination(12,1)*combination(4,2);
my $flush           = combination(13,5)*combination(4,1) - 40;
my $straight        = combination(10,1)*combination(4,1)**5 - 40;
my $three_of_a_kind = combination(13,1)*combination(4,3)*combination(12,2)*combination(4,1)**2;
my $two_pair        = combination(13,2)*combination(4,2)*combination(4,2)*combination(11,1)*combination(4,1);
my $one_pair        = combination(13,1)*combination(4,2)*combination(12,3)*combination(4,1)**3;
my $high_card       = (combination(13,5) - 10)*(4**5 - 4);

my $sum_of_all_hans = $royal_flush + $straight_flush + $four_of_a_kind + $full_house + $flush + $straight + $three_of_a_kind + $two_pair + $one_pair + $high_card;

print "All possibilities: $all_posibilty\n";
print "Sum of all hands: $sum_of_all_hans\n"