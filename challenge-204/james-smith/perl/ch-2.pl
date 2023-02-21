#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use List::Util qw(sum0);

sub reshape {
  my($m,$r,$c) = @_;
  return 0 unless @{$m}*@{$m->[0]} == $r * $c;
  my @t = map { @{$_} } @{$m};
  [ map { [ splice @t, 0, $c ] } 1..$r ];
}

sub reshape2 {
  my($m,$r,$c) = @_;
  my $R=@{$m}; my $C = @{$m->[0]};
  return 0 unless (my $R=@{$m}) * (my $C=@{$m->[0]}) == $r * $c;
  my($x,$y,$res)=(0,0);
  for my $i (1..$r) {
    my $row = [];
    my $to_push = $c;
    while( $to_push ) {
      my $t = $to_push+$x<$C?$to_push+$x:$C;
      push @{$row},@{$m->[$y]}[$x..$t-1];
      $to_push -= $t-$x;
      $t==$C ? ($y++,$x=0) : ($x=$t);
    }
    push @{$res},$row;
  }
  $res;
}

