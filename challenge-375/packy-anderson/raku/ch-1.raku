#!/usr/bin/env raku
use v6;

sub singleCommonCount(@array1, @array2) {
  my %bag1 = @array1.Bag.grep({ $_.value == 1 });
  my %bag2 = @array2.Bag.grep({ $_.value == 1 });
  (%bag1 ∩ %bag2).elems
}

sub quoteJoin(@array) {
  @array.map({ qq/"$_"/ }).join(", ")
}

sub solution(@array1, @array2) {
  say 'Input: @array1 = (' ~ quoteJoin(@array1) ~ ')';
  say '       @array2 = (' ~ quoteJoin(@array2) ~ ')';
  say 'Output: ' ~ singleCommonCount(@array1, @array2);
}

say "Example 1:";
solution(["apple", "banana", "cherry"],
         ["banana", "cherry", "date"]);

say "\nExample 2:";
solution(["a", "ab", "abc"],
         ["a", "a", "ab", "abc"]);

say "\nExample 3:";
solution(["orange", "lemon"],
         ["grape", "melon"]);

say "\nExample 4:";
solution(["test", "test", "demo"],
         ["test", "demo", "demo"]);

say "\nExample 5:";
solution(["Hello", "world"],
         ["hello", "world"]);
