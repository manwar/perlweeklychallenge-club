#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is_deeply(lr([
  [qw(0 0 0 1 0 0)],
  [qw(1 1 1 0 0 0)],
  [qw(0 0 1 0 0 1)],
  [qw(1 1 1 1 1 0)],
  [qw(1 1 1 1 1 0 )],
    ]),
          [
            [qw(1 1 1 1 1)],
            [qw(1 1 1 1 1)],
              ],
          'example 1');

is_deeply(lr([
  [qw(1 0 1 0 1 0)],
  [qw(0 1 0 1 0 1)],
  [qw(1 0 1 0 1 0)],
  [qw(0 1 0 1 0 1)],
    ]),
          0,
          'example 2');

is_deeply(lr([
  [qw(0 0 0 1 1 1)],
  [qw(1 1 1 1 1 1)],
  [qw(0 0 1 0 0 1)],
  [qw(0 0 1 1 1 1)],
  [qw(0 0 1 1 1 1)],
    ]),
          [
            [qw(1 1 1 1)],
            [qw(1 1 1 1)],
              ],
          'example 3');

use List::Util qw(min);

sub lr {
  my $s=shift;
  my $maxx=$#{$s};
  my $maxy=$#{$s->[0]};
  my $maxa=0;
  my @c;
  foreach my $x (0..$maxx-1) {
    foreach my $y (0..$maxy-1) {
      if ($s->[$x][$y]==1) {
        foreach my $tx ($x+1..$maxx) {
          foreach my $ty ($y+1..$maxy) {
            my $valid=1;
          OUTER:
            foreach my $sx ($x..$tx) {
              foreach my $sy ($y..$ty) {
                if ($s->[$sx][$sy] != 1) {
                  $valid=0;
                  last OUTER;
                }
              }
            }
            if ($valid) {
              my @l=($tx-$x+1,$ty-$y+1);
              my $a=$l[0]*$l[1];
              if ($a > $maxa) {
                $maxa=$a;
                @c=@l;
              }
            }
          }
        }
      }
    }
  }
  if (@c) {
    my @o;
    foreach (1..$c[0]) {
      push @o,[(1) x $c[1]];
    }
    return \@o;
  }
  return 0;
}
