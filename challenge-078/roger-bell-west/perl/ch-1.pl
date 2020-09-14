#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is_deeply(leader((9, 10, 7, 5, 6, 1)),[10, 7, 6, 1],'example 1');
is_deeply(leader((3, 4, 5)),[5],'example 2');

sub leader {
  my @t=reverse @_;
  my $m;
  my @o;
  foreach my $c (@t) {
    if (!defined $m || $c > $m) {
      $m=$c;
      push @o,$m;
    }
  }
  @o=reverse @o;
  return \@o;
}
