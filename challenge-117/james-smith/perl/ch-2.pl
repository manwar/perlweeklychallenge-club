#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese);

my @TESTS = ( [1,2],[2,6],[3,22],[4,90],[5,394],[6,1806],[7,8558],[8,41586],[9,206098],[10,1037718] );
my $N = @ARGV ? shift @ARGV : 10;
my @cache;

if( $N < 0 ) {
  triangle(-$N,0,'');
  exit;
}

is( schroder_cache_array(   $_->[0] ), $_->[1] ) foreach @TESTS;
is( schroder_non_recursive( $_->[0] ), $_->[1] ) foreach @TESTS;
is( schroder_rec_rel( $_->[0] ), $_->[1] ) foreach @TESTS;

done_testing();

cmpthese( 10000, {
  'recursive'      => sub { @cache=(); schroder_cache_array($N); },
  'non-recursive'  => sub { @cache=(); schroder_non_recursive($N); },
  'recrel'  => sub { @cache=(); ss($N); },
});

sub triangle {
## As asked display results - note as $n gets large storing in an
## array and returning values is too memory intensive - so we will
## just write to file...
## $size   - is the height of the shape remaining;
## $route  - is the letters we've already walked through
## $offset - is how far from the right-side of the triangle you are
##
## We have three options:
##   "L" - increase offset and move down a line
##   "R" - keep offset the same and move down a line
##   "H" - decrease offset and stay on the same row
##         (only available if $offset > 0)
##
## We separate out the special case when we have "height" 0
## We are then on the bottom row - so we can return the current
## string AND add "H"s to move us to the right hand corner..

  my($size,$offset,$route) = @_;
  unless($size) {
    say $route.('H'x$offset);
    return;
  }
  triangle( $size-1, $offset+1, $route.'L' );
  triangle( $size-1, $offset,   $route.'R' );
  triangle( $size,   $offset-1, $route.'H' ) if $offset;
}

sub schroder_cache_array {
## The count is the Schroder number
## We can duplicate the "algorithm above" but counting to display
## the number of routes. We use a cache as we repeatedly hit the
## same tree [there are only $N*($N+1)/2 combinations of $size & $offset.
  my($size,$offset) = @_; $offset ||=0;
  return $size
       ? ( $cache[$size][$offset] ||=
             schroder_cache_array( $size-1, $offset+1 ) #L
           + schroder_cache_array( $size-1, $offset   ) #R
           + ( $offset ? schroder_cache_array( $size, $offset-1 ) : 0 )
         )
       : 1;
}

sub schroder_non_recursive {
## We can rewrite this non-recursively by starting at the bottom row
## (all values 1) and working our way up the triangle {working right
## to left}
## The non-recursive approach is faster {and doesn't suffer
  my $size = shift;
  my @x = map {1} 0..$size;
  foreach my $s (1..$size) {
    my @y = $x[1]+$x[0];
    push @y, $x[$_+1] + $x[$_] + $y[-1] foreach 1..$size-$s;
    @x=@y;
  }
  return $x[0];
}

sub schroder_rec_rel {
## As well as the total calculation above there is a recurance
## relation which defines S_n in terms of S_1 -> S_n-1
## As expected slightly faster than the previous solution
## {but not as easy to derive}
  my $size = shift;
  my @S=(1,2);
  foreach my $n (2..$size) {
    $S[$n]  =     3  * $S[$n-1];
    $S[$n] += $S[$_] * $S[$n-1-$_] foreach 1..$n-2;
  }
  return $S[$size];
}
