#!/usr/bin/env perl
use v5.40;

sub countPrefixes($str, @array) {
  scalar(grep { index($str, $_) == 0 } @array)
}

sub solution($str, $array) {
  print 'Input: @array = ("' . join('", "', @$array) . '"), ';
  say qq/\$str = "$str"/;
  say 'Output: ' . countPrefixes($str, @$array);
}

say "Example 1:";
solution("apple", ["a", "ap", "app", "apple", "banana"]);

say "\nExample 2:";
solution("bird", ["cat", "dog", "fish"]);

say "\nExample 3:";
solution("hello", ["hello", "he", "hell", "heaven", "he"]);

say "\nExample 4:";
solution("coding", ["", "code", "coding", "cod"]);

say "\nExample 5:";
solution("program", ["p", "pr", "pro", "prog", "progr", "progra", "program"]);
