#!/usr/bin/env perl
use v5.40;

use Memoize;
memoize('kolakoski');

sub kolakoski($int) {
  return "(1)" if $int == 1;
  my $digit = ($int % 2) ? "1" : "2";
  my $seq   = kolakoski($int - 1);
  (my $chars = $seq) =~ s/\D//g; # get rid of the parens
  if (substr($chars, $int - 1, 1) eq "1") {
    $seq .= "($digit)";
  }
  else {
    $seq .= "($digit$digit)";
  }
  return $seq;
}

sub kolakoskiSequence($int) {
  my $seq   = kolakoski($int);
  (my $chars = $seq) =~ s/\D//g; # get rid of the parens
  $chars = substr($chars, 0, $int);
  (my $countchars = $chars) =~ s/2//g; # get rid of 2s
  my $count = length($countchars);
  return ($count, "$seq => $chars");
}

sub solution($int) {
  say 'Input: $int = ' . $int;
  my ($count, $explain) = kolakoskiSequence($int);
  say "Output: $count\n\n$explain";
}

say "Example 1:";
solution(4);

say "\nExample 2:";
solution(5);

say "\nExample 3:";
solution(6);

say "\nExample 4:";
solution(7);

say "\nExample 5:";
solution(8);
