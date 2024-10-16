#!/usr/bin/env raku
use v6;

# factorial calculation
multi sub factorial($n where $n < 2)  { 1 }
multi sub factorial($n) { $n * factorial($n - 1) }

# combinations 
sub combinations($n, $k) {
  factorial($n) / ( factorial($k) * factorial($n - $k) )
}

sub format-number($n) {
  my $str = $n.Str;
  my @parts;
  while ($str.chars > 3) {
    @parts.unshift($str.substr(*-3,*-0));
    $str = $str.chop(3);
  }
  @parts.unshift($str);
  return @parts.join(",");
}

say "1. How many different 5-card hands can be dealt?";
my $possible_hands = combinations(52, 5);
say format-number $possible_hands;
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

printf "Royal Flush:     %9s\n", format-number $royalFlushes;
printf "Straight Flush:  %9s\n", format-number $straightFlushes;
printf "Four of a Kind:  %9s\n", format-number $fourOfAKinds;
printf "Full House:      %9s\n", format-number $fullHouses;
printf "Flush:           %9s\n", format-number $flushes;
printf "Straight:        %9s\n", format-number $straights;
printf "Three of a Kind: %9s\n", format-number $threeOfAKinds;
printf "Two Pair:        %9s\n", format-number $twoPair;
printf "One Pair:        %9s\n", format-number $onePair;
printf "High Card:       %9s\n", format-number $highCard;
say    "--------------------------";
printf "Total:           %9s\n", format-number 
  $royalFlushes + $straightFlushes + $fourOfAKinds +
  $fullHouses + $flushes + $straights + $threeOfAKinds +
  $twoPair + $onePair + $highCard;
