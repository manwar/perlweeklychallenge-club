#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is_deeply(keyboardword(['Hello', 'Alaska', 'Dad', 'Peace']), ['Alaska', 'Dad'], 'example 1');
is_deeply(keyboardword(['OMG', 'Bye']), [], 'example 2');

sub keyboardword($wl) {
  return [grep /^([qwertyuiop]+|[asdfghjkl]+|[zxcvbnm]+)$/i, @{$wl}];
}
