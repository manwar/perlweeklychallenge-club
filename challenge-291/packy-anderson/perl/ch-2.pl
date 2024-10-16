#!/usr/bin/env perl
use v5.40;

# factorial calculation
sub factorial($n) {
  return 1 if $n < 2;
  return $n * factorial($n - 1);
}

# combinations 
sub combinations($n, $k) {
  factorial($n) / ( factorial($k) * factorial($n - $k) )
}

sub format_number($n) {
  my $str = "$n";
  my @parts;
  while (length($str) > 3) {
    unshift @parts, substr($str, -3, 3, "");
  }
  unshift @parts, $str;
  return join(",", @parts);
}

say "1. How many different 5-card hands can be dealt?";
my $possible_hands = combinations(52, 5);
say format_number $possible_hands;
say "";

say "2. How many different hands of each of the 10 ranks can be dealt?";

my $royalFlushes    = combinations(4, 1);
my $straightFlushes = combinations(9, 1) * combinations(4, 1);
my $fourOfAKinds    = combinations(13, 1) * combinations(48, 1);
my $fullHouses      = combinations(13, 1) * combinations(4, 3) 
                    * combinations(12, 1) * combinations(4, 2);
my $flushes         = (combinations(13, 5) - 10)
                    * combinations(4, 1);
my $straights       = combinations(10, 1) * (4 ** 5)
                    - $straightFlushes - $royalFlushes;     
my $threeOfAKinds   = combinations(13, 1) * combinations(4, 3) 
                    * combinations(48, 2) - $fullHouses;
my $twoPair         = combinations(13, 2) * (combinations(4, 2) ** 2)
                    * combinations(44, 1);
my $onePair         = combinations(13, 1) * combinations(4, 2)
                    * combinations(12, 3) * combinations(4, 1) ** 3;
my $highCard        = (combinations(13, 5) - 10)
                    * (combinations(4, 1) ** 5 - 4);

printf "Royal Flush:     %9s\n", format_number $royalFlushes;
printf "Straight Flush:  %9s\n", format_number $straightFlushes;
printf "Four of a Kind:  %9s\n", format_number $fourOfAKinds;
printf "Full House:      %9s\n", format_number $fullHouses;
printf "Flush:           %9s\n", format_number $flushes;
printf "Straight:        %9s\n", format_number $straights;
printf "Three of a Kind: %9s\n", format_number $threeOfAKinds;
printf "Two Pair:        %9s\n", format_number $twoPair;
printf "One Pair:        %9s\n", format_number $onePair;
printf "High Card:       %9s\n", format_number $highCard;
say    "--------------------------";
printf "Total:           %9s\n", format_number 
  $royalFlushes + $straightFlushes + $fourOfAKinds +
  $fullHouses + $flushes + $straights + $threeOfAKinds +
  $twoPair + $onePair + $highCard;
