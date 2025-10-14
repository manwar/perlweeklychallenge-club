#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(zerofriend([4, 2, -1, 3, -2]), -1, 'example 1');
is(zerofriend([-5, 5, -3, 3, -1, 1]), 1, 'example 2');
is(zerofriend([7, -3, 0, 2, -8]), 0, 'example 3');
is(zerofriend([-2, -5, -1, -8]), -1, 'example 4');
is(zerofriend([-2, 2, -4, 4, -1, 1]), 1, 'example 5');

use List::Util qw(min);

sub zerofriend($a) {
  my $b = min(map {abs($_)} @{$a});
  my %ah = map {$_ => 1} @{$a};
  if (exists $ah{$b}) {
    return $b;
  }
  -$b;
}
