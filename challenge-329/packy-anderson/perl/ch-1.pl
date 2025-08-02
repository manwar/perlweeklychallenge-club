#!/usr/bin/env perl
use v5.40;

sub counterIntegers($str) {
  # replace all lower case letters with space
  $str =~ s/\p{Lowercase_Letter}+/ /g;

  # get rid of leading and trailing whitespace
  $str =~ s/^\s+|\s+$//g;

  # split on whitespace
  my @parts = split /\s+/, $str;

  # build return array of distinct values 
  my @output;
  my %seen;
  foreach my $i ( @parts ) {
    push @output, $i unless exists $seen{$i};
    $seen{$i}++;
  }

  return @output;
}

sub solution($str) {
  say qq{Input: \$str = "$str"};
  say 'Output: ' . join(', ', counterIntegers($str));
}

say "Example 1:";
solution("the1weekly2challenge2");

say "\nExample 2:";
solution("go21od1lu5c7k");

say "\nExample 3:";
solution("4p3e2r1l");
