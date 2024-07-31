#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(reverseword('challenge', 'e'), 'acehllnge', 'example 1');
is(reverseword('programming', 'a'), 'agoprrmming', 'example 2');
is(reverseword('champion', 'b'), 'champion', 'example 3');

sub reverseword($a, $c) {
  my $m = index($a, $c);
  if ($m < 0) {
    return $a;
  }
  my @aa = split('', substr($a, 0, $m+1));
  @aa = sort @aa;
  push @aa, split('', substr($a, $m+1));
  return join('', @aa);
}
