#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

print_spiral( 1 .. $_ ) foreach 1..30;

sub print_spiral {
  say join q( ), map { sprintf '%2d', $_ } @{$_}
    foreach @{pack_spiral(@_)};
  say '';
}

sub pack_spiral {

  ## Get the value for columns & rows which have the smallest gap
  ## but still multiply to size of array (we choose rows to be
  ## no greater than columns as printing is neater - but for no
  ## other reason...

  my( $rows )               = reverse grep { ! (@_ % $_) } 1 .. sqrt @_;
  my( $cols, $r, $c, @out ) = ( @_/$rows, $rows-1, -1 );

  ## We start bottom left...
  ## because we use pre-inc we actually start 1 to the left of it!
  ## as we "jump" before depositing the entry of the array...
  ## Remember shift by default operates on @_;

  while( @_ ) {                                      # do until empty
    $out[ $r ][ ++$c ] = shift foreach 1 .. $cols--; # >>
    $out[ --$r ][ $c ] = shift foreach 1 .. --$rows; # ^^
    last                       unless  @_;           # exit if empty
    $out[ $r ][ --$c ] = shift foreach 1 .. $cols--; # <<
    $out[ ++$r ][ $c ] = shift foreach 1 .. --$rows; # vv
  }

  return \@out;
}
