#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = ( [5,13],[10,32],[60,2223] );

is( no_11($_->[0]), $_->[1] ) foreach @TESTS;

done_testing();

sub no_11 {
  my $n = shift;
  my @v = (0);
  for( my $i = 0; $i < $n; $i++ ) {
    my $ptr;
    for( $ptr =$#v; $ptr>-1; $ptr--) {
      $v[$ptr]++;
      last if $v[$ptr]<4;
      $v[$ptr]=1;
    }
    unshift @v,1 if $ptr < 0;
    $i-- if "@v"=~m{1 1};
  }
  return join q(),@v;
}

