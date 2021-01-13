#! /usr/bin/perl

use strict;
use warnings;

use List::Util qw(min);
use Test::More tests => 2;

is_deeply(sn([7,8,3,12,10]),
          [0,7,0,3,3],
          'example 1',
            );
is_deeply(sn([4,6,5]),
          [0,4,4],
          'example 2',
            );

sub sn {
  my $a=shift;
  my @out=(0);
  my $wm;
  foreach my $i (1..$#{$a}) {
    if (!defined $wm) {
      $wm=$a->[$i-1];
    } else {
      $wm=min($wm,$a->[$i-1]);
    }
    if ($wm < $a->[$i]) {
      push @out,$wm;
    } else {
      push @out,0;
    }
  }
  return \@out;
}
