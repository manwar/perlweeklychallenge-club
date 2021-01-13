#! /usr/bin/perl6

use Test;

plan 2;

is-deeply(leader((9, 10, 7, 5, 6, 1)),(10, 7, 6, 1),'example 1');
is-deeply(leader((3, 4, 5)),(5,),'example 2');

sub leader(@a) {
  my @t=reverse @a;
  my $m;
  my @o;
  for @t -> $c {
    if (!defined $m or $c > $m) {
      $m=$c;
      push @o,$m;
    }
  }
  @o=reverse @o;
  return @o.flat;
}
