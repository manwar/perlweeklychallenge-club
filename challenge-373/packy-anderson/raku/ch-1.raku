#!/usr/bin/env raku
use v6;

sub equal_list(@arr1, @arr2) {
  return @arr1.join eq @arr2.join;
}

sub quoteList(@arr) {
  return @arr.map({qq/"$_"/}).join(", ");
}

sub solution(@arr1, @arr2) {
  say 'Input: @arr1 = (' ~ quoteList(@arr1) ~ ')';
  say '       @arr2 = (' ~ quoteList(@arr2) ~ ')';
  say 'Output: ' ~ equal_list(@arr1, @arr2);
}

say "Example 1:";
solution(["a", "bc"], ["ab", "c"]);

say "\nExample 2:";
solution(["a", "b", "c"], ["a", "bc"]);

say "\nExample 3:";
solution(["a", "bc"], ["a", "c", "b"]);

say "\nExample 4:";
solution(["ab", "c", ""], ["", "a", "bc"]);

say "\nExample 5:";
solution(["p", "e", "r", "l"], ["perl"]);
