#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(totalxor([1, 3]), 6, 'example 1');
is(totalxor([5, 1, 6]), 28, 'example 2');
is(totalxor([3, 4, 5, 6, 7, 8]), 480, 'example 3');

use Algorithm::Combinatorics qw(combinations);

use List::Util qw(reduce);

sub totalxor($i) {
  my $tot = 0;
  foreach my $n (1 .. scalar @{$i}) {
    my $ip = combinations($i, $n);
    while (my $c = $ip->next) {
      $tot += reduce {$a ^ $b} (0, @{$c});
    }
  }
  $tot
}
