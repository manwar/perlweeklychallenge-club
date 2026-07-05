#!/usr/bin/env raku
use v6;

sub reversedPos($char) {
  "zyxwvutsrqponmlkjihgfedcba".index($char) + 1;
}

sub reverseDegree($str) {
  my @chars = $str.comb;
  my $sum = 0;
  for 0..@chars.end -> $i {
    $sum += (reversedPos(@chars[$i]) * ($i+1));
  }
  $sum;
}

sub solution($str) {
  say 'Input: $str = "' ~ $str ~ '"';
  say 'Output: ' ~ reverseDegree($str);
}

say "Example 1:";
solution("z");

say "\nExample 2:";
solution("a");

say "\nExample 3:";
solution("bbc");

say "\nExample 4:";
solution("racecar");

say "\nExample 5:";
solution("zyx");
