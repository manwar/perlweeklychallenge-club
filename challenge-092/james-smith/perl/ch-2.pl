#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is_deeply( int_insert( [2,6], [1,4], [8,10]        ), [[1,6],[8,10]] );  ## Simple overlap
is_deeply( int_insert( [2,6], [1,7], [8,10]        ), [[1,7],[8,10]] );  ## New entry entirely in one region
is_deeply( int_insert( [1,7], [2,6], [8,10]        ), [[1,7],[8,10]] );  ## New entry engulfs one region
is_deeply( int_insert( [1,7], [2,3], [4,5], [8,10] ), [[1,7],[8,10]] );  ## New entry engulfs 2 regions
is_deeply( int_insert( [2,8], [1,2], [3,4], [5,6], [7,9] ), [[1,9]] );   ## Merges multiple regions
is_deeply( int_insert( [5,8], [1,2], [3,7], [8,10] ), [[1,2],[3,10]] );  ## Merges two groups
is_deeply( int_insert( [10,11], [1,5],[7,9]        ), [[1,5],[7,9],[10,11]] ); ## New entry at end
is_deeply( int_insert( [5,6], [1,2],[7,9]          ), [[1,2],[5,6],[7,9]] );   ## New entry in middle
is_deeply( int_insert( [1,2], [5,6],[7,9]          ), [[1,2],[5,6],[7,9]] );   ## New entry at start
is_deeply( int_insert( [1,1e7], map { [2*$_,2*$_+1] } 1..4_999_999 ), [[1,1e7]] ); ## Check it isn't really slow!

done_testing( );

sub int_insert {
  my( $new, @list ) = @_;
  my @new_list;
  while(my $e = shift @list) {
    return [ @new_list, $new, $e, @list ] if $e->[0] > $new->[1];
          ## The start of the next element is after the end of the new element - so we can safely
          ## push the new element and the rest of the list (and return it)
    if( $e->[1] < $new->[0] ) { ## Next element is to the left of the new element so push
      push @new_list,$e;        ## and continue
      next;
    }
    $new->[0] = $e->[0] if $e->[0] < $new->[0];
    $new->[1] = $e->[1] if $e->[1] > $new->[1];           ## Get start/end of first overlap...
    while( @list && $new->[1] >= $list[0][0] ) {          ## this also overlaps the next list element
      $new->[1] = $list[0][1] if $list[0][1] > $new->[1]; ## If goes beyond next list element we extend new
      shift @list;                                        ## Remove element from list;
    }
    return [ @new_list, $new, @list ];                    ## The rest of the list will be after the "new" element now
  }                                                         ## So we can safely push and return it....
  return [ @new_list, $new ];                             ## The new element must be after the list so we just
                                                            ## return it on the end of the list...
}

