#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(numbercollision([2, 3, -1]), [2, 3], 'example 1');
is_deeply(numbercollision([3, 2, -4]), [-4], 'example 2');
is_deeply(numbercollision([1, -1]), [], 'example 3');

sub numbercollision($aa) {
  my @a = @{$aa};
  my $dirty = 1;
  while ($dirty) {
    my @b;
    $dirty = 0;
    my $i = 0;
    while ($i <= $#a) {
      if ($i < $#a && $a[$i] > 0 && $a[$i + 1] < 0 ) {
        my $ab = abs($a[$i+1]);
        if ($a[$i] > $ab) {
          push @b, $a[$i];
        } elsif ($a[$i] < $ab) {
          push @b, $a[$i + 1];
        }
        $i+=2;
        $dirty = 1;
      } else {
        push @b, $a[$i];
        $i++;
      }
    }
    @a = @b;
  }
  return \@a;
}
