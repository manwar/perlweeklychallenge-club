#! /usr/bin/perl

use strict;
use warnings;

use Algorithm::Permute;
use Memoize;

use Data::Dumper;

memoize("findroute");

aok('a8',[qw(e6 c4 b3 a2 b2 b1)]);

sub aok {
  my ($start,$t)=@_;
  my @arr=@{$t};
  my $ml;
  my @mu;
  Algorithm::Permute::permute {
    my @r=($start,@arr);
    my $l=0;
    my @m=();
    foreach my $i (0..$#r-1) {
      push @m,findroute($r[$i],$r[$i+1]);
      $l+=scalar @{$m[-1]}-1;
    }
    if (!defined $ml || $l < $ml) {
      $ml=$l;
      @mu=@m;
    }
  } @arr;
  print "$start\n";
  foreach my $mv (@mu) {
    my @r;
    foreach my $i (1..$#{$mv}) {
      push @r,c2l($mv->[$i]);
    }
    print join(' ',map {"-> $_"} @r),"\n";
  }
  print "\n$ml moves\n";
}

sub findroute {
  my ($a,$b)=@_;
  my $target=l2c($b);
  my $rt;
  my @chain=([l2c($a)]);
 SEARCH:
  while (my $c=shift @chain) {
    foreach my $offset (
      [-2,-1],
      [-1,-2],
      [-2,1],
      [1,-2],
      [2,-1],
      [-1,2],
      [2,1],
      [1,2],
        ) {
      my $x=$c->[-1][0]+$offset->[0];
      my $y=$c->[-1][1]+$offset->[1];
      if ($x>=0 && $x<=7 && $y>=0 && $y<=7) {
        my $rl=[@{$c},[$x,$y]];
        if ($x==$target->[0] && $y==$target->[1]) {
          $rt=$rl;
          last SEARCH;
        } else {
          push @chain,$rl;
        }
      }
    }
  }
  return $rt;
}

sub l2c {
  my $l=shift;
  return [ord(substr($l,0,1))-ord("a")+0,substr($l,1,1)-1];
}

sub c2l {
  my ($x,$y)=@{$_[0]};
  return chr(ord("a")+$x).($y+1);
}
