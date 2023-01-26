#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);

my @TESTS = ([5,7],[10,42],[15,176],[20,627],[25,1958],[30,5604],[35,14883],[40,37338],[45,89134],[50,204226]);
my %cache;

is( piles(   $_->[0]), $_->[1] ) for @TESTS;
is( piles_2( $_->[0]), $_->[1] ) for @TESTS;
is( piles_q( $_->[0]), $_->[1] ) for @TESTS;
done_testing();

cmpthese( -3, {
  'piles'   => sub { %cache=();  piles(  $_->[0] ) for @TESTS },
  'piles_2' => sub { %cache=(); piles_2( $_->[0] ) for @TESTS },
  'piles_q' => sub {            piles_q( $_->[0] ) for @TESTS },
});

sub piles {
  my($count,$n,$m)=(0,@_);
  $m//=$n;
  return $cache{"$n,$m"} if exists $cache{"$n,$m"};
  return $cache{"$n,$m"} = 1 unless $n;
  $count += piles($n-$_,$_) for 1 .. ($m>$n?$n:$m);
  $cache{"$n,$m"}||=$count;
}

sub piles_2 {
  my($count,$n,$m)=(0,@_);
  $m//=$n;
  $cache{"$n,$m"}//= $n ? sum_piles_2( $n, $m ) : 1;
}

sub sum_piles_2 {
  my $count = 0;
  $count += piles_2($_[0]-$_,$_) for 1 .. ($_[1]>$_[0]?$_[0]:$_[1]);
  $count;
}

sub piles_q {
  my($count,$n,@q,$v)=(0,$_[0],[1,$_[0]]);
  while($v = shift @q) {
    $count++ if $v->[1]>=$v->[0];
    push @q, map { [$_,$v->[1]-$_] } $v->[0]..$v->[1]-1;
  }
  $count;
}
