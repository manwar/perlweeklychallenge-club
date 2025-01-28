#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(oddsum([2, 5, 3, 6, 4]), 77, 'example 1');
is(oddsum([1, 3]), 4, 'example 2');

use List::Util qw(sum);
use List::MoreUtils qw(slideatatime);

sub oddsum($a) {
  my $out = sum(@{$a});
  my $l = 3;
  while ($l <= scalar @{$a}) {
    my $dd = slideatatime 1, $l, @{$a};
    while (my @s = $dd->()) {
      if (scalar @s == $l) {
        $out += sum(@s);
      }
    }
    $l += 2;
  }
  $out;
}
