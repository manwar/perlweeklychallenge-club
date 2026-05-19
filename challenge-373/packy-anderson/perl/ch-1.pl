#!/usr/bin/env perl
use v5.40;

sub equal_list($arr1, $arr2) {
  return join('', @$arr1) eq join('', @$arr2) ? 'true' : 'false';
}

sub quoteList(@arr) {
  return join(", ", map { qq/"$_"/ } @arr);
}

sub solution($arr1, $arr2) {
  say 'Input: @arr1 = (' . quoteList(@$arr1) . ')';
  say '       @arr2 = (' . quoteList(@$arr2) . ')';
  say 'Output: ' . equal_list($arr1, $arr2);
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
