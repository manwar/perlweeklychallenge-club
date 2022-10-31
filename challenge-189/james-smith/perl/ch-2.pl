#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [1,3,3,2], '3 3'   ],
  [ [1,2,1,3], '1 2 1' ],
  [ [1,1,2,3,2], '1 1' ],
  [ [2,1,2,1,1], '1 2 1 1' ],
);

is( "@{[ array_degree( @{$_->[0]} ) ]}", $_->[1] ) foreach @TESTS;

done_testing();

sub sc {
  my($v,%f)=0;
  $f{$_}++ for @_;
  ($_>$v)&&($v=$_) for values %f;
  $v
}

sub array_degree {
  my( $start, $end, $target ) = ( 0, $#_, sc( @_ ) );
  for my $st ( 0 .. @_ - $target + 1 ) {
    for ( $st + $target - 1 .. $#_ ) {
      last if     $_ - $st > $end - $start;
      next unless sc( @_[ $st .. $_ ] ) == $target;
      $start=$st, $end=$_;
      last;
    }
  }
  @_[$start..$end];
}

