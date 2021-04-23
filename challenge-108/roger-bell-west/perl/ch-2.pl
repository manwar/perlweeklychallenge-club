#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is_deeply(bell(10),[1, 1, 2, 5, 15, 52, 203, 877, 4140, 21147],'example 1');

sub bell {
  my $count=shift;
  my @a=([1]);
  foreach my $row (1..$count-1) {
    my @b=$a[-1][-1];
    foreach my $col (1..$row) {
      push @b,$b[$col-1]+$a[-1][$col-1];
    }
    push @a,\@b;
  }
  return [map {$_->[0]} @a];
}

