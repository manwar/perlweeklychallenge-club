#!/usr/bin/env raku
use v6;

sub splitOnSeparator(@words, $separator) {
  my @output;
  for @words -> $str {
    @output.append( $str.split($separator, :skip-empty) );
  }
  return @output;
}

sub solution(@words, $separator) {
  say 'Input: @words = ("' ~ @words.join("', '") ~ '")';
  say '       $separator = "' ~ $separator ~ '"';
  my @output = splitOnSeparator(@words, $separator);
  say 'Output: "' ~ @output.join('", "') ~ '"';
}

say "Example 1:";
solution(["one.two.three","four.five","six"], '.');

say "\nExample 2:";
solution(['$perl$$', '$$raku$'], '$');
