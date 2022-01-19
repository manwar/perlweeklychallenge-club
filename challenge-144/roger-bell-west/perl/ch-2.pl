#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is_deeply(ulam(1,2,10),[1, 2, 3, 4,  6 , 8, 11, 13, 16, 18],'example 1');
is_deeply(ulam(2,3,10),[2, 3, 5, 7,  8,  9, 13, 14, 18, 19],'example 2');
is_deeply(ulam(2,5,10),[2, 5, 7, 9, 11, 12, 13, 15, 19, 23],'example 3');

sub ulam {
  my ($u,$v,$count)=@_;
  my @ulams=($u,$v);
  my @sieve;
  my $uc=$v;
  while (scalar @ulams < $count) {
    my $ss=$uc+$ulams[-2];
    push @sieve,(0) x ($ss-scalar @sieve);
    foreach my $i (0..$#ulams-1) {
      $sieve[$uc + $ulams[$i] - 1]++;
    }
    foreach my $i ($uc..$#sieve) {
      if ($sieve[$i]==1) {
        $uc=$i+1;
        push @ulams,$uc;
        last;
      }
    }
  }
  return \@ulams;
}
