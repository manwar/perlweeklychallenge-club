#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( insert_pos( [qw( 1  2  3  4)],  3), 2 );
is( insert_pos( [qw( 1  3  5  7)],  6), 3 );
is( insert_pos( [qw(12 14 16 18)], 10), 0 );
is( insert_pos( [qw(11 13 15 17)], 19), 4 );

done_testing();

sub insert_pos {
  my( $t, $l, $val ) = (0,@_);

  ## Repeat unless we have got to end of list or the new entry is greater than val
  $t++ while $t < @{$l} && $l->[$t] < $val;

  ## If we are after the end of the list (to avoid warning) OR
  ## If we haven't found the entry then we use splice to insert it
  splice @{$l},$t,0,$val if $t == @{$l} || $l->[$t] != $val;

    ## Warn to show splice has worked...
    warn ">> $t ( @{$l} )\n"; ## Demonstrate splice

  ## Return the index of the number!
  return $t;
}

