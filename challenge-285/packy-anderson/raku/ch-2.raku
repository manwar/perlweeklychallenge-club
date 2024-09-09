#!/usr/bin/env raku
use v6;

use experimental :cached;

# establish the values of the coins
my %types = 50 => 'HD', 25 => 'Q', 10 => 'D', 5 => 'N', 1 => 'P';

# make a sorted list of coin values
my @values = %types.keys.sort(*.Int);

# handle formatting coins to not display the number 1
sub formatCoin($coin, $count) {
  return ( ($count == 1 ?? "" !! $count) ~ $coin );
}

sub makeChange($amount, $exclude = 0) is cached {
  my @output;
  for @values.reverse -> $value {
    # if this type of coin is worth more
    # than the total, we can't use it
    next if $value > $amount;

    # if we're excluding this coin value or greater, skip it
    next if $exclude && $value >= $exclude;

    my $coin = %types{$value}; # get the coin name

    if ($value == 1) {
      # pennies are easy!
      @output.push( formatCoin($coin, $amount) );
    }
    else {
      # loop from max number of this coin we can use down to 1
      for Int($amount / $value) ... 1 -> $count {
        # figure out how much change we need after we've used
        # $count many of coin $coin
        my $left = $amount - ($count * $value);

        if ($left > 0) { # we need more change
          # make a recursive call to get the combinations
          # for that remaining amount, excluding any coins
          # of equal or greater value to $value
          my @combinations = makeChange($left, $value);
          for @combinations -> $combo {
            my $this_coin = formatCoin($coin, $count);
            @output.push([$this_coin, $combo].join(" + "));
          }
        }
        else { # this is exact change!
          @output.push( formatCoin($coin, $count) );
        }
      }
    }
  }

  return @output;
}

sub solution($amount) {
  say 'Input: $amount = ' ~ $amount;
  my @ways = makeChange($amount);
  say 'Output: ' ~ @ways.elems;
  say '';
  for @ways.kv -> $i, $c {
    my $i2 = $i + 1;
    say "$i2: $c";
  }
}

say "Example 1:";
solution(9);

say "\nExample 2:";
solution(15);

say "\nExample 3:";
solution(100);
