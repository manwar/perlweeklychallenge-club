#!/usr/bin/env raku
use v6;

sub occursOnce($line) {
  # create a Bag of all words
  my $all = $line.comb(/\w+/).Bag;
  # create a list of words that occur once in the Bag
  return $all.keys.grep({ $all{$_} == 1 });
}

sub uncommonWords($line1, $line2) {
  # create a Bag of words that occur once in each line
  my $all = occursOnce($line1).Bag ⊎ occursOnce($line2).Bag;
  # return a list of words that occur once in that Bag
  return $all.keys.grep({ $all{$_} == 1 });
}

sub solution($line1, $line2) {
  say "Input: \$line1 = '$line1'";
  say "       \$line2 = '$line2'";
  my @results = uncommonWords($line1, $line2);
  say "Output: ('" ~ @results.join("', '") ~ "')";
}

say "Example 1:";
solution('Mango is sweet', 'Mango is sour');

say "\nExample 2:";
solution('Mango Mango', 'Orange');

say "\nExample 3:";
solution('Mango is Mango', 'Orange is Orange');
