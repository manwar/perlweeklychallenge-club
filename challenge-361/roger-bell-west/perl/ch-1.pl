#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(zeckendorfrepresentation(4), [3, 1], 'example 1');
is_deeply(zeckendorfrepresentation(12), [8, 3, 1], 'example 2');
is_deeply(zeckendorfrepresentation(20), [13, 5, 2], 'example 3');
is_deeply(zeckendorfrepresentation(96), [89, 5, 2], 'example 4');
is_deeply(zeckendorfrepresentation(100), [89, 8, 3], 'example 5');


sub zeckendorfrepresentation($a) {
  my @fib = (0, 1);
  while ($fib[-1] <= $a) {
    push @fib, $fib[-1] + $fib[-2];
  }
  pop @fib;
  my @res;
  my $aw = $a;
  while ($aw > 0) {
    push @res, $fib[-1];
    $aw -= $fib[-1];
    pop @fib;
    pop @fib;
    while ($fib[-1] > $aw) {
      pop @fib;
    }
  }
  \@res;
}
