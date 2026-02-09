#!/usr/bin/env perl
use v5.40;

sub rotN($str, $n) {
  $n = $n % 26; # 0 <= n < 26
  my $orig = join '', 'a'..'z';
  my $shifted = substr($orig, $n, 26) . substr($orig, 0, $n);
  return eval "\$str =~ tr/$orig/$shifted/r";
}

sub solution($str, $int) {
  say qq/Input: \$str = "$str", \$int = $int/;
  say qq/Output: "@{[rotN($str, $int)]}"/;
}

say "Example 1:";
solution("abc", 1);

say "\nExample 2:";
solution("xyz", 2);

say "\nExample 3:";
solution("abc", 27);

say "\nExample 4:";
solution("hello", 5);

say "\nExample 5:";
solution("perl", 26);
