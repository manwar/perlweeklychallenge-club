#!/usr/bin/env raku
use v6;

sub divide($string, $div) {
  my $end = $string.chars - 1;
  return (
    $string.substr(0..$div),
    $string.substr($div+1..$end)
  );
}

sub scramble($source, $target) {
  # If the string consists of only one character,
  # return the string
  return $source if $source.chars == 1;

  # if the string equals the target we're seeking,
  # return the string
  return $source if $source eq $target;

  my ($s1, $s2, $t1, $t2);
  for 0 .. $source.chars - 2 -> $div {
    # Divide the string X into two non-empty parts
    ($s1, $s2) = divide($source, $div);
    ($t1, $t2) = divide($target, $div);

    # exchange the order of those parts unless one part
    # matches the target
    unless ($s1 eq $t1 || $s2 eq $t2) {
      ($s2, $s1) = ($s1, $s2);
      # adjust the target split as well
      ($t1, $t2) = divide($target, $s1.chars-1);
    }

    # scramble each of those parts unless all parts
    # match their targets
    ($s1, $s2) = (scramble($s1, $t1), scramble($s2, $t2))
      unless ($s1 eq $t1 && $s2 eq $t2);

    last if $s1 ~ $s2 eq $target;
  }
  # Concatenate the scrambled parts to return a single string.
  return $s1 ~ $s2;
}

sub is_scrambled($source, $target) {
  scramble($source, $target) eq $target;
}

sub solution($str1, $str2) {
  say qq{Input: \$str1 = "$str1", \$str2 = "$str2"};
  say 'Output: ' ~ is_scrambled($str1, $str2);
}

say "Example 1:";
solution("abc", "acb");

say "\nExample 2:";
solution("abcd", "cdba");

say "\nExample 3:";
solution("hello", "hiiii");

say "\nExample 4:";
solution("ateer", "eater");

say "\nExample 5:";
solution("abcd", "bdac");
