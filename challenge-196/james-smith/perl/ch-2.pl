#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);

my @TESTS = (
   [ [1,3,4,5,7],       '( [3,5] )' ],
   [ [1,2,3,6,7,9],     '( [1,3], [6,7] )' ],
   [ [0,1,2,4,5,6,8,9], '( [0,2], [4,6], [8,9] )' ],
   [ [1,3,5],           '(  )' ],
);

is( dmp( range_v2(  @{$_->[0]} ) ), $_->[1] ) for @TESTS;
is( dmp( range_map( @{$_->[0]} ) ), $_->[1] ) for @TESTS;
is( dmp( range(     @{$_->[0]} ) ), $_->[1] ) for @TESTS;
is( dmp( range_for( @{$_->[0]} ) ), $_->[1] ) for @TESTS;

done_testing();

cmpthese( -3, {
  2 => sub { range_v2(  @{$_->[0]} ) for @TESTS },
  3 => sub { range_map( @{$_->[0]} ) for @TESTS },
  1 => sub { range(     @{$_->[0]} ) for @TESTS },
  4 => sub { range_for( @{$_->[0]} ) for @TESTS },
} );

sub range_v2 {
  my @r=[(shift)x 2];
  $_==$r[-1][1]+1 ? $r[-1][1]=$_ : push @r,[$_,$_] for @_;
  grep { $_->[1] != $_->[0] } @r;
}

sub range_map {
  my $e = my $s = shift;
  map { $_==$e+1 ? ($e = $_)x 0 :( $e-$s ? [$s,$e] : (), ($s=$e=$_)x 0 ) } @_,0;
}

sub range {
  my $s = my $e = shift, my @r;
  ($_[0]==$e+1) ? ( $e=shift ) : ( $s==$e || push(@r,[$s,$e]) , $e=$s=shift ) while @_;
  push @r, [$s,$e] unless $s==$e;
  @r
}

sub range_for {
  my $s = my $e = shift, my @r;
  ($_==$e+1) ? $e++ : ( $s==$e || push(@r,[$s,$e]) , $e=$s=$_ ) for @_;
  push @r, [$s,$e] unless $s==$e;
  @r
}

sub dmp { sprintf '( %s )', join ', ', map { sprintf '[%s]', join ',', @{$_} } @_ }
