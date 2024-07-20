#!/usr/bin/env perl
use v5.40;

sub reverseWord($str, $char) {
  my $pos = index($str, $char);

  # if the character isn't in the string, do nothing
  return $str unless $pos >= 0;

  my @parts = (
    substr($str, 0, $pos+1),
    substr($str, $pos+1)
  );

  $parts[0] = join(q{}, sort split //, $parts[0]);

  return join(q{}, @parts);
}

sub solution($str, $char) {
  say qq{Input: \$str = "$str", \$char = "$char"};
  say 'Output: "' . reverseWord($str, $char) . '"';
}

say "Example 1:";
solution("challenge", "e");

say "\nExample 2:";
solution("programming", "a");

say "\nExample 3:";
solution("champion", "b");
