#!/usr/bin/env perl
use v5.38;

sub magicNumber($x, $y) {
  my @xS = sort @$x;
  my @yS = sort @$y;
  my $magic = shift(@yS) - shift(@xS);
  while (@xS) {
    if (shift(@yS) - shift(@xS) != $magic) {
      return; # no magic number
    }
  }
  return $magic;
}

sub solution($x, $y) {
  say 'Input: @x = (' . join(', ', @$x) . ')';
  say '       @y = (' . join(', ', @$y) . ')';
  my $magic = magicNumber($x, $y);
  if (defined $magic) {
    say 'Output: ' . $magic;
    say "\nThe magic number is $magic.";
    say '@x = (' . join(', ', @$x) . ')';
    say '   +  ' . join('  ', ($magic) x scalar(@$x));
    say '@y = (' . join(', ', map { $_ + $magic } @$x ) . ')';
  }
  else {
    say 'Output: no magic number';
  }
}

say "Example 1:";
solution([3, 7, 5], [9, 5, 7]);

say "\nExample 2:";
solution([1, 2, 1], [5, 4, 4]);

say "\nExample 3:";
solution([2], [5]);

say "\nExample 4:";
solution([1, 2], [4, 2]);