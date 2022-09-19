#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [5, 2, 9, 1, 7, 6], 2 ],
  [ [4, 2, 3, 1, 5, 0], 4 ],
  [ [map({rand 1000}1..999),10000], 999 ],
  map {
    [ [ 1..$_, reverse( ($_+1)..1000 )], $_ ]
  } (0,310,330,350,999)
);

is( max_index(    @{$_->[0]}), $_->[1] ) foreach @TESTS;
is( max_index_var(@{$_->[0]}), $_->[1] ) foreach @TESTS;

done_testing();

cmpthese( 10000, { 'index' => sub { max_index(    @{$_->[0]}) for @TESTS[2]; }, 'var'   => sub { max_index_var(@{$_->[0]}) for @TESTS[2]; }, });
cmpthese( 10000, { 'index' => sub { max_index(    @{$_->[0]}) for @TESTS[3]; }, 'var'   => sub { max_index_var(@{$_->[0]}) for @TESTS[3]; }, });
cmpthese( 10000, { 'index' => sub { max_index(    @{$_->[0]}) for @TESTS[4]; }, 'var'   => sub { max_index_var(@{$_->[0]}) for @TESTS[4]; }, });
cmpthese( 10000, { 'index' => sub { max_index(    @{$_->[0]}) for @TESTS[5]; }, 'var'   => sub { max_index_var(@{$_->[0]}) for @TESTS[5]; }, });
cmpthese( 10000, { 'index' => sub { max_index(    @{$_->[0]}) for @TESTS[6]; }, 'var'   => sub { max_index_var(@{$_->[0]}) for @TESTS[6]; }, });
cmpthese( 10000, { 'index' => sub { max_index(    @{$_->[0]}) for @TESTS[7]; }, 'var'   => sub { max_index_var(@{$_->[0]}) for @TESTS[7]; }, });

sub max_index {
  return unless @_;
  my $m=0;
  $_[$_]>$_[$m] && ($m=$_) for 1..$#_;
  $m;
}

sub max_index_var {
  return unless @_;
  my $v = $_[ my $m=0 ];
  $_[$_]>$v && ($v=$_[$m=$_]) for 1..$#_;
  $m;
}

