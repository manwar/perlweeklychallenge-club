#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

print_spiral( 1 .. $_ ) foreach 1..30;

sub print_spiral {
  say join q( ), map { sprintf '%2d', $_ } @{$_} foreach @{pack_spiral(@_)};
  say '';
}

sub pack_spiral {
  my( $rows, @in ) = ( 1, @_ );

  ## Get the value for columns & rows which have the smallest gap
  ## but still multiply to size of array (we choose rows to be
  ## no greater than columns as printing is neater - but for no
  ## other reason...

  $rows = @in%$_ ? $rows : $_ foreach 2 .. sqrt @in;

  my ($cols,$r,$c,@out) = (@in/$rows,$rows-1,-1);

  ## We start bottom left...
  ## because we use pre-inc we actually start 1 to the left of it!
  ## as we "jump" before depositing the entry of the array...

  while( $rows && $cols ) {         ## Do we have anything else to do?
    $out[$r][++$c] = shift @in foreach 1..$cols--; # >>
    $out[--$r][$c] = shift @in foreach 1..--$rows; # ^^
    last unless $rows && $cols;     ## Skip if we have finished here
    $out[$r][--$c] = shift @in foreach 1..$cols--; # <<
    $out[++$r][$c] = shift @in foreach 1..--$rows; # vv
  }

  return \@out;
}
