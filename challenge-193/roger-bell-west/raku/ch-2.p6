#! /usr/bin/perl6

use Test;

plan 2;

is(oddstring(["adc", "wzy", "abc"]), "abc", 'example 1');
is(oddstring(["aaa", "bob", "ccc", "ddd"]), "bob", 'example 2');

sub oddstring(@ss) {
  for (0..chars(@ss[0])-2) -> $i {
    my %tab;
    for @ss -> $s {
      my $v = ord(substr($s,$i+1,1)) - ord(substr($s,$i,1));
      %tab{$v}.push($s);
    }
    for (%tab.values) -> @j {
      if (@j.elems == 1) {
        return @j[0];
      }
    }
  }
  return '';
}
