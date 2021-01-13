#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is_deeply(zm([[1,0,1],[1,1,1],[1,1,1]]),
          [[0,0,0],[1,0,1],[1,0,1]],
          'example 1',
            );
is_deeply(zm([[1,0,1],[1,1,1],[1,0,1]]),
          [[0,0,0],[1,0,1],[0,0,0]],
          'example 2',
            );

sub zm {
  my $in=shift;
  my $a=scalar @{$in}-1;
  my $b=scalar @{$in->[0]}-1;
  my %seta;
  my %setb;
  foreach my $ai (0..$a) {
    foreach my $bi (0..$b) {
      if ($in->[$ai][$bi]==0) {
        $seta{$ai}=1;
        $setb{$bi}=1;
      }
    }
  }
  foreach my $aa (keys %seta) {
    foreach my $bi (0..$b) {
      $in->[$aa][$bi]=0;
    }
  }
  foreach my $bb (keys %setb) {
    foreach my $ai (0..$a) {
      $in->[$ai][$bb]=0;
    }
  }
  return $in;
}
