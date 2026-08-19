#!/usr/bin/env raku
use v6;

sub rearrangeBinaryString($str is copy) {
  my @steps;
  while ($str !~~ /^1+0+$/) {
    $str ~~ s:g/01/10/;
    @steps.push($str);
  }
  return @steps.elems, @steps;
}

sub solution($str) {
  say 'Input: $str = "' ~ $str ~ '"';
  my ($count, $steps) = rearrangeBinaryString($str);
  say 'Output: ' ~ $count;
  if ($count) {
    say "";
    for 1..$count -> $i {
      say qq/Step $i: "$steps[$i-1]"/;
    }
  }
}

say "Example 1:";
solution("111000");

say "\nExample 2:";
solution("00011");

say "\nExample 3:";
solution("01011");

say "\nExample 4:";
solution("010101");

say "\nExample 5:";
solution("00001");
