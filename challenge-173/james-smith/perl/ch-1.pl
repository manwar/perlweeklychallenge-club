#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);
use List::MoreUtils qw(all slide any);

my @TESTS = (
  [ 5456, 1 ],
  [ 120,  0 ],
);

is( is_esthetic($_->[0]), $_->[1] ) foreach @TESTS;
is( e($_->[0]), $_->[1] ) foreach @TESTS;
is( o($_->[0]), $_->[1] ) foreach @TESTS;
is( i($_->[0]), $_->[1] ) foreach @TESTS;
is( k($_->[0]), $_->[1] ) foreach @TESTS;

done_testing();

sub is_esthetic{
  my($f,@n)=split//,pop;
  abs( $_-$f ) == 1 ? ($f=$_) : return 0 for @n;
  1
}

sub e{($a,@_)=split//,pop;abs$_-$a==1?$a=$_:return 0for@_;1}

sub o{all{$_}slide{abs($a-$b)==1}split//,shift;}
sub i{0+all{$_}slide{1==abs$a-$b}split//,pop}
sub k{1-any{$_}slide{1-abs$a-$b}split//,pop}
