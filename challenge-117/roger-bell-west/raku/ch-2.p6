#! /usr/bin/perl6

use Test;

plan 2;

is-deeply(fpp(2),['LHLH','LHR','LLHH','LRH','RLH','RR'],'example 1');
is-deeply(fpp(1),['LH','R'],'example 2');

sub fpp($n) {
  my $o=SetHash.new;
  my @chain;
  push @chain,{stub => "",x => 0,y => 0};
  my $lim=$n==1 ?? 2 !! ($n-1)*4;
  while (@chain) {
    my %p=pop @chain;
    if (%p{'y'} >= $lim) {
      $o{%p{'stub'}}=1;
    } else {
      my $mxx=%p{'y'}+1;
      if (%p{'y'} >= $n) {
        $mxx=$lim-%p{'y'}-1;
      }
      for 0..2 -> $txi {
        my $tx=%p{'x'}-1+$txi;
        if ($tx >= 0 && $tx <= $mxx) {
          if ($txi==0) {
            push @chain,{stub => %p{'stub'} ~ 'H', x => %p{'x'}-1, y => %p{'y'}+1};
          } elsif ($txi==1) {
            push @chain,{stub => %p{'stub'} ~ 'R',x => %p{'x'},y => %p{'y'}+2};
          } else {
            push @chain,{stub => %p{'stub'} ~ 'L',x => %p{'x'}+1,y => %p{'y'}+1};
          }
        }
      }
    }
  }
  return [$o.keys.sort];
}
