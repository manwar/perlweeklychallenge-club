#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [1234,5678], 7 ],
  [ [5678,1234], 3 ],
);
is( fibnum(@{$_->[0]}), $_->[1] ) foreach @TESTS;

done_testing();

sub fibnum_messy {
  for( my($r,$s) = @_; 51>length $s || return substr $s,50,1;($r,$s) = ($s,$r.$s) ){}
}

sub fibnum {
  my ($r,$s) = @_;
  ($r,$s) = ($s,$r.$s) while 51>length $s;
  substr $s,50,1;
}
