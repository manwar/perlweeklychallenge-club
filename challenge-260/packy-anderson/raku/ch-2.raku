#!/usr/bin/env raku
use v6;

sub dictionaryRank($word) {
  # split the string into an array of characters
  my @letters = $word.split('', :skip-empty);

  # find the permutations of the letters
  my @perms;
  for @letters.permutations -> @l {
    @perms.append(@l.join(''));
  }

  # find where in the sorted list of
  # UNIQUE permutations the word is
  my $rank = 1;
  for @perms.unique.sort -> $p {
    return $rank if $p eq $word;
    $rank++;
  }
}

sub solution($word) {
  say q{Input: $word = '} ~ $word ~ q{'};
  say 'Output: ' ~ dictionaryRank($word);
}

say "Example 1:";
solution('CAT');

say "\nExample 2:";
solution('GOOGLE');

say "\nExample 3:";
solution('SECRET');
