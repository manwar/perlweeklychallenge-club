#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(luhnalgorithm('17893729974'), 1, 'example 1');
is(luhnalgorithm('4137 8947 1175 5904'), 1, 'example 2');
is(luhnalgorithm('4137 8974 1175 5904'), 0, 'example 3');

use List::Util qw(sum);

sub luhnalgorithm($a) {
  my @digits = grep /\d/, split('', $a);
  my $payload = pop @digits;
  @digits = reverse @digits;
  for (my $i = 0; $i <= $#digits; $i += 2) {
    $digits[$i] *= 2;
    if ($digits[$i] > 9) {
      $digits[$i] -= 9;
    }
  }
  (10 - (sum(@digits) % 10) == $payload)?1:0;
}
