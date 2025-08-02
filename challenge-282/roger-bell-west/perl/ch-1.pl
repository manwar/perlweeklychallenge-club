#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(goodinteger(12344456), 444, 'example 1');
is(goodinteger(1233334), -1, 'example 2');
is(goodinteger(10020003), 0, 'example 3');

use List::MoreUtils qw(slideatatime);

sub goodinteger($a) {
  my $winsize = 3;
  my @d = split('', $a);
  my $dd = slideatatime 1, $winsize, @d;
  my $offset = 0;
  while (my @cc = $dd->()) {
    if ( scalar @cc == $winsize && $cc[0] eq $cc[1] && $cc[1] eq $cc[2]) {
      if (($offset == 0 || $d[$offset - 1] ne $cc[0]) &&
          ($offset == (scalar @d) - $winsize || $d[$offset + $winsize] ne $cc[2])) {
        return join('', @cc) + 0;
      }
    } 
    $offset++;
  }
  return -1;
}
