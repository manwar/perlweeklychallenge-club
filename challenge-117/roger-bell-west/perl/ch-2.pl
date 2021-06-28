#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is_deeply(fpp(2),[qw(LHLH LHR LLHH LRH RLH RR)],'example 1');
is_deeply(fpp(1),[qw(LH R)],'example 2');

sub fpp {
  my $n=shift;
  my %o;
  my @chain=(['',0,0]);
  my $lim=$n==1?2:($n-1)*4;
  while (@chain) {
    my $p=pop @chain;
    my $x=$p->[1];
    my $y=$p->[2];
    if ($y >= $lim) {
      $o{$p->[0]}=1;
    } else {
      my $mxx=$y+1;
      if ($y >= $n) {
        $mxx=$lim-$y-1;
      }
      foreach my $txi (0..2) {
        my $tx=$x-1+$txi;
        if ($tx >= 0 && $tx <= $mxx) {
          if ($txi==0) {
            push @chain,[$p->[0].'H',$x-1,$y+1];
          } elsif ($txi==1) {
            push @chain,[$p->[0].'R',$x,$y+2];
          } else {
            push @chain,[$p->[0].'L',$x+1,$y+1];
          }
        }
      }
    }
  }
  return [sort keys %o];
}
