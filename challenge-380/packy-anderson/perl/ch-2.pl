#!/usr/bin/env perl
use v5.40;

sub reversedPos($char) {
  index("zyxwvutsrqponmlkjihgfedcba", $char) + 1;
}

sub reverseDegree($str) {
  my @chars = split //, $str;
  my $sum = 0;
  for my $i ( 0 .. $#chars ) {
    $sum += (reversedPos($chars[$i]) * ($i+1));
  }
  $sum;
}

sub solution($str) {
  say 'Input: $str = "' . $str . '"';
  say 'Output: ' . reverseDegree($str);
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
