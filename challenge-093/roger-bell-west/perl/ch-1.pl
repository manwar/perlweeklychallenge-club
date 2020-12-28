#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(mp([1,1], [2,2], [3,3]),3,'example 1');
is(mp([1,1], [2,2], [3,1], [1,3], [5,3]),3,'example 2');

sub mp {
  my @c=@_;
  my $epsilon=0.0001;
  my $mxp=0;
  foreach my $a (0..$#c-2) {
    foreach my $b ($a+1..$#c-1) {
      my @d=map {$c[$b][$_]-$c[$a][$_]} (0,1);
      my $pil=2;
      foreach my $c ($b+1..$#c) {
        my $tp=0;
        my @v=map {$c[$c][$_]-$c[$a][$_]} (0,1);
        if ($d[0]==0) {
          if ($v[0]==0) {
            $tp=1;
          }
        } elsif ($d[1]==0) {
          if ($v[1]==0) {
            $tp=1;
          }
        } elsif (abs($v[0]/$d[0]-$v[1]/$d[1])<$epsilon) {
          $tp=1;
        }
        if ($tp) {
          $pil++;
        }
      }
      if ($pil > $mxp) {
        $mxp=$pil;
      }
    }
  }
  return $mxp;
}
