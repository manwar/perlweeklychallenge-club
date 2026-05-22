#!/usr/bin/env raku
use v6;

sub checkSubstrings($str) {
  return [] unless $str ~~ m:i/
    <?before .*a><?before .*e><?before .*i><?before .*o>.*u.*
  /;
  my @output;
  @output.append($str);
  @output.append(checkSubstrings($str.substr(1)));
  @output.append(checkSubstrings($str.substr(0, *-1)));
  return @output.unique;
}

sub countVowel($str) {
  my @output;
  @output.append(checkSubstrings($_))
    for $str.split(/<-[aeiou]>/);
  return @output.sort;
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  my @output = countVowel($str);
  say 'Output: (' ~ @output.map({ qq/"$_"/ }).join(', ') ~ ')';
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
