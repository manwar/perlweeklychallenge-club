#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ 1,3,5,7,9, ],
  [ 2,4,6,8,10,],
  [ 1,2,3,4,5, ],
  [ 1..19 ],
  [ 1..99 ],
  [ 1..170 ],
  [ 1..171 ],
  [ 1..999 ],
  [ 1..9999 ],
  [ 1..99999 ],
  [ 1..999999 ],
  [ 1..9999999 ],
);

say sprintf 'AM = %15.6f, GM = %15.6f, HM = %15.6f', means( @{$_} )          for @TESTS;
say '';
say sprintf 'AM = %15.6f, GM = %15.6f, HM = %15.6f', means_scalable( @{$_} ) for @TESTS;

sub means {
  my ($am, $gm, $hm) = (0, 1, 0);

  $am+=$_, $gm*=$_, $hm+=1/$_ for @_;

  ( $am/@_, $gm**(1/@_), @_/$hm );
}

sub means_scalable {
  my ($am, $gm, $hm) = (0, 1, 0);

  $am+=$_, $gm*=$_**(1/@_), $hm+=1/$_ for @_;

  ( $am/@_, $gm, @_/$hm );
}

