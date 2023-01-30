!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;
use List::MoreUtils qw(slide);

my @TESTS = (
  [ [1,5,5,2,8], '5 5 2 8' ], #1 0 -1 1
  [ [2,6,8,5], '2 6 8' ], # 1 1 -1
  [ [9,8,13,13,2,2,15,17], '13 13 2 2 15 17' ], # 0 1 0 -1 0 1 1
  [ [2,1,2,1,3], '2 1 2'], # -1 1 -1 1
  [ [1,3,3,2,1,2,3,3,2],'3 3 2 1 2 3 3' ], # 1 0 -1 -1 1 1 0 -1
  [ [2,3,2,1], '3 2 1' ], # 1 -1 -1
);
is( "@{[ valley( @{$_->[0]} ) ]}", $_->[1] ) for @TESTS2;
done_testing();

sub valley {
  my( $L, $R, @d )=( 0, 0, slide { $b <=> $a } @_ );
  for my $l ( 0 .. $#d-1) {
    for my $r ( $l+1 .. $#d ) {
      my($x,$t) = ( $d[$l] || -1, $l );
      $d[$t] && ( $d[$t]<$x ? last : ($x=$d[$t]) ) while $t++ < $r;
      ($L,$R)=($l,$t) if $R-$L<$t-$l;
    }
  }
  @_[$L..$R];
}
