#!/usr/bin/env perl
use v5.40;

sub strFormat($str, $i) {
  $str =~ s/\-//g;
  my $output = '';
  while (length($str) > $i) {
    $output = "-" . substr($str, -$i) . $output;
    substr($str, -$i) = '';
  }
  $output = $str . $output;
}

sub solution($str, $i) {
  say qq[Input: \$str = "$str", \$i = $i];
  my $output = strFormat($str, $i);
  say qq[Output: "$output"];
}

say "Example 1:";
solution("ABC-D-E-F", 3);

say "\nExample 2:";
solution("A-BC-D-E", 2);

say "\nExample 3:";
solution("-A-B-CD-E", 4);

say "\nExample 4:";
solution("-A-B-CD-E", 5);