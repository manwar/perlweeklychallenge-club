#!/usr/bin/env perl
use v5.40;

sub replaceDigits($str) {
  my @chars = split //, $str;
  my $last_letter = $chars[0];
  my $out;
  foreach my $c ( @chars ) {
    if ($c =~ /[0-9]/) {
      $out .= chr( ord($last_letter) + $c );
    }
    else {
      $out .= $c;
      $last_letter = $c;
    }
  }
  return $out;
}

sub solution($str) {
  say "Input: \$str = '$str'";
  say 'Output: \'' . replaceDigits($str) . '\'';
}

say "Example 1:";
solution("a1c1e1");

say "\nExample 2:";
solution("a1b2c3d4");

say "\nExample 3:";
solution("b2b");

say "\nExample 4:";
solution("a16z");