#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( pairs mesh );

sub validTag($caption) {
  my @words   = split(" ", $caption =~ s/[^a-zA-Z\s]//gr);
  my @indices = 0 .. $#words;
  my @meshed  = mesh @indices, @words;
  substr(
    '#' . join('',
      map { $_->key ? ucfirst(lc($_->value)) : lc($_->value) }
      pairs @meshed
    ),
    0, 100
  );
}

sub solution($caption) {
  say qq/Input: \$caption = "$caption"/;
  say qq/Output: "@{[validTag($caption)]}"/;
}

say "Example 1:";
solution("Cooking with 5 ingredients!");

say "\nExample 2:";
solution("the-last-of-the-mohicans");

say "\nExample 3:";
solution("  extra spaces here");

say "\nExample 4:";
solution("iPhone 15 Pro Max Review");

say "\nExample 5:";
solution("Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!");
