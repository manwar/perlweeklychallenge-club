#!/usr/bin/env perl
use v5.40;

sub longestParen($str) {
  my @found;
  for my $start (0 .. length($str) - 2) {
    my $count = 0;
    for my $end ($start .. length($str) - 1) {
      my $c = substr($str, $end, 1);
      my $substring = substr($str, $start, $end-$start+1);
      if ($c eq "(") {
        $count++;
      }
      else {
        $count--;
      }
      # unbalanced left paren
      last if $count < 0;
      # we have exactly as many right parens as we've seen left
      push @found, $substring if $count == 0;
    }
    # if we've reached the end of $str and we're at 0,
    # any valid paren strings we find in subsequent outer loop
    # iterations will be substrings
    last if $count == 0;
  }
  return length((sort { length($a) <=> length($b) } @found)[-1]);
}

sub solution($str) {
  say "Input: \$str = '$str'";
  say "Output: " . longestParen($str);
}

say "Example 1:";
solution("(()())");

say "\nExample 2:";
solution(")()())");

say "\nExample 3:";
solution("((()))()(((()");

say "\nExample 4:";
solution("))))((()(");

say "\nExample 5:";
solution("()(()");