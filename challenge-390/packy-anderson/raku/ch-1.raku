#!/usr/bin/env raku
use v6;

sub decodeString($str is copy) {
  while (my $match = $str ~~ m:g/(\d+)\[(<-[\[\]]>+)\]/) {
    for $match.list -> $m {
      my $r = $m[1] x $m[0];
      $str ~~ s/$m/$r/;
    }
  }
  $str
}

sub solution($str) {
  say 'Input: $str = "' ~ $str ~ '"';
  say 'Output: "' ~ decodeString($str) ~ '"';
}

say "Example 1:";
solution("2[3[a]]");

say "\nExample 2:";
solution("10[a]");

say "\nExample 3:";
solution("a2[b]c3[d]e");

say "\nExample 4:";
solution("2[a2[b]c]");

say "\nExample 5:";
solution("1[a]2[b3[c]]");
