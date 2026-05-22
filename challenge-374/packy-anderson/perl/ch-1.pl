#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw/ uniq /;

sub checkSubstrings($str) {
  return unless $str =~ /(?=.*a)(?=.*e)(?=.*i)(?=.*o).*u.*/i;
  my @output;
  push @output, $str;
  push @output, checkSubstrings(substr($str, 1));
  push @output, checkSubstrings(substr($str, 0, -1));
  return uniq @output;
}

sub countVowel($str) {
  my @output;
  push @output, checkSubstrings($_) for split /[^aeiou]+/, $str;
  return sort @output;
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  my @output = map { qq/"$_"/ } countVowel($str);
  say 'Output: (' . join(', ', @output) . ')';
}

say "Example 1:";
solution("aeiou");

say "\nExample 2:";
solution("aaeeeiioouu");

say "\nExample 3:";
solution("aeiouuaxaeiou");

say "\nExample 4:";
solution("uaeiou");

say "\nExample 5:";
solution("aeioaeioa");
