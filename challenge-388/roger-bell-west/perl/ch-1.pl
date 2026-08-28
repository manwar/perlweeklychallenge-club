#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(dyckwords(1), ['UD'], 'example 1');
is_deeply(dyckwords(2), ['UDUD', 'UUDD'], 'example 2');
is_deeply(dyckwords(3), ['UDUDUD', 'UDUUDD', 'UUDDUD', 'UUDUDD', 'UUUDDD'], 'example 3');
is_deeply(dyckwords(0), [''], 'example 4');
is_deeply(dyckwords(4), ['UDUDUDUD', 'UDUDUUDD', 'UDUUDDUD', 'UDUUDUDD', 'UDUUUDDD', 'UUDDUDUD', 'UUDDUUDD', 'UUDUDDUD', 'UUDUDUDD', 'UUDUUDDD', 'UUUDDDUD', 'UUUDDUDD', 'UUUDUDDD', 'UUUUDDDD'], 'example 5');

sub dyckwords($order) {
  my @out;
  my @queue = ("");
  while (scalar @queue > 0) {
    my $st = shift @queue;
    my $dcount = scalar grep /D/, split '', $st;
    if (length($st) == $order * 2) {
      if ($dcount == $order) {
        push @out, $st;
      }
    } else {
      if ($dcount * 2 < length($st)) {
        push @queue, $st . 'D';
      }
      push @queue, $st . 'U';
    }
  }
  \@out;
}
