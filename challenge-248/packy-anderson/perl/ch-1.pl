#!/usr/bin/env perl
use v5.38;

use List::Util qw( min );

sub shortestDistance($str, $char) {
  # split the string into an array of characters
  my @strchar = split(//, $str);
  # find the positions of the target $char
  my @pos = grep { $strchar[$_] eq $char } 0 .. $#strchar;
  
  my @output;
  foreach my $i ( 0 .. $#strchar ) {
    # find the distances
    my @distance = map { abs($i - $_) } @pos;
    # find the minimum distance
    push @output, min(@distance);
  }
  return @output;
}

sub solution($str, $char) {
  say qq{Input: \$str = "$str", \$char = "$char"};
  my @output = shortestDistance($str, $char);
  say 'Output: (' . join(',', @output) . ')';
}

say "Example 1:";
solution("loveleetcode", "e");

say "\nExample 2:";
solution("aaab", "b");