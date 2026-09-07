#!/usr/bin/env perl
use v5.44;

sub rearrangeBinaryString($str ) {
  my @steps;
  while ($str !~ /^1+0+$/) {
    $str =~ s/01/10/g;
    push @steps, $str;
  }
  return scalar(@steps), @steps;
}

sub solution($str) {
  say 'Input: $str = "' . $str . '"';
  my ($count, @steps) = rearrangeBinaryString($str);
  say 'Output: ' . $count;
  if ($count) {
    say "";
    for my $i ( 1 .. $count ) {
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
