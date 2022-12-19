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

is( dmp( range(    @{$_->[0]} ) ), $_->[1] ) for @TESTS;
is( dmp( range_v2( @{$_->[0]} ) ), $_->[1] ) for @TESTS;
done_testing();

sub range {
  my $s = my $e = shift, my @r;
  ($_[0]==$e+1) ? ( $e=shift ) : ( $s==$e || push(@r,[$s,$e]) , $e=$s=shift ) while @_;
  push @r, [$s,$e] unless $s==$e;
  @r
}

sub range_v2 {
  my @r = [ (shift) x 2 ];
  $_ == $r[-1][1] + 1 ? $r[-1][1] = $_ : push @r, [$_,$_] for @_;
  grep { $_->[1]-$_->[0] } @r
}

sub dmp { sprintf '( %s )', join ', ', map { sprintf '[%s]', join ',', @{$_} } @_ }
