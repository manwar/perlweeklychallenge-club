#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(ascendingnumbers('The cat has 3 kittens 7 toys 10 beds'), 1, 'example 1');
is(ascendingnumbers('Alice bought 5 apples 2 oranges 9 bananas'), 0, 'example 2');
is(ascendingnumbers('I ran 1 mile 2 days 3 weeks 4 months'), 1, 'example 3');
is(ascendingnumbers('Bob has 10 cars 10 bikes'), 0, 'example 4');
is(ascendingnumbers('Zero is 0 one is 1 two is 2'), 1, 'example 5');

sub ascendingnumbers($a) {
  my $prev = undef;
  foreach my $c (split ' ', $a) {
    if ($c =~ /^[0-9]+$/) {
      if (defined $prev && $prev >= $c) {
        return 0;
      }
      $prev = $c;
    }
  }
  1;
}
