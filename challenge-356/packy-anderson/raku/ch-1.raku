#!/usr/bin/env raku
use v6;

use experimental :cached;

sub kolakoski($int) is cached {
  return "(1)" if $int == 1;
  my $digit = ($int % 2) ?? "1" !! "2";
  my $seq   = kolakoski($int - 1);
  my $chars = $seq.comb(/\d/).join(""); # get rid of the parens
  if (substr($chars, $int - 1, 1) eq "1") {
    $seq ~= "($digit)";
  }
  else {
    $seq ~= "($digit$digit)";
  }
  return $seq;
}

sub kolakoskiSequence($int) {
  my $seq   = kolakoski($int);
  my $chars = $seq.comb(/\d/).join("").substr(0, $int);
  my $count = $chars.comb(/1/).elems;
  return ($count, "$seq => $chars");
}

sub solution($int) {
  say 'Input: $int = ' ~ $int;
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
