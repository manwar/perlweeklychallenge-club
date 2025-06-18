#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(decompressedlist([1, 3, 2, 4]), [3, 4, 4], 'example 1');
is_deeply(decompressedlist([1, 1, 2, 2]), [1, 2, 2], 'example 2');
is_deeply(decompressedlist([3, 1, 3, 2]), [1, 1, 1, 2, 2, 2], 'example 3');

use List::Util qw(pairs);


sub decompressedlist($a) {
  my @out;
  foreach my $pair ( pairs @{$a} ) {
    my ($k, $v) = @$pair;
    push @out, ($v) x $k;
  }
  \@out;
}
