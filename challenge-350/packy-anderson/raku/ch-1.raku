#!/usr/bin/env raku
use v6;

sub goodString($str) {
  my $good = 0;
  for 0 .. $str.chars - 3 -> $i {
    my $substr = $str.substr($i..$i+2);
    my %bag = $substr.comb().Bag;
    $good++ unless %bag.values.any > 1;
  }
  return $good;
}

sub solution($str) {
  say 'Input: $str = "' ~ $str ~ '"';
  say 'Output: ' ~ goodString($str);
}

say "Example 1:";
solution("abcaefg");

say "\nExample 2:";
solution("xyzzabc");

say "\nExample 3:";
solution("aababc");

say "\nExample 4:";
solution("qwerty");

say "\nExample 5:";
solution("zzzaaa");
