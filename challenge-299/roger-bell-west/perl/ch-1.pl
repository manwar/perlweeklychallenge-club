#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(replacewords(['cat', 'bat', 'rat'], 'the cattle was rattle by the battery'), 'the cat was rat by the bat', 'example 1');
is(replacewords(['a', 'b', 'c'], 'aab aac and cac bab'), 'a a a c b', 'example 2');
is(replacewords(['man', 'bike'], 'the manager was hit by a biker'), 'the man was hit by a bike', 'example 3');

sub replacewords($ww, $a) {
  my @out;
  foreach my $w (split ' ', $a) {
    my $r = 0;
    foreach my $lw (@{$ww}) {
      if (index($w, $lw) == 0) {
        push @out, $lw;
        $r = 1;
        last;
      }
    }
    if (!$r) {
      push @out, $w;
    }
  }
  join(' ', @out);
}
