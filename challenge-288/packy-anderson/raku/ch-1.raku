#!/usr/bin/env raku
use v6;

sub isPalindrome($num) {
  # convert numerics to Strings, then reverse one of them
  return $num.Str eq $num.Str.flip;
}

sub closestPalindrome($str) {
  my $num = $str.Int; # convert string to Integer
  my $distance = 1;
  while (True) {
    # is the smaller number at this distance a palindrome?
    if (isPalindrome($num - $distance)) {
      return( ($num - $distance).Str );
    }
    # is the larger number at this distance a palindrome?
    if (isPalindrome($num + $distance)) {
      return( ($num + $distance).Str );
    }
    # step 1 number futher away
    $distance++;
  }
}

sub solution($str) {
  say "Input: \$str = \"$str\"";
  my $closest = closestPalindrome($str);
  say "Output:  \"$closest\"";
}

say "Example 1:";
solution("123");

say "\nExample 2:";
solution("2");

say "\nExample 3:";
solution("1400");

say "\nExample 4:";
solution("1001");

say "\nExample 5: (it doesn't say the input is a POSITIVE int)";
solution("-1");
