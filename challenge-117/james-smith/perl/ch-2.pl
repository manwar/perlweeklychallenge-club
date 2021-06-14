#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese);

my @TESTS = ( [1,2],[2,6],[3,22],[4,90],[5,394],[6,1806],[7,8558],[8,41586],[9,206098],[10,1037718] );
my $N = @ARGV ? shift @ARGV : 0;
my @cache;

## Usage - this script does both the dump list AND count list
##
## ./ch-2.pl {n}  <- runs the benchmarking for the three different
##                   count methods recursive/non-recursive/rec relations
## ./ch-2.pl      <- runs the test suite for the counts...
## ./ch-2.pl -{n} <- dumps the list for "n"
##
## e.g.
##
## > ./ch-2.pl -4
##
## LLLHHH
## LLRHH
## LLHLHH
## LLHRH
## LLHHLH
## LLHHR
## LRLHH
## LRRH
## LRHLH
## LRHR
## LHLLHH
## LHLRH
## LHLHLH
## LHLHR
## LHRLH
## LHRR
## RLLHH
## RLRH
## RLHLH
## RLHR
## RRLH
## RRR

if( $N < 0 ) { ## Run recursive dumper!
  triangle( -$N, 0, '' );
  exit;
}

unless( $N ) { ## Run the test scripts
  is( schroder_cache_array(    $_->[0] ), $_->[1] ) foreach @TESTS;
  is( schroder_non_recursive(  $_->[0] ), $_->[1] ) foreach @TESTS;
  is( schroder_recurrence_rel( $_->[0] ), $_->[1] ) foreach @TESTS;
  done_testing();
  exit;
}

## Run the benchmarking....

cmpthese( 10000, {
  'recursive'     => sub { @cache=(); schroder_cache_array(    $N ); },
  'non-recursive' => sub {            schroder_non_recursive(  $N ); },
  'recrel'        => sub {            schroder_recurrence_rel( $N ); },
});

sub triangle {
## As asked display results - note as $n gets large storing in an
## array and returning values is too memory intensive - so we will
## just write to STDOUT...
##
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
    say $route.( 'H' x $offset );
    return;
  }
  triangle( $size - 1, $offset + 1, $route.'L' );
  triangle( $size - 1, $offset,     $route.'R' );
  triangle( $size,     $offset - 1, $route.'H' ) if $offset;
}

sub schroder_cache_array {
## The count is the Schroder number
## We can duplicate the "algorithm above" but counting to display
## the number of routes. We use a cache as we repeatedly hit the
## same tree [there are only $N*($N+1)/2 combinations of $size & $offset.]
## As the indecies are integers and contiguous - it is easier/faster to
## use an array here as a cache rather than a hash. We use a global as
## we are benchmarking and it is difficult to flush the cache when
## repeated calls are made..
  my($size,$offset) = @_; $offset ||=0;
  return $size
       ? ( $cache[$size][$offset] ||=
             schroder_cache_array( $size - 1, $offset + 1 ) #L
           + schroder_cache_array( $size - 1, $offset     ) #R
           + ( $offset ? schroder_cache_array( $size, $offset - 1 ) : 0 )
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
    my @y = $x[1] + $x[0];
    push @y, $x[$_+1] + $x[$_] + $y[-1] foreach 1 .. $size-$s;
    @x=@y;
  }
  return $x[0];
}

sub schroder_recurrence_rel {
## As well as the total calculation above there is a recurrence
## relation which defines S_n in terms of S_1 -> S_n-1
## As expected slightly faster than the previous solution
## {but not as easy to derive}
  my $size = shift;
  my @S = ( 1, 2 );
  foreach my $n (2..$size) {
    $S[ $n ]  =        3 * $S[ $n - 1      ];
    $S[ $n ] += $S[ $_ ] * $S[ $n - 1 - $_ ] foreach 1..$n-2;
  }
  return $S[ $size ];
}
