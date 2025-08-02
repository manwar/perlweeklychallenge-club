#!/usr/bin/env raku
use v6;

sub magicNumber(@x, @y) {
  my @xS = @x.sort;
  my @yS = @y.sort;
  my $magic = @yS.shift - @xS.shift;
  while (@xS) {
    if (@yS.shift - @xS.shift != $magic) {
      return; # no magic number
    }
  }
  return $magic;
}

sub solution(@x, @y) {
  say 'Input: @x = (' ~ @x.join(', ') ~ ')';
  say '       @y = (' ~ @y.join(', ') ~ ')';
  my $magic = magicNumber(@x, @y);
  if ($magic.defined) {
    say 'Output: ' ~ $magic;
    say "\nThe magic number is $magic.";
    say '@x = (' ~ @x.join(', ') ~ ')';
    say '   +  ' ~ ($magic xx @x.elems).join('  ');
    say '@y = (' ~ @x.map(-> $v { $v + $magic }).join(', ') ~ ')';
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