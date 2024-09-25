#!/usr/bin/env perl
use v5.40;

sub isPalindrome($num) {
  # convert numerics to Strings, then reverse one of them
  return "$num" eq reverse "$num";
}

sub closestPalindrome($str) {
  my $num = $str + 0; # convert string to Integer
  my $distance = 1;
  while (true) {
    # is the smaller number at this distance a palindrome?
    if (isPalindrome($num - $distance)) {
      return( ($num - $distance) );
    }
    # is the larger number at this distance a palindrome?
    if (isPalindrome($num + $distance)) {
      return( ($num + $distance) );
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
