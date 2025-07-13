#!/usr/bin/env raku
use v6;

sub counterIntegers($str is copy) {
  # replace all lower case letters with space
  $str ~~ s:g/<lower>+/ /;

  # get rid of leading and trailing whitespace
  $str.=trim;

  # split on whitespace
  my @parts = $str.split(/\s+/);

  # build return array of distinct values 
  my @output;
  my $seen = BagHash.new;
  for @parts -> $i {
    @output.push($i) if $i ∉ $seen;
    $seen{$i}++;
  }

  return @output;
}

sub solution($str) {
  say qq{Input: \$str = "$str"};
  say 'Output: ' ~ counterIntegers($str).join(', ');
}

say "Example 1:";
solution("the1weekly2challenge2");

say "\nExample 2:";
solution("go21od1lu5c7k");

say "\nExample 3:";
solution("4p3e2r1l");
