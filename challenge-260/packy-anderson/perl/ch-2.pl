#!/usr/bin/env perl
use v5.38;

use Algorithm::Combinatorics qw( permutations );
use List::Util qw( uniq );

sub dictionaryRank($word) {
  # split the string into an array of characters
  my @letters = split //, $word;

  # find the permutations of the letters
  my @perms;
  foreach my $l ( permutations(\@letters) ) {
    push @perms, join('', @$l);
  }

  # find where in the sorted list of
  # UNIQUE permutations the word is
  my $rank = 1;
  foreach my $p ( sort { $a cmp $b } uniq @perms ) {
    return $rank if $p eq $word;
    $rank++;
  }
}

sub solution($word) {
  say q{Input: $word = '} . $word . q{'};
  say 'Output: ' . dictionaryRank($word);
}

say "Example 1:";
solution('CAT');

say "\nExample 2:";
solution('GOOGLE');

say "\nExample 3:";
solution('SECRET');
