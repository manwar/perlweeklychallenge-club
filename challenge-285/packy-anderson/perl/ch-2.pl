#!/usr/bin/env perl
use v5.40;

use Memoize;
memoize('makeChange');

# establish the values of the coins
my %types = (50 => 'HD', 25 => 'Q', 10 => 'D', 5 => 'N', 1 => 'P');

# make a sorted list of coin values
my @values = sort { $a <=> $b } keys %types;

# handle formatting coins to not display the number 1
sub formatCoin($coin, $count) {
  return ( ($count == 1 ? "" : $count) . $coin );
}

sub makeChange($amount, $exclude = 0) {
  my @output;
  foreach my $value (reverse @values) {
    # if this type of coin is worth more
    # than the total, we can't use it
    next if $value > $amount;

    # if we're excluding this coin value or greater, skip it
    next if $exclude && $value >= $exclude;

    my $coin = $types{$value}; # get the coin name

    if ($value == 1) {
      # pennies are easy!
      push @output, formatCoin($coin, $amount);
    }
    else {
      # loop from max number of this coin we can use down to 1
      foreach my $count ( reverse 1 .. int($amount / $value) ) {
        # figure out how much change we need after we've used
        # $count many of coin $coin
        my $left = $amount - ($count * $value);

        if ($left > 0) { # we need more change
          # make a recursive call to get the combinations
          # for that remaining amount, excluding any coins
          # of equal or greater value to $value
          my @combinations = makeChange($left, $value);
          foreach my $combo ( @combinations ) {
            my $this_coin = formatCoin($coin, $count);
            push @output, join(" + ", $this_coin, $combo);
          }
        }
        else { # this is exact change!
          push @output, formatCoin($coin, $count);
        }
      }
    }
  }

  return @output;
}

sub solution($amount) {
  say 'Input: $amount = ' . $amount;
  my @ways = makeChange($amount);
  say 'Output: ' . scalar(@ways);
  say '';
  my $i = 0;
  foreach my $c ( @ways ) {
    $i++;
    say "$i: $c";
  }
}

say "Example 1:";
solution(9);

say "\nExample 2:";
solution(15);

say "\nExample 3:";
solution(100);
