#!/usr/bin/env raku
use v6;

sub powerString($str) {
  my $longest = 0;
  my @chars   = $str.comb;
  my $last    = @chars.shift;
  my $count   = 1;
  for @chars -> $current {
    if ($current eq $last) { # same as last char
      $count++;
    }
    else { # character has changed
      if ($count > $longest) {
        $longest = $count;
      }
      $count = 1;
      $last  = $current;
    }
  }
  if ($count > $longest) { # last sequence is longest
    $longest = $count;
  }
  return $longest;
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say 'Output: ' ~ powerString($str);
}

say "Example 1:";
solution("textbook");

say "\nExample 2:";
solution("aaaaa");

say "\nExample 3:";
solution("hoorayyy");

say "\nExample 4:";
solution("x");

say "\nExample 5:";
solution("aabcccddeeffffghijjk");
