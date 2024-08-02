#!/usr/bin/env perl
use v5.40;

sub twiceAppearance($str) {
  my @chars = split //, $str;
  my %count;
  foreach my $char ( @chars ) {
    $count{$char}++;
    return $char if $count{$char} > 1;
  }
  return "␀"; # fallback
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  my $char = twiceAppearance($str);
  say qq/Output: "$char"/;
}

say "Example 1:";
solution("acbddbca");

say "\nExample 2:";
solution("abccd");

say "\nExample 3:";
solution("abcdabbb");

say "\nExample 4:";
solution("abcdefg");
