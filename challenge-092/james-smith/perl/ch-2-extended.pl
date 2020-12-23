#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is_deeply( int_insert( [[2,6]], [[1,4], [8,10]]        ), [[1,6],[8,10]] );  ## Simple overlap
is_deeply( int_insert( [[2,6]], [[1,7], [8,10]]        ), [[1,7],[8,10]] );  ## New entry entirely in one region
is_deeply( int_insert( [[1,7]], [[2,6], [8,10]]        ), [[1,7],[8,10]] );  ## New entry engulfs one region
is_deeply( int_insert( [[1,7]], [[2,3], [4,5], [8,10]] ), [[1,7],[8,10]] );  ## New entry engulfs 2 regions
is_deeply( int_insert( [[2,8]], [[1,2], [3,4]], [[5,6], [7,9]] ), [[1,9]] );   ## Merges multiple regions
is_deeply( int_insert( [[5,8]], [[1,2], [3,7], [8,10]] ), [[1,2],[3,10]] );  ## Merges two groups
is_deeply( int_insert( [[10,11]], [[1,5],[7,9]]        ), [[1,5],[7,9],[10,11]] ); ## New entry at end
is_deeply( int_insert( [[5,6]], [[1,2],[7,9]]          ), [[1,2],[5,6],[7,9]] );   ## New entry in middle
is_deeply( int_insert( [[1,2]], [[5,6],[7,9]]          ), [[1,2],[5,6],[7,9]] );   ## New entry at start
is_deeply( int_insert( [[1,1e7]], [map { [2*$_,2*$_+1] } 1..4_999_999] ), [[1,1e7]] ); ## Check it isn't really slow!



done_testing( );

use Data::Dumper qw(Dumper);

sub int_insert {
  my ($result,@rest) = @_;
  my @a = @{$result};
  foreach (@rest) {
    my @b = @{$_};
    my @new;
    while( @a && @b ) {
      if( $a[0][1] < $b[0][0] ) {
        push @new, shift @a;
        next;
      }
      if( $b[0][1] < $a[0][0] ) {
        push @new, shift @b;
        next;
      }
      ## We have an overlap;
      my $new_region = shift @a;
      $new_region->[0] = $b[0][0] if $new_region->[0] > $b[0][0];
      $new_region->[1] = $b[0][1] if $new_region->[1] < $b[0][1];
      shift @b; ## New region is the overlap of the two regions
      while( @a || @b ) {
        if( @a && $a[0][0] <= $new_region->[1] ) {
          $new_region->[1] = $a[0][1] if $new_region->[1] < $a[0][1];
          shift @a;
          next;
        }
        if( @b && $b[0][0] <= $new_region->[1] ) {
          $new_region->[1] = $b[0][1] if $new_region->[1] < $b[0][1];
          shift @b;
          next;
        }
        last;
      }
      push @new, $new_region;
    }
    push @new, @a, @b;
    @a = @new;
  }
  return \@a;
}

