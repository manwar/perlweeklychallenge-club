#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(wordslengthproduct(['a', 'ab', 'abc', 'd', 'de', 'def']), 9, 'example 1');
is(wordslengthproduct(['a', 'aa', 'aaa', 'aaaa']), 0, 'example 2');
is(wordslengthproduct(['meet', 'app', 'code', 'sky', 'bold']), 16, 'example 3');
is(wordslengthproduct(['a', 'ab', 'abc', 'abcd', 'efghi']), 20, 'example 4');
is(wordslengthproduct(['xyz', 'w', 'abcdefg', 'hij']), 21, 'example 5');

use List::Util qw(max);

sub wordslengthproduct($a) {
  my @ws = map {{map {$_ => 1} split '', $_}} @{$a};
  my $mx = 0;
  foreach my $i (0 .. $#ws - 1) {
    foreach my $j ($i + 1 .. $#ws) {
      my $clean = 1;
      foreach my $ic (keys %{$ws[$i]}) {
        if (exists $ws[$j]->{$ic}) {
          $clean = 0;
          last;
        }
      }
      if ($clean) {
        foreach my $jc (keys %{$ws[$j]}) {
          if (exists $ws[$i]->{$jc}) {
            $clean = 0;
            last;
          }
        }
      }
      if ($clean) {
        $mx = max($mx, length($a->[$i]) * length($a->[$j]));
      }
    }
  }
  $mx;
}
