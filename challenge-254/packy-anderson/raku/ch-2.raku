#!/usr/bin/env raku
use v6;

sub reverseVowels($s) {
  # split string into letters
  my @letters = $s.split('', :skip-empty);

  # find the vowels
  my @vowels = @letters.grep({ /:i<[aeiou]>/ });

  # replace each vowel in reverse order, converting
  # any uppercase letters to lowercase
  for 0 .. @letters.end -> $i {
    if (@letters[$i] ~~ /:i<[aeiou]>/) {
      @letters[$i] = @vowels.pop.lc;
    }
  }

  # rejoin the array as a string, title casing it
  return tc(@letters.join(''));
}

sub solution($s) {
  say 'Input: $s = "' ~ $s ~ '"';
  say 'Output: "' ~ reverseVowels($s) ~ '"';
}

say "Example 1:";
solution("Raku");

say "\nExample 2:";
solution("Perl");

say "\nExample 3:";
solution("Julia");

say "\nExample 4:";
solution("Uiua");