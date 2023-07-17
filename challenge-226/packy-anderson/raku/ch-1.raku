#!/usr/bin/env raku

sub shuffle_string ($string, @indices) {
  my @chars = $string.split("", :skip-empty);
  my @result;
  for @indices -> $index {
    my $char = shift @chars;   # get the next character
    @result[$index] = $char;   # put the character at that index in the result
  }
  say "Input: \$string = '$string', \@indices = (" ~ @indices.join(',') ~ ")";
  say "Output: '" ~ @result.join('') ~ "'";
}

say "Task 1: Shuffle String";
say "\nExample 1";
shuffle_string('lacelengh', (3,2,0,5,4,8,6,7,1));
say "\nExample 2";
shuffle_string('rulepark', (4,7,3,1,0,5,2,6));
