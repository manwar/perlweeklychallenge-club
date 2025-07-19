#!/usr/bin/env perl
use v5.40;

sub titleCapital($str) {
  my @out = split " ", lc($str); # separated by a SINGLE space
  foreach my $word ( @out ) { # mods to $word change @out
    $word = ucfirst($word) if length($word) > 2;
  }
  return join(" ", @out);
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say qq/Output: "@{[titleCapital($str)]}"/;
}

say "Example 1:";
solution("PERL IS gREAT");

say "\nExample 2:";
solution("THE weekly challenge");

say "\nExample 3:";
solution("YoU ARE A stAR");
