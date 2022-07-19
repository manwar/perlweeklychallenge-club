#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

warn '[0..2] - [1,0,2]           : ', permutation2rank( [0..2], [1,0,2]           ), "\n";
warn '[0..2] - [0,3,1]           : ', permutation2rank( [0..2], [0,3,1]           ), "\n";
warn '[0..2] - [0,2,1]           : ', permutation2rank( [0..2], [0,2,1]           ), "\n";
warn '[0..7] - [0,3,6,5,2,4,1,7] : ', permutation2rank( [0..7], [0,3,6,5,2,4,1,7] ), "\n";
warn '[0..7] - [3,7,5,4,1,2,0,6] : ', permutation2rank( [0..7], [3,7,5,4,1,2,0,6] ), "\n";

warn "[0..2] -     2             : @{ rank2permutation( [0..2], 2 )     }\n";
warn "[0..2] -    12             : @{ rank2permutation( [0..2], 12 )    }\n";
warn "[0..2] -     1             : @{ rank2permutation( [0..2], 1 )     }\n";
warn "[0..7] -  2000             : @{ rank2permutation( [0..7], 2000 )  }\n";
warn "[0..7] - 20000             : @{ rank2permutation( [0..7], 20000 ) }\n";

sub permutation2rank {
  my($r,$f,@l,$c,$x) = (0,1,@{$_[0]}), my @p = @{$_[1]};
  $f *= $_ for 1 .. @l;
  O: for ( reverse 1 .. @l ) {
    $f/=$_, $c = 0, $x = shift @p;
    ($x-$_) ? $c++ : ( $r+=$c*$f, splice(@l,$c,1), next O ) for @l;
    return -1;
  }
  $r;
}

sub rank2permutation {
  my( $r, $f, @index, @res ) = ( $_[1], 1, 0 .. (my $n = my @l = @{$_[0]}) -1 );
  $f *= $_ for 1 .. $n;
  return [] if $r >= $f;  ## rank out of range!
  push @res, $l[ splice @index, ($r%=$f) / ($f/=$_), 1 ] for reverse 1..$n;
  \@res;
}
