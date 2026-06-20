#!/usr/bin/env raku
use v6;

sub sumOfWords($str1, $str2, $str3) {
  my $width = max($str1.chars, $str2.chars, $str3.chars);
  my $num1 = $str1.trans(['a'..'j'] => [0..9]);
  my $num2 = $str2.trans(['a'..'j'] => [0..9]);
  my $num3 = $str3.trans(['a'..'j'] => [0..9]);
  return(
    $num1 + $num2 == $num3,
    sprintf(
      "\$str1 = %*s = %*s\n" ~
      "\$str2 = %*s = %*s\n" ~
      "\$str3 = %*s = %*s",
      $width+2, qq/"$str1"/, $width, $num1,
      $width+2, qq/"$str2"/, $width, $num2,
      $width+2, qq/"$str3"/, $width, $num3,
    )
  );
}

sub solution($str1, $str2, $str3) {
  say qq/Input: \$str1 = "$str1", \$str2 = "$str2", /
    ~ qq/\$str3 = "$str3"/;
  my ($result, $explain) = sumOfWords($str1, $str2, $str3);
  say qq/Output: $result\n\n$explain/;
}

say "Example 1:";
solution("acb", "cba", "cdb");

say "\nExample 2:";
solution("aab", "aac", "ad");

say "\nExample 3:";
solution("bc", "je", "jg");

say "\nExample 4:";
solution("a", "aaaa", "aa");

say "\nExample 5:";
solution("c", "d", "h");

say "\nExample 6:";
solution("gfi", "hbf", "bdhd");
