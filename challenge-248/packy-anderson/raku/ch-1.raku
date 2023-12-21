#!/usr/bin/env raku
use v6;

sub shortestDistance($str, $char) {
  # split the string into an array of characters
  my @strchar = $str.split('', :skip-empty);
  # find the positions of the target $char
  my @pos = (0 .. @strchar.end).grep: { @strchar[$_] eq $char };
  
  my @output;
  for 0 .. @strchar.end -> $i {
    # find the distances
    my @distance = @pos.map: { abs($i - $_) };
    # find the minimum distance
    @output.push( @distance.min );
  }
  return @output;
}

sub solution($str, $char) {
  say qq{Input: \$str = "$str", \$char = "$char"};
  my @output = shortestDistance($str, $char);
  say 'Output: (' ~ @output.join(',') ~ ')';
}

say "Example 1:";
solution("loveleetcode", "e");

say "\nExample 2:";
solution("aaab", "b");
