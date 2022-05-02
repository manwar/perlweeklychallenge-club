#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [1..5],      42 ],
  [ [1,3,5,7,9], 70 ],
);

say '';
is( summation(@{$_->[0]}), $_->[1] ),say'' for @TESTS;
is( summation_with_table(@{$_->[0]}), $_->[1] ),say'' for @TESTS;
done_testing();
say '';

sub summation_with_table {
  my $t;
  say "@_";
  shift, ($t=0), say "@{[ @_ = map { $t+=$_ } @_ ]}" while @_>1;
  shift;
}

sub summation {
  my $t;
  shift, ($t=0), (@_ = map { $t+=$_ } @_) while @_>1;
  shift;
}
