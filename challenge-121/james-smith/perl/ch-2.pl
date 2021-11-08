#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Time::HiRes qw(time);
use Data::Dumper qw(Dumper);

my $start = time;
my %CACHE;
my $calls=0;
my $N = 4;
my $dist_maps = [
  [0, 5, 2, 7],
  [5, 0, 5, 3],
  [3, 1, 0, 6],
  [4, 5, 4, 0],
];

my $comb = 1;
if(@ARGV) {
  $N = shift @ARGV;
  $dist_maps = [];
  foreach my $r (0..$N-1) {
    $dist_maps->[$r][$_] = $r == $_ ? 0 : int rand(20) foreach 0..$N-1;
  }
}
$comb*=$_ foreach 2..($N-1);

say '';
say 'Disance matrix:';
say join '  ', '','',map{ sprintf '%3d', $_ } @{$_} foreach @{$dist_maps};

my $res = optimal_route(0,1..($N-1));

say 'Routes: ',$comb;
say 'Calls:  ',$calls;
say 'Cache:  ',scalar keys %CACHE;
say 'Length: ',$res->[0];
say 'Route:  A ',join q( ), split m{}, $res->[1];
say 'Time:   ',sprintf '%10.6f seconds', time-$start;


sub optimal_route {
  $calls++;
  my($start,@r) = @_;
  my $key = "$start @{[ sort @r ]}";
  return $CACHE{$key} if exists $CACHE{$key};
  my $len = 1e99;
  my $rt  = '';
  if(@r==1) { ## Last node to visit... distance is from start to node to "0"
    $len = $dist_maps->[$start][$r[0]] + $dist_maps->[$r[0]][0];
    $rt = chr(65+$r[0]).'A';
  } else {
    foreach(0..$#r) {
      my $t = shift @r;
      my $x = optimal_route($t,@r);
      my $l = $dist_maps->[$start][$t] + $x->[0];
      if( $l < $len ) {
        $len = $l;
        $rt  = (chr(65+$t)).$x->[1];
      }
      push @r,$t;
    }
  }
  return $CACHE{$key} = [$len,$rt];
}

exit;
