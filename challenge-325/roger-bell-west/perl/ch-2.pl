#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(finalprice([8, 4, 6, 2, 3]), [4, 2, 4, 2, 3], 'example 1');
is_deeply(finalprice([1, 2, 3, 4, 5]), [1, 2, 3, 4, 5], 'example 2');
is_deeply(finalprice([7, 1, 1, 5]), [6, 0, 1, 5], 'example 3');

sub finalprice($a) {
  my @out;
  while (my ($i, $n) = each @{$a}) {
    my $discount = 0;
    foreach my $mi ($i + 1 .. scalar @{$a} - 1) {
      if ($a->[$mi] <= $n) {
        $discount = $a->[$mi];
        last;
      }
    }
    push @out, $n - $discount;
  }
  \@out;
}
