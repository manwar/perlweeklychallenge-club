#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

use POSIX qw(floor);

is(r2qi(4),"10300",'example 1');

is(qi2r("10300"),4,'example 2');

sub r2qi($n) {
  return c2qi($n, 0);
}

sub c2qi($r0, $i0) {
  my @l;
  foreach my $n0 ($i0, $r0) {
    my $n = $n0;
    my @digits;
    while ($n != 0) {
      my $digit = $n % -4;
      $n = floor($n/-4);
      if ($digit < 0) {
        $digit += 4;
        $n += 1;
      }
      push @digits, $digit;
    }
    push @l,\@digits;
  }
  my $ld = scalar @{$l[0]} - scalar @{$l[1]};
  if ($ld < 0) {
    unshift @{$l[0]},(0) x (-$ld-1);
  } elsif ($ld > 1) {
    unshift @{$l[1]},(0) x $ld;
  }
  my $o = '';
  for (my $i = $#{$l[1]}; $i >= 0; $i--) {
    foreach my $b (0,1) {
      if (scalar @{$l[$b]} > $i) {
        $o .= $l[$b][$i];
      }
    }
  }
  return $o;
}

sub qi2r($n) {
  return qi2c($n)->[0];
}

sub qi2c($n) {
  my $pow = 1;
  my $ri = 0;
  my @o = (0) x 2;
  foreach my $ch (reverse split '',$n) {
    $o[$ri] += $ch * $pow;
    $ri++;
    $pow *= 2;
    if ($ri == 2) {
      $ri = 0;
      $pow = -$pow;
    }
  }
  return \@o;
}
