#!/usr/bin/env perl
use v5.40;

sub my_zip($longer, $shorter, $str) {
  $str .= shift(@$longer) . shift(@$shorter);
  if (@$shorter) {
    return my_zip($longer, $shorter, $str);
  }
  elsif (@$longer) {
    $str .= shift(@$longer);
  }
  return $str;
}

sub balance_str($str) {
  my @letters = sort grep { /[a-z]/ } split //, $str;
  my @numbers = sort grep { /\d/    } split //, $str;

  return "" if abs(@letters - @numbers) > 1;
  if (@letters > @numbers) {
    return my_zip(\@letters, \@numbers, "");
  }
  else {
    return my_zip(\@numbers, \@letters, "");
  }
}

sub solution($str) {
  say 'Input: $str = "' . $str . '"';
  say 'Output: "' . balance_str($str) . '"';
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
