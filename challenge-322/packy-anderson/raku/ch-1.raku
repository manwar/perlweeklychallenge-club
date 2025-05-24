#!/usr/bin/env raku
use v6;

sub strFormat($str is copy, $i) {
  $str = $str.subst("-", :g);
  my $output = '';
  while ($str.chars > $i) {
    $output = "-" ~ $str.substr(*-$i) ~ $output;
    $str.substr-rw(*-$i) = '';
  }
  $output = $str ~ $output;
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