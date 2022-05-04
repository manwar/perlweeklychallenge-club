#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [1,3,5,7,9],            70 ],
  [ [1..5],                 42 ],
  [ [1..9],              4_862 ],
  [ [1..15],         9_694_845 ],
  [ [1..20],     6_564_120_420 ],
);

say '';
is( summation(@{$_->[0]}), $_->[1] ),say'' for @TESTS;
is( summation_with_table(@{$_->[0]}), $_->[1] ),say'' for @TESTS;
is( summation_with_pretty_table(@{$_->[0]}), $_->[1] ),say'' for @TESTS;
is( sum(@{$_->[0]}), $_->[1] ),say'' for @TESTS;
done_testing();
say '';

sub summation_with_table {
  my $t;
  say "@_";
  shift, $t=0, say join ' ', @_ = map { $t+=$_ } @_ while @_>1;
  shift;
}

sub summation_with_pretty_table {
  my ($in,$t)='';
  say map { sprintf ' %11d', $_ } @_;
  ($in.='            '), shift, $t=0, say $in, map { sprintf ' %11d', $_ } @_ = map { $t+=$_ } @_ while @_>1;
  shift;
}

sub summation {
  my $t;
  shift, $t=0, @_ = map { $t+=$_ } @_ while @_>1;
  shift;
}
##########----------##########----------##########----------##########----------##########----------
sub sum{shift,$a=0,@_=map{$a+=$_}@_ while@_>1;$a}
