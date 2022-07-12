#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ 5456, 1 ],
  [ 120,  0 ],
);

is( is_esthetic($_->[0]), $_->[1] ) foreach @TESTS;
is( est($_->[0]), $_->[1] ) foreach @TESTS;

done_testing();

sub is_esthetic{
  my($f,@n)=split//,pop;
  abs( $_-$f ) == 1 ? ($f=$_) : return 0 for@n;
  1
}
#-68-|----#----|----#----|----#----|----#----|----#----|----#----|----
sub est{my($f,@n)=split//,pop;abs($_-$f)==1?($f=$_):return 0for@n;1}

