#!/usr/bin/env perl
use v5.44;

use List::AllUtils qw( uniq );

sub dyckWords($n) {
  return ("")   if $n == 0; # base cases
  return ("UD") if $n == 1;
  
  my @new;
  for my $i (1 .. int($n / 2)) {
    for my $word1 (dyckWords($n - $i)) {
      for my $word2 (dyckWords($i)) {
        push @new, $word2 . $word1;
        push @new, $word1 . $word2;
        my $pre  = substr($word2, 0, $i);
        my $post = substr($word2, $i);
        push @new, $pre . $word1 . $post;
      }
    }
  }
  uniq sort @new;
}

use Text::Wrap;

sub solution($n) {
  say qq/Input: \$n = $n/;
  my $words = join ', ', map {qq/"$_"/} dyckWords($n);
  # wrap the list of words
  $Text::Wrap::columns = 70;
  $Text::Wrap::tabstop = 71; # no tabs
  $words = wrap('', ' ' x 9, $words);
  say 'Output: (' . $words . ')';
}

say "Example 1:";
solution(1);

say "\nExample 2:";
solution(2);

say "\nExample 3:";
solution(3);

say "\nExample 4:";
solution(0);

say "\nExample 5:";
solution(4);
