#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 6;

is(textjustifier('Hi', 5), '*Hi**', 'example 1');
is(textjustifier('Code', 10), '***Code***', 'example 2');
is(textjustifier('Hello', 9), '**Hello**', 'example 3');
is(textjustifier('Perl', 4), 'Perl', 'example 4');
is(textjustifier('A', 7), '***A***', 'example 5');
is(textjustifier('', 5), '*****', 'example 6');

sub textjustifier($intxt, $width) {
  my @working = ('*') x $width;
  my $offset = int(($width - length($intxt)) / 2);
  my @ch = split '', $intxt;
  while (my ($i, $c) = each @ch) {
    $working[$i + $offset] = $c;
  }
  join('', @working);
}
