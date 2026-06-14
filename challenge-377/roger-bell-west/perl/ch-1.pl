#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(reverseexistence('abcba'), 1, 'example 1');
is(reverseexistence('racecar'), 1, 'example 2');
is(reverseexistence('abcd'), 0, 'example 3');
is(reverseexistence('banana'), 1, 'example 4');
is(reverseexistence('hello'), 1, 'example 5');

use List::MoreUtils qw(slide);

sub reverseexistence($a) {
  my $ret = 0;
  my @c = reverse split('', $a);
  slide {
    my $sample = $::a . $::b;
    if (index($a, $sample) > -1) {
      $ret = 1;
    }
  } @c;
  $ret;
}
