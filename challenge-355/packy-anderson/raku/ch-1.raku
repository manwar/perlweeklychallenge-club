#!/usr/bin/env raku
use v6;

sub thousandSeparator($int) {
  $int.Str                # convert int to string
      .comb               # break the string into list of chars
      .reverse            # reverse the list
      .rotor(3, :partial) # return a sequence of 3 element lists
      .join(",")          # join the lists with commas
      .comb(/\S/)         # break the string back into chars
      .reverse            # reverse the list again
      .join;              # join them back into a string
}

sub solution($int) {
  say 'Input: $int = ' ~ $int;
  say 'Output: "' ~ thousandSeparator($int) ~ '"';
}

say "Example 1:";
solution(123);

say "\nExample 2:";
solution(1234);

say "\nExample 3:";
solution(1000000);

say "\nExample 4:";
solution(1);

say "\nExample 5:";
solution(12345);
