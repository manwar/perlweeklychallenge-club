#!/usr/bin/env perl
use v5.40;

use List::MoreUtils qw( frequency );
use Set::Scalar;

sub singleSet(@array) {
  my %bag = frequency @array;
  Set::Scalar->new( grep { $bag{$_} == 1 } keys %bag );
}

sub singleCommonCount($array1, $array2) {
  singleSet(@$array1)->intersection(singleSet(@$array2))->size;
}

sub quoteJoin(@array) {
  join(", ", map { qq/"$_"/ } @array)
}

sub solution($array1, $array2) {
  say 'Input: @array1 = (' . quoteJoin(@$array1) . ')';
  say '       @array2 = (' . quoteJoin(@$array2) . ')';
  say 'Output: ' . singleCommonCount($array1, $array2);
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
