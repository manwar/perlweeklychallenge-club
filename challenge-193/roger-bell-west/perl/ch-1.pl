#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is_deeply(binarystring(2), ["00", "01", "10", "11"], 'example 1');
is_deeply(binarystring(3), ["000", "001", "010", "011", "100", "101", "110", "111"], 'example 2');

sub binarystring($n) {
  my @o;
  foreach my $a (0..(1 << $n)-1) {
    push @o,sprintf('%0'.$n.'b', $a);
  }
  return \@o;
}
