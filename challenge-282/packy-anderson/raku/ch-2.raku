#!/usr/bin/env raku
use v6;

sub keyChanges($str) {
  my @chars = $str.comb;
  my $char  = @chars.shift;
  my $changes = 0;
  while (my $next = @chars.shift) {
    next if lc($char) eq lc($next);
    $changes++;
    $char = $next;
  }
  return $changes;
}

sub solution($str) {
  say "Input: \$str = '$str'";
  say 'Output: ' ~ keyChanges($str);
}

say "Example 1:";
solution("pPeERrLl");

say "\nExample 2:";
solution("rRr");

say "\nExample 3:";
solution("GoO");
