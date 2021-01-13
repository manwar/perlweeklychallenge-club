#! /usr/bin/perl

use strict;
use warnings;

use List::Util qw(min);
use Test::More tests => 1;

is_deeply(msw([1,5,0,2,9,3,7,6,4,8],3),
          [0,0,0,2,3,3,4,4],
          'example',
            );

sub msw {
  my $a=shift;
  my $s=shift;
  my @out;
  foreach my $i (0..(scalar @{$a})-$s) {
    push @out,min(@{$a}[$i..$i+$s-1]);
  }
  return \@out;
}
