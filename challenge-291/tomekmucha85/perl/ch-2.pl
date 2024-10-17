use strict;
use warnings;
use Method::Signatures;
use feature 'say';

# I am aware that this is a time-consuming approach, because it calculates every possible hand.
# It takes ~45 seconds on my machine to get the results and my only excuse is that it was fun to code.
# (And it was even more joy to see that results match these calculated with probability formulas ;) )
# Kind regards!
# Tomasz Mucha


my $all_cards_count = 52;
my $cards_in_hand_count = 5;
my @all_cards;
my @card_suits = ('hearts', 'diamonds', 'clubs', 'spades');
my @card_ranks = 2 .. 14; # 11 stands for Jack, 12 for Queen, 13 for King and 14 for Ace
foreach my $rank (@card_ranks){
    foreach my $suit (@card_suits){
        push(@all_cards, [$rank, $suit]);
    }
}

my %all_cards_indexed;
my $card_counter = 0;
foreach my $card (@all_cards){
    $all_cards_indexed{$card_counter++} = $card;
}

sub calculate_factorial{
    my ($number) = shift;
    my $factorial = 1;
    my $next_element = 1;
    while ($next_element < $number){
        $factorial *= ++$next_element;
    }
    return $factorial

}

func get_all_unique_combinations_and_filter_them(Int $set_size, ArrayRef $elements, Maybe[HashRef] $output =  undef, Maybe[CodeRef] $filtering_method = undef, ArrayRef $current_combination = []){
    my $counter = 0;
    foreach my $element (@{$elements}){
        my @inner_array = @{$elements};
        splice(@inner_array, $counter, 1);

        my @new_combination = @{$current_combination};
        if((!defined($current_combination->[-1])) or ($current_combination->[-1] < $element)) {
            if ($set_size > 1) {
                push(@new_combination, $element);
                get_all_unique_combinations_and_filter_them($set_size - 1, \@inner_array, $output, $filtering_method, \@new_combination);
            }
            else {
                push(@new_combination, $element);
                @new_combination = sort(@new_combination);
                my $combination = join(' ', @new_combination);
                if (defined($filtering_method) and defined($output)) {
                    my $result = &$filtering_method($combination);
                    $output->{$result}+=1;
                }
            }
        }
        $counter++;
    }
}


sub calculate_number_of_possible_poker_hands{
    return calculate_factorial($all_cards_count)/(calculate_factorial($cards_in_hand_count)*calculate_factorial($all_cards_count-$cards_in_hand_count));
}

func categorize_poker_hand(Str $hand){
    my @card_indexes = split(' ', $hand);
    my @hand_cards;
    my @hand_ranks;
    my @hand_suits;
    foreach my $card_index (@card_indexes){
        push(@hand_cards, $all_cards_indexed{$card_index});
        push(@hand_ranks, $all_cards_indexed{$card_index}[0]);
        push(@hand_suits, $all_cards_indexed{$card_index}[1]);

    }
    my %unique_ranks;
    foreach my $rank (@hand_ranks){
        $unique_ranks{$rank} += 1;
    }

    my %unique_suits;
    foreach my $suit (@hand_suits){
        $unique_suits{$suit} += 1;
    }

    # Check if we've got a straight flush or straight
    if (scalar(keys(%unique_ranks)) == 5){
        my($rank_1, $rank_2, $rank_3, $rank_4, $rank_5) = sort {$a <=> $b} keys(%unique_ranks);
        if ($rank_5-$rank_4==1 and $rank_4-$rank_3==1 and $rank_3-$rank_2==1 and $rank_2-$rank_1==1){
            if (scalar(keys(%unique_suits)) == 1){
                return "straight_flush";
            }
            else{
                return "straight"
            }
        }
        elsif($rank_5 == 14) { # Treat Ace as 1
            if ($rank_4 - $rank_3 == 1 and $rank_3 - $rank_2 == 1 and $rank_2 - $rank_1 == 1 and $rank_1 - 1 == 1) {
                if (scalar(keys(%unique_suits)) == 1){
                    return "straight_flush";
                }
                else{
                    return "straight";
                }
            }
        }
    }

    # Check if four cards are alike
    foreach my $value (values(%unique_ranks)){
        if ($value == 4){
            return "four_of_a_kind";
        }
    }

    # Check we've got a full house
    if(scalar(keys(%unique_ranks)) == 2){
        return "full_house";
    }

    #Check if we've got a flush
    if (scalar(keys(%unique_suits)) == 1) {
        return "flush";
    }

    #Check if we've got three of a kind or two pairs
    if(scalar(keys(%unique_ranks)) == 3){
        for my $count (values(%unique_ranks)){
            if($count == 3){
                return "three_of_a_kind";
            }
        }
        return "two_pair";
    }

    #Check if we've got one pair
    if(scalar(keys(%unique_ranks)) == 4){
        return "one_pair";
    }

    return "high_card";
}

my %poker_hash;
get_all_unique_combinations_and_filter_them($cards_in_hand_count, [keys(%all_cards_indexed)], \%poker_hash, \&categorize_poker_hand);
say("There are no five of a kinds in all possible hands (because we don't have wildcards in 52 cards deck).");
say("There are $poker_hash{straight_flush} straight flushes in all possible hands.");
say("There are $poker_hash{four_of_a_kind} four of a kinds in all possible hands.");
say("There are $poker_hash{full_house} full houses in all possible hands.");
say("There are $poker_hash{flush} flushes in all possible hands.");
say("There are $poker_hash{straight} straights in all possible hands.");
say("There are $poker_hash{three_of_a_kind} three of a kinds in all possible hands.");
say("There are $poker_hash{two_pair} two pairs in all possible hands.");
say("There are $poker_hash{one_pair} one pairs in all possible hands.");
say("There are $poker_hash{high_card} high cards in all possible hands.");

my $total_hands_count_summed_up = $poker_hash{straight_flush} + $poker_hash{four_of_a_kind} + $poker_hash{full_house} + $poker_hash{flush} + $poker_hash{straight} + $poker_hash{three_of_a_kind} + $poker_hash{two_pair} + $poker_hash{one_pair} + $poker_hash{high_card};
my $total_hands_count = calculate_number_of_possible_poker_hands();
say("All hands summed up gave us $total_hands_count_summed_up.");
say("There are $total_hands_count possible $cards_in_hand_count cards arrangements for $all_cards_count cards deck.");
if ($total_hands_count == $total_hands_count_summed_up){
    say("Both numbers match!");
}
else{
    say("Numbers don't match :(");
}
