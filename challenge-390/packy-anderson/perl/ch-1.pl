#!/usr/bin/env perl
use v5.44;

sub decodeString($str) {
  while ($str =~ m/((\d+)\[([^\[\]]+)\])/) {
    my $r = $3 x $2;
    my $m = quotemeta($1);
    $str =~ s/$m/$r/;
  }
  $str
}

sub solution($str) {
  say 'Input: $str = "' . $str . '"';
  say 'Output: "' . decodeString($str) . '"';
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

