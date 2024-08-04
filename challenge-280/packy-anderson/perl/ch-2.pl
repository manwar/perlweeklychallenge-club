#!/usr/bin/env perl
use v5.40;

sub countAsterisks($str) {
  (my $excluded = $str) =~ s/\|[^|]*\|//g;
  my %count;
  map { $count{$_}++ } split //, $excluded;
  return 0 unless exists $count{"*"};
  return $count{"*"};
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  my $count = countAsterisks($str);
  say qq/Output: $count/;
}

say "Example 1:";
solution("p|*e*rl|w**e|*ekly|");

say "\nExample 2:";
solution("perl");

say "\nExample 3:";
solution("th|ewe|e**|k|l***ych|alleng|e");
