#!/usr/bin/env perl
use v5.40;

use POSIX qw(round);

sub charPercent($str, $char) {
  my $char_cnt = scalar( grep { $_ eq $char } split //, $str );
  return round( ($char_cnt / length($str)) * 100 );
}

sub solution($str, $char) {
  say qq{Input: \$str = "$str", \$char = "$char"};
  say 'Output: ' . charPercent($str, $char);
}

say "Example 1:";
solution("perl", "e");

say "\nExample 2:";
solution("java", "a");

say "\nExample 3:";
solution("python", "m");

say "\nExample 4:";
solution("ada", "a");

say "\nExample 5:";
solution("ballerina", "l");

say "\nExample 6:";
solution("analitik", "k");
