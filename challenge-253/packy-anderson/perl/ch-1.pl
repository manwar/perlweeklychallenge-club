#!/usr/bin/env perl
use v5.38;

sub splitOnSeparator($separator, @words) {
  my @output;
  foreach my $str ( @words ) {
    push @output, grep { !/^$/ } split(/\Q$separator/, $str);
  }
  return @output;
}

sub solution($separator, @words) {
  say 'Input: @words = ("' . join("', '", @words) . '")';
  say '       $separator = "' . $separator . '"';
  my @output = splitOnSeparator($separator, @words);
  say 'Output: "' . join('", "', @output) . '"';
}

say "Example 1:";
solution('.', "one.two.three","four.five","six");

say "\nExample 2:";
solution('$', '$perl$$', '$$raku$');