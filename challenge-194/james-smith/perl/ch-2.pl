#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);

my @TESTS = ( ['abbc',1],['xyzyyxz',1],['xzxz',0] );

is( check( $_->[0] ), $_->[1] ) for @TESTS;
done_testing();

sub check {
  my %sc; $sc{$_} ++ for split //,$_[0];
  sub { @_>2 && $_[0]==$_[1]+1 && $_[-1]==$_[1] ? 1 : 0 }->(sort {$b<=>$a} values %sc);
}
