#!/usr/bin/env raku
use v6;

sub reverseWord($str, $char) {
  my $pos = $str.index($char);

  # if the character isn't in the string, do nothing
  return $str unless $pos.defined;

  my @parts = (
    substr($str, 0, $pos+1),
    substr($str, $pos+1)
  );

  @parts[0] = @parts[0].comb.sort.join;

  return @parts.join;
}

sub solution($str, $char) {
  say qq{Input: \$str = "$str", \$char = "$char"};
  say 'Output: "' ~ reverseWord($str, $char) ~ '"';
}

say "Example 1:";
solution("challenge", "e");

say "\nExample 2:";
solution("programming", "a");

say "\nExample 3:";
solution("champion", "b");
