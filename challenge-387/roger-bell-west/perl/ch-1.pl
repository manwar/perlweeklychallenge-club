#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(rearrangebinarystring('111000'), 0, 'example 1');
is(rearrangebinarystring('00011'), 4, 'example 2');
is(rearrangebinarystring('01011'), 3, 'example 3');
is(rearrangebinarystring('010101'), 3, 'example 4');
is(rearrangebinarystring('00001'), 4, 'example 5');

sub rearrangebinarystring($a0) {
  my $ct = 0;
  my $a = $a0;
  while (1) {
    my $b = $a;
    $b =~ s/01/10/g;
    if ($b eq $a) {
      last;
    } else {
      $a = $b;
      $ct++;
    }
  }
  $ct;
}
