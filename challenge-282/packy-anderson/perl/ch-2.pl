#!/usr/bin/env perl
use v5.40;

sub keyChanges($str) {
  my @chars = split //, $str;
  my $char  = shift @chars;
  my $changes = 0;
  while (my $next = shift @chars) {
    next if lc($char) eq lc($next);
    $changes++;
    $char = $next;
  }
  return $changes;
}

sub solution($str) {
  say "Input: \$str = '$str'";
  say 'Output: ' . keyChanges($str);
}

say "Example 1:";
solution("pPeERrLl");

say "\nExample 2:";
solution("rRr");

say "\nExample 3:";
solution("GoO");
