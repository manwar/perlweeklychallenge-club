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

is( "@{[ array_degree_linear( @{$_->[0]} ) ]}", $_->[1] ) for @TESTS;
is( "@{[ array_degree(        @{$_->[0]} ) ]}", $_->[1] ) for @TESTS;

done_testing();

cmpthese( 80_000, {
  'n^2' => sub { array_degree(        @{$_->[0]} ) for @TESTS },
  'n'   => sub { array_degree_linear( @{$_->[0]} ) for @TESTS },
});
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
  @_[$start..$end]
}

sub array_degree_linear {
  my($c,%f)=0;

                              ## For each number compute the frequency
                              ## and the maximum/minimum index...

  ( $f{$_} = $f{$_} ? [$f{$_}[0]+1,$f{$_}[1],$c] : [1,$c,$c] ), $c++ for @_;

                              ## Find the maximum frequency, with
                              ## shortest length!

  my( $best, @rest ) = values %f;

  for( @rest ) {
    $best = $_ if $_->[0] > $best->[0]
               || $best->[0] == $_->[0]
                  && $_->[2]-$_->[1] < $best->[2] - $best->[1];
  }

                              ## Return the best value....

  @_[ $best->[1]..$best->[2] ]
}


