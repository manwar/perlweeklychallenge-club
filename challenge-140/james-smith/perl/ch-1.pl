#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [  11,  1 ] , 100 ],
  [ [ 101,  1 ] , 110 ],
  [ [ 100, 11 ] , 111 ],
);

say DecBin->new($_->[0][0]) + DecBin->new($_->[0][1]) == DecBin->new($_->[1]) ? 'OK' : 'FAIL' foreach @TESTS;

say DecBinExp->new($_->[0][0]) + DecBinExp->new($_->[0][1]) == DecBinExp->new($_->[1]) ? 'OK' : 'FAIL' foreach @TESTS;

package DecBin;

use overload ('+','bin_add','==','comp');

sub new  { return bless \$_[1], $_[0]; }

sub comp { ${$_[0]} == ${$_[1]}; }

sub bin_add {
  my($t,$c,$m,$a,$b) = (0,0,1,${$_[0]},${$_[1]});
  $c+=$a%10+$b%10,$t+=$m*($c&1),$m*=10,$c>>=1,$a=int$a/10,$b=int$b/10 while$a||$b||$c;
  DecBin->new($t);
}

package DecBinExp;

use overload ('+','bin_add','==','comp');

sub new  { return bless \$_[1], $_[0]; }

sub comp { ${$_[0]} == ${$_[1]}; }

sub bin_add {
  my($t,$c,$m,$a,$b) = (0,0,1,${$_[0]},${$_[1]});
  while ($a||$b||$c) {
    $c +=  $a%10 + $b%10;
    $t +=  $m * ($c&1);
    $m *=  10;
    $c >>= 1;
    $a =   int $a/10;
    $b =   int $b/10;
  }
  DecBin->new($t);
}

