#! /usr/bin/env raku

my $five_card_hands = five_card_hands;
my $padding = $five_card_hands.chars;

say "Five Card Hands: $five_card_hands\n";

my %ten_ranks     = ten_ranks;
my $ten_ranks_sum = %ten_ranks.values.sum;

say "Five of a Kind:  { %ten_ranks<five-of-a-kind>.fmt('%' ~ $padding ~ "d") }";
say "Straight Flush:  { %ten_ranks<straight-flush>.fmt('%' ~ $padding ~ "d") }";
say "Four of a Kind:  { %ten_ranks<four-of-a-kind>.fmt('%' ~ $padding ~ "d") }";
say "Full House:      { %ten_ranks<full-house>.fmt('%' ~ $padding ~ "d") }";
say "Flush:           { %ten_ranks<flush>.fmt('%' ~ $padding ~ "d") }";
say "Straight:        { %ten_ranks<straight>.fmt('%' ~ $padding ~ "d") }";
say "Three of a Kind: { %ten_ranks<three-of-a-kind>.fmt('%' ~ $padding ~ "d") }";
say "Two Pair:        { %ten_ranks<two-pair>.fmt('%' ~ $padding ~ "d") }";
say "One Pair:        { %ten_ranks<one-pair>.fmt('%' ~ $padding ~ "d") }";
say "High Card:       { %ten_ranks<high-card>.fmt('%' ~ $padding ~ "d") }";
say "Sum:             { $ten_ranks_sum.fmt('%' ~ $padding ~ "d") }";

say  $ten_ranks_sum == $five_card_hands
  ?? "\nThe number of Five Card Hands and the Sum Matches"
  !! "\nThe number of Five Card Hands and the Sum does not Match";

sub five_card_hands
{
  return
    52 * 51 * 50 * 49 * 48   # The number of cards to choose from
  / (5 *  4 *  3 *  2 *  1); # The order is irrelevant
}

sub ten_ranks
{
  my %res;

  %res<five-of-a-kind> = 0; # As we do not allow jokers and wildcards

  %res<straight-flush> =
    10 * # 10 different intervals (see below)
     4;  #  4 suits to choose from

  # Intervals: 1-5, 2-6, 3-7, 4-8, 5-9, 6-10, 7-11, 8-12, 9-13, 10-1
 
  %res<four-of-a-kind> =
    13 *    # 13 kinds to choose from, pick one (all four cards)
    12 * 4; # 12 kinds left, choose one of a any suit.

  %res<full-house> =
    13 * 4 *   # Choose three cards of the same kind (=exclude one of 4 cards)
    12 * 4 * 3 # Choose two cards of the same kind, different than above
       / 2;    # The order of 4,5 is irrelevant
		   
  %res<flush> =
    13 * 12 * 11 * 10 * 9 *   # 5 cards of the same suit
     4                        # 4 suits to choose from
       / (5 * 4 * 3 * 2 * 1)  # Order is irrelevant
     - %res<straight-flush>;  # Remove Straight Flushes

  %res<straight> =
     4 * 4 * 4 * 4 * 4 *      # Four choices for each value
    10                        # 10 ranges (1-5 .. 9-13, 10-1)
      - %res<straight-flush>; # Get rid of Straight Flushes

  %res<three-of-a-kind> =
    13 * 4 *    # One of thirteen, 4 possibilites for * 3
    12 * 4 *    # Card 4; not the same value
    11 * 4      # Card 5; not the same valus
       / 2;     # The order of 4,5 is irrelevant
  
  %res<two-pair> =
    13 * 4 * 3  # Card 1 and 2
       / 2 *    # The order of 1,2 is irrelevant
    12 * 4 * 3  # Card 3 and 4
       / 2      # The order of 3,4 is irrelevant
       / 2 *    # The order of the two pairs is irrelevant
    11 * 4;     # Card 5

  %res<one-pair> =
    13 * 4 * 3        # Card 1 and 2.
       / 2 *          # The order of 1,2 is irrelevant
    12 * 4 *          # Card 3, diffferent value
    11 * 4 *          # Card 4, a second unused value
    10 * 4            # Card 5, a third unused value
       / (1 * 2 * 3); # The order of 3,4,5 is irrelevant
  
  %res<high-card> = (52 * 51 * 50 * 49 * 48) / (5 * 4 * 3 * 2 * 1)
                  - %res.values.sum;
 
  return %res;
}
