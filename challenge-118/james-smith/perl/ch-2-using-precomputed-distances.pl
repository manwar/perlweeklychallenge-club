#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Time::HiRes qw(time);

my $time_0 = time;
my @dir   = ([-2,1],[2,1],[-2,-1],[2,-1],[-1,2],[1,2],[-1,-2],[1,-2]);
my $trans = []; ## Squares can move from...

## First compute the transition matrix - the squares
## we can directly reach from any given square...
foreach my $y (0..7) {
  foreach my $x (0..7) {
    my $l = $x + $y * 8;
    push @{ $trans->[$l] }, $l + 6  if $y<7 && $x > 1;
    push @{ $trans->[$l] }, $l + 10 if $y<7 && $x < 6;
    push @{ $trans->[$l] }, $l - 6  if $y>0 && $x < 6;
    push @{ $trans->[$l] }, $l - 10 if $y>0 && $x > 1;
    push @{ $trans->[$l] }, $l + 15 if $y<6 && $x > 0;
    push @{ $trans->[$l] }, $l + 17 if $y<6 && $x < 7;
    push @{ $trans->[$l] }, $l - 15 if $y>1 && $x < 7;
    push @{ $trans->[$l] }, $l - 17 if $y>1 && $x > 0;
  }
}
my $time_1 = time;

## Secondly compute the distance matrix, the distance
## (in number of moves) between any square and any other
## We also keep track of the (a) minimal route between
## the two...

my $dist_maps  = []; ## Map of distances betw
my $route_maps = [];

foreach my $start (0..63) {
  my @T = map { $_ == $start ? 0 : -1 } 0..63;
  my @R = map { '' } 0..63;
  my $c = 1;
  my $d = 0;
  ## Start with "0" distance and repeat increasing distance
  ## by one each time...
  ## For each square which is distance "d" away we look for
  ## all squares we can reach but haven't visited before and
  ## mark that square. We also update the route between the
  ## two squares [ the route is a byte string of square numbers ]
  while($c<64) {
    foreach my $x (0..63) {
      next if $T[$x] != $d;
      foreach ( @{$trans->[$x]}) {
        next if $T[$_]>=0;
        $c++;
        $T[$_] = $d+1;
        $R[$_] = $R[$x].chr$_;
      }
    }
    $d++;
  }
  push @{$dist_maps},  \@T;
  push @{$route_maps}, \@R;
}

my $time_2 = time;
my %CACHE;

#my @treasures = qw(a2 b1 b2 b3 c4 e6);
my @treasures = qw(h3 d7 g7 h4 b4 c2 g2 b6 d4 d1 c5 e4);
my @t_loc     = map { 8 * (substr $_,1) - 105 + ord $_ } @treasures;

my $calls = 0;
my $start = 56;
## Finally get the optimal route!
my ( $ln, $rt ) =@{ optimal_route( $start, @t_loc ) };
my $time_3 = time;

say '';
say 'Minimal length: ',$ln;
say 'Minimal route:  a8  ',show_rt( $rt );
say '';
my $p = 1;
$p*=$_ foreach 1..@treasures;
say 'Permutations:   ',$p;
say 'Function calls: ',$calls;
say 'Cache entries:  ',scalar keys %CACHE;
say 'Speed up:       ',$p/scalar keys %CACHE;
say '';
say 'Timings:';
say sprintf 'Pre^2-compute: %9.6f',$time_1-$time_0;
say sprintf 'Pre-compute:   %9.6f',$time_2-$time_1;
say sprintf 'Find path:     %9.6f',$time_3-$time_2;
say sprintf 'Overall time:  %9.6f',$time_3-$time_0;
say '';

## Core of code which traverses routes.. not to deeply
## nested!! Just recursive...
## Use a global variable %CACHE to store function call
## results to optimize...

sub optimal_route {
  $calls++;
  my($start,@r) = @_;
  return $CACHE{$start} ||= [0,''] unless @r;
  my $key = "$start @{[ sort @r ]}";
  return $CACHE{$key} if exists $CACHE{$key};
  my $len = 64;
  my $rt  = '';
  foreach(0..$#r) {
    my $t = shift @r;
    my $x = optimal_route($t,@r);
    my $l = $dist_maps->[$start][$t] + $x->[0];
    if( $l < $len ) {
      $len = $l;
      $rt  = $route_maps->[$start][$t] . $x->[1];
    }
    push @r,$t;
  }
  return $CACHE{$key} = [$len,$rt];
}

sub show_rt {
  my %t = map { $_ => 1 } @treasures;
  return join q( ),
         map        { $_.( exists $t{$_} ? q(*) : q( ) ) }
         map        { chr( 97 + ($_&7) ).( 1 + ($_>>3) ) }
         map        { ord $_                             }
         split m{}, shift;
}

exit;
