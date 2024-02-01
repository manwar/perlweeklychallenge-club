#!/usr/bin/env perl
use v5.38;

sub reverseVowels($s) {
  # split string into letters
  my @letters = split(//, $s);

  # find the vowels
  my @vowels = grep { /[aeiou]/i } @letters;

  # replace each vowel in reverse order, converting
  # any uppercase letters to lowercase
  foreach my $i ( 0 .. $#letters) {
    if ($letters[$i] =~ /[aeiou]/i) {
      $letters[$i] = lc(pop @vowels);
    }
  }

  # rejoin the array as a string, title casing it
  return ucfirst(join('', @letters));
}

sub solution($s) {
  say 'Input: $s = "' . $s . '"';
  say 'Output: "' . reverseVowels($s) . '"';
}

say "Example 1:";
solution("Raku");

say "\nExample 2:";
solution("Perl");

say "\nExample 3:";
solution("Julia");

say "\nExample 4:";
solution("Uiua");