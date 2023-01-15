#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);

my @TESTS = (
  [ [3,0,1,1,9,7],                  [7,2,3],  4 ],
  [ [1,1,2,2,3],                    [0,0,1],  0 ],
  [ [1,3,4,5,1,4,5,2,5,12,4,20],    [1,4,2],  38 ],
  [ [1..20,1..20,1..20,1..20,1..20],[2,7,12], 22725 ],
  [ [1..20,1..20,1..20,1..20,1..20],[7,12,2], 22550 ],
  [ [1..20,1..20,1..20,1..20,1..20],[12,2,7], 22550 ],
);

warn "naive"; is( good_triples_naive(     @{$_->[1]}, @{$_->[0]}), $_->[2] ) foreach @TESTS;
warn "opt  "; is( good_triples_opt(       @{$_->[1]}, @{$_->[0]}), $_->[2] ) foreach @TESTS;
warn "copy 1";is( good_triples_copy_1(    @{$_->[1]}, @{$_->[0]}), $_->[2] ) foreach @TESTS;
warn "range 1";is( good_triples_range_1(   @{$_->[1]}, @{$_->[0]}), $_->[2] ) foreach @TESTS;
warn "copy 2";is( good_triples_copy_2(    @{$_->[1]}, @{$_->[0]}), $_->[2] ) foreach @TESTS;
warn "range "; is( good_triples_range_2(   @{$_->[1]}, @{$_->[0]}), $_->[2] ) foreach @TESTS;
warn "fastest"; is( good_triples_fastest(   @{$_->[1]}, @{$_->[0]}), $_->[2] ) foreach @TESTS;
done_testing();
cmpthese( -2, {
  'naive'   => sub { good_triples_naive(     @{$_->[1]}, @{$_->[0]}) foreach @TESTS },
  'opt'     => sub { good_triples_opt(       @{$_->[1]}, @{$_->[0]}) foreach @TESTS },
  'copy_1'  => sub { good_triples_copy_1(    @{$_->[1]}, @{$_->[0]}) foreach @TESTS },
  'range_1' => sub { good_triples_range_1(   @{$_->[1]}, @{$_->[0]}) foreach @TESTS },
  'copy_2'  => sub { good_triples_copy_2(    @{$_->[1]}, @{$_->[0]}) foreach @TESTS },
  'range_2' => sub { good_triples_range_2(   @{$_->[1]}, @{$_->[0]}) foreach @TESTS },
  'fastest' => sub { good_triples_fastest(   @{$_->[1]}, @{$_->[0]}) foreach @TESTS },
});

sub good_triples_opt {
  my($c,$x,$y,$z)=(0,splice@_,0,3);
  for my $i ( 0..$#_-2 ) {
    for my $j ( $i+1..$#_-1 ) {
      next if abs($_[$i]-$_[$j]) > $x;
      for ( $j+1..$#_ ) {
        $c++ if abs($_[$j]-$_[$_])<= $y
             && abs($_[$i]-$_[$_])<= $z;
      }
    }
  }
  $c;
}

sub good_triples_naive {
  my($c,$x,$y,$z) = (0,splice @_, 0, 3 );
  for my $i ( 0..$#_-2 ) {
    for my $j ( $i+1..$#_-1 ) {
      for ( $j+1..$#_ ) {
        $c++ if abs($_[$i]-$_[$j])<= $x
             && abs($_[$j]-$_[$_])<= $y
             && abs($_[$i]-$_[$_])<= $z;
      }
    }
  }
  $c;
}


sub good_triples_copy_1 {
  my($c,$x,$y,$z)=(0,splice@_,0,3);
  for my $i ( 0..$#_-2 ) {
    my $_1 = $_[$i];
    for my $j ( $i+1..$#_-1 ) {
      next if abs($_1-$_[$j]) > $x;
      for ( $j+1..$#_ ) {
        $c++ if abs($_[$j]-$_[$_])<= $y
             && abs($_1-$_[$_])<= $z;
      }
    }
  }
  $c;
}

sub good_triples_range_1 {
  my($c,$x,$y,$z,$_1,$l,$u)=(0,splice@_,0,3);
  for my $i ( 0..$#_-2 ) {
    ($l,$u) = (($_1 = $_[$i])-$x, $_1+$x);
    for my $j ( $i+1..$#_-1 ) {
      next if $_[$j] < $l || $_[$j] > $u;
      for ( $j+1..$#_ ) {
        $c++ if abs($_[$j]-$_[$_])<= $y
             && abs($_1-$_[$_])<= $z;
      }
    }
  }
  $c;
}

