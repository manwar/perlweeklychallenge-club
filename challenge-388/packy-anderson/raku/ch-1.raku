#!/usr/bin/env raku
use v6;

sub dyckWords($n) {
  return [""]   if $n == 0; # base cases
  return ["UD"] if $n == 1;
  
  my @new;
  for (1 .. ($n div 2)) -> $i {
    for dyckWords($n - $i) -> $word1 {
      for dyckWords($i) -> $word2 {
        @new.push($word2 ~ $word1);
        @new.push($word1 ~ $word2);
        my $pre  = $word2.substr(0, $i);
        my $post = $word2.substr($i);
        @new.push($pre ~ $word1 ~ $post);
      }
    }
  }
  @new.sort.unique;
}

use Text::Wrap;

sub solution($n) {
  say qq/Input: \$n = $n/;
  my $words = dyckWords($n).map({qq/"$_"/}).join(', ');
  # wrap the list of words
  $words = wrap-text($words, :width(70), :prefix(' ' x 9));
  $words ~~ s/^\s+//; # trim initial leading whitespace
  say 'Output: (' ~ $words ~ ')';
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
