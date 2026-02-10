#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(wordsorter('The quick brown fox'), 'brown fox quick The', 'example 1');
is(wordsorter('Hello    World!   How   are you?'), 'are Hello How World! you?', 'example 2');
is(wordsorter('Hello'), 'Hello', 'example 3');
is(wordsorter('Hello, World! How are you?'), 'are Hello, How World! you?', 'example 4');
is(wordsorter('I have 2 apples and 3 bananas!'), '2 3 and apples bananas! have I', 'example 5');

sub wordsorter($a) {
  my @w = split ' ', $a;
  my @wl = map {lc($_)} @w;
  my @i = sort {$wl[$::a] cmp $wl[$::b]} (0 .. $#w);
  @w = map {$w[$_]} @i;
  join(' ', @w);
}
