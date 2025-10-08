#!/usr/bin/env raku
use v6;

multi my_zip([], [], $str) { $str }

multi my_zip(@longer, [], $str) {
  $str ~ @longer.shift
}

multi my_zip(@longer, @shorter, $str is copy) {
  $str ~= @longer.shift ~ @shorter.shift;
  my_zip(@longer, @shorter, $str);
}

sub balance_str($str) {
  my @letters = $str.comb(/<[a..z]>/).sort;
  my @numbers = $str.comb(/\d/).sort;

  return "" if abs(@letters - @numbers) > 1;
  if (@letters > @numbers) {
    return my_zip(@letters, @numbers, "");
  }
  else {
    return my_zip(@numbers, @letters, "");
  }
}

sub solution($str) {
  say 'Input: $str = "' ~ $str ~ '"';
  say 'Output: "' ~ balance_str($str) ~ '"';
}

say "Example 1:";
solution("a0b1c2");

say "\nExample 2:";
solution("abc12");

say "\nExample 3:";
solution("0a2b1c3");

say "\nExample 4:";
solution("1a23");

say "\nExample 5:";
solution("ab123");
