#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(acronyms(['Perl', 'Weekly', 'Challenge'], 'PWC'), 1, 'example 1');
is(acronyms(['Bob', 'Charlie', 'Joe'], 'BCJ'), 1, 'example 2');
is(acronyms(['Morning', 'Good'], 'MM'), 0, 'example 3');

sub acronyms($a, $b) {
  my $os = '';
  foreach my $c (@{$a}) {
    $os .= substr($c, 0, 1);
  }
  ($os eq $b)?1:0;
}
