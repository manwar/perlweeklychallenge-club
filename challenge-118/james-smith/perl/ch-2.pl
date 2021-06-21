#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @dir = ([-2,1],[2,1],[-2,-1],[2,-1],[-1,2],[1,2],[-1,-2],[1,-2]);

my @treasures = qw(a2 b1 b2 b3 c4 e6);
my( $sol, $best_len, $best_rt ) = ( 0, 65 );
$sol |= 1 <<  8 * (substr $_,1) - 105 + ord $_ foreach @treasures;

## We convert the "letter/digit" co-ordinates into a square number
## starting 0 as bottom left, working along each row... to 63 in the
## top right....
##
## As our "perl" version is 64-bit we set the appropriate bit
## this makes checking the solution more easily
##
## We get the solution by "|"ing everything together and use "bit-shift"
## operator to generate the position number..
##
## When we keep track of the path we use the same technique to track
## which squares we have visited.
##
## We store the actual path as a byte string (mapping the 0-63 number
## to bytes using chr/ord.


walk( 0, 7, 0, q() );   ## Walk the tree starting from top-left

say length $best_rt, q( - ), show_rt( $best_rt ); ## Show best route

sub walk {
  my( $x, $y, $seen, $rt ) = @_;
  ## Skip if the new "chain" will be bigger than the best chain so far
  ## If we have fallen off the sides of the board
  ## Or if we have already visited the square.
  return if $x < 0 || $y < 0 || $x > 7 || $y > 7
         || $seen & ( my $v = 1 << ( my $t = 8*$y + $x ) );
  $seen |= $v;
  $rt   .= chr $t;
  return ($best_rt,$best_len) = ($rt,-1+length $rt)
    if ($seen & $sol) == $sol;
  return if $best_len <= length $rt;
  walk( $x + $_->[0], $y + $_->[1], $seen, $rt ) foreach @dir;
}

sub show_rt {
  my %t = map { $_ => 1 } @treasures;
  return join q(),
          map { sprintf ' %s%s', exists$t{$_}?q(*):q( ), $_ }
          map { chr( ($_&7) + 97 ).(1 + ($_>>3)) }
          map { ord $_ }
        split m{}, shift;
}