sub good_triples_copy_2 {
  my($c,$x,$y,$z)=(0,splice@_,0,3);
  for my $i ( 0..$#_-2 ) {
    my $_1 = $_[$i];
    for my $j ( $i+1..$#_-1 ) {
      my $_2 = $_[$j];
      next if abs($_1-$_2) > $x;
      for ( $j+1..$#_ ) {
        $c++ if abs($_2-$_[$_])<= $y
             && abs($_1-$_[$_])<= $z;
      }
    }
  }
  $c;
}

sub good_triples_range_2 {
  my($c,$x,$y,$z,$_1,$_2,$lx,$ux,$lz,$uz,$ly,$uy)=(0,splice@_,0,3);
  for my $i ( 0..$#_-2 ) {
    ($lx,$ux,$lz,$uz) = (($_1 = $_[$i])-$x, $_1+$x,$_1-$z,$_1+$z);
    for my $j ( $i+1..$#_-1 ) {
      $_2 = $_[$j];
      next if $_2 < $lx || $_2 > $ux;
      ($ly,$uy) = ($lz>$_2-$y?$lz:$_2-$y,$uz<$_2+$y?$uz:$_2+$y);
      for ( $j+1..$#_ ) {
        $c++ if $ly <= $_[$_] && $_[$_] <= $uy;
      }
    }
  }
  $c;
}

sub good_triples_fastest {
  my($c,$xy,$yz,$xz,$l,$u,$lx,$ux,$ly,$uy,$lz,$uz,$i,$j,$k,$x,$y,$z)=(0,splice@_,0,3);

  if($xy<=$xz&&$xy<=$yz){
    for $i ( 0 .. $#_-2 ) {
      ( $ly, $uy, $lz, $uz ) = ( ($x=$_[$i])-$xy, $x+$xy, $x-$xz, $x+$xz );
      for $j ( $i+1 .. $#_-1 ) {
        next if ($y=$_[$j]) < $ly || $uy<$y;
        ( $l, $u ) = ( $lz > $y-$yz ? $lz : $y-$yz, $uz < $y+$yz ? $uz : $y+$yz );
        $l <= $_[$_] && $_[$_] <= $u && $c++ for $j+1 .. $#_
      }
    }
  } elsif ( $yz<=$xz ) {
    for $j ( 1 .. $#_-1 ) {
      ( $lz, $uz, $lx, $ux ) = ( ($y=$_[$j])-$yz, $y+$yz, $y-$xy, $y+$xy );
      for $k ( $j+1 .. $#_ ) {
        next if ($z=$_[$k]) < $lz || $uz < $z;
        ( $l, $u ) = ( $lx > $z-$xz ? $lx : $z-$xz, $ux < $z+$xz ? $ux : $z+$xz );
        $l <= $_[$_] && $_[$_] <= $u && $c++ for 0 .. $j-1
      }
    }
  } else {
    for $i ( 0..$#_-2 ) {
      ( $ly, $uy, $lz, $uz ) = ( ($x=$_[$i])-$xy, $x+$xy, $x-$xz, $x+$xz );
      for $k ( $i+2..$#_ )  {
        next if ($z=$_[$k]) <$lz || $uz < $z;
        ( $l, $u ) = ( $ly > $z-$yz ? $ly : $z-$yz, $uy < $z+$yz ? $uy : $z+$yz );
        $l <= $_[$_] && $_[$_] <= $u && $c++ for $i+1 .. $k-1;
      }
    }
  }
  $c;
}

__END__
          Rate   naive     opt  copy_1 range_1  copy_2 range_2 fastest
naive   14.6/s      --    -43%    -50%    -52%    -57%    -64%    -85%
opt     25.6/s     75%      --    -12%    -15%    -24%    -36%    -73%
copy_1  29.1/s     99%     13%      --     -4%    -14%    -28%    -70%
range_1 30.2/s    106%     18%      4%      --    -10%    -25%    -69%
copy_2  33.6/s    130%     31%     16%     11%      --    -17%    -65%
range_2 40.3/s    176%     57%     39%     33%     20%      --    -58%
fastest 96.3/s    558%    275%    231%    219%    186%    139%      --
