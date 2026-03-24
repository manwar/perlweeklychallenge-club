#!/usr/bin/env raku
use v6;

sub countPrefixes($str, @array is copy) {
  @array.grep({ ($str.index($_) // Inf) == 0 }).elems
}

sub solution($str, @array) {
  print 'Input: @array = ("' ~ @array.join('", "') ~ '"), ';
  say qq/\$str = "$str"/;
  say 'Output: ' ~ countPrefixes($str, @array);
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
