#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;

my @TESTS = (
  [ [1,5,3,6], 1 ],
  [ [2,6,3,5], 0 ],
  [ [1,2,3,4], 0 ],
  [ [2,3,5,7], 1 ],
);

is( odd3( @{$_->[0]}), $_->[1] ) for @TESTS;
done_testing();

sub odd3 {
  return 0 unless @_>2;
  my $p = shift, my $q = shift;
  $p&$q&$_[0]&1 ? (return 1) : (($p,$q)=($q,shift)) while @_;
  0;
}
