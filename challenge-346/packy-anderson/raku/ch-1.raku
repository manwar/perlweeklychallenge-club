#!/usr/bin/env raku
use v6;

sub longestParen($str) {
  my @found;
  for 0..$str.chars-2 -> $start {
    my $count = 0;
    for $start..$str.chars-1 -> $end {
      my $c = $str.substr($end, 1);
      my $substring = $str.substr($start..$end);
      if ($c eq "(") {
        $count++;
      }
      else {
        $count--;
      }
      # unbalanced left paren
      last if $count < 0;
      # we have exactly as many right parens as we've seen left
      @found.push($substring) if $count == 0;
    }
    # if we've reached the end of $str and we're at 0,
    # any valid paren strings we find in subsequent outer loop
    # iterations will be substrings
    last if $count == 0;
  }
  return (@found.sort: *.chars)[*-1].chars;
}

sub solution($str) {
  say "Input: \$str = '$str'";
  say "Output: " ~ longestParen($str);
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
