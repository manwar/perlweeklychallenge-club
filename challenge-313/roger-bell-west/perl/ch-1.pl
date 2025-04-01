#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 4;

is(brokenkeys('perl', 'perrrl'), 1, 'example 1');
is(brokenkeys('raku', 'rrakuuuu'), 1, 'example 2');
is(brokenkeys('python', 'perl'), 0, 'example 3');
is(brokenkeys('coffeescript', 'cofffeescccript'), 1, 'example 4');

sub brokenkeys($name, $typed) {
  my @nt = split '', $name;
  my @tt = split '', $typed;
  my $ni = 0;
  my $ti = 0;
  while (1) {
    if ($nt[$ni] ne $tt[$ti]) {
      return 0;
    }
    if ($ti == scalar @tt - 1) {
      last;
    }
    if ($ni < scalar @nt - 1 && $nt[$ni + 1] eq $nt[$ni]) {
      $ni++;
    } else {
      while ($ti < scalar @tt && $tt[$ti] eq $nt[$ni]) {
        $ti++;
      }
      if ($ti == scalar @tt) {
        last;
      }
      $ni++;
    }
  }
  1;
}
