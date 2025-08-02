#!/usr/bin/env perl
use v5.38;

sub occursOnce($line) {
  # create a hash counting the words
  my %all;
  $all{$_}++ for split(/\s+/, $line);
  # create a list of words that occur once in the hash
  return grep { $all{$_} == 1 } keys %all;
}

sub uncommonWords($line1, $line2) {
  return occursOnce(
    join(' ', occursOnce($line1), occursOnce($line2))
  );
}

sub solution($line1, $line2) {
  say "Input: \$line1 = '$line1'";
  say "       \$line2 = '$line2'";
  my @results = uncommonWords($line1, $line2);
  say "Output: ('" . join("', '",@results) . "')";
}

say "Example 1:";
solution('Mango is sweet', 'Mango is sour');

say "\nExample 2:";
solution('Mango Mango', 'Orange');

say "\nExample 3:";
solution('Mango is Mango', 'Orange is Orange');
