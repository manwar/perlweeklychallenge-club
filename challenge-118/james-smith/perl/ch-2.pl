#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @dir = ([-2,1],[2,1],[-2,-1],[2,-1],[-1,2],[1,2],[-1,-2],[1,-2]);
my $trans = get_trans();

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


walk_trans( 56, 0, q() );   ## Walk the tree starting from top-left

say '';
say "Treasures: @treasures";
say '#Steps:    ',-1 + length $best_rt;
say 'Route:     ',show_rt( $best_rt ); ## Show best route
say '';

cmpthese( 20, {
  'walk'       => sub { $best_len=65; walk(        0, 7, 0, q() ); show_rt($best_rt); },
  'walk_opt'   => sub { $best_len=65; walk_opt(    0, 7, 0, q() ); show_rt($best_rt); },
  'walk_trans' => sub { $best_len=65; walk_trans( 56, 0, q() );   show_rt($best_rt); },
} );

sub walk {
  my( $x, $y, $seen, $rt ) = @_;
  ## Skip if the new "chain" will be bigger than the best chain so far
  ## If we have fallen off the sides of the board
  ## Or if we have already visited the square.
  return if $x < 0 || $y < 0 || $x > 7 || $y > 7
         || $seen & ( my $v = 1 << ( my $t = 8*$y + $x ) );
  $seen |= $v;
  $rt   .= chr $t;
  return ($best_rt,$best_len) = ($rt,-1+length $rt) if ($seen & $sol) == $sol;
  return if $best_len <= length $rt;
  walk( $x + $_->[0], $y + $_->[1], $seen, $rt ) foreach @dir;
}

sub walk_opt {
  my( $x, $y, $seen, $rt ) = @_;
  ## Skip if the new "chain" will be bigger than the best chain so far
  ## If we have fallen off the sides of the board
  ## Or if we have already visited the square.
  return if $seen & ( my $v = 1 << (my$t=$x+$y*8) );
  $seen |= $v;
  $rt   .= chr $t;
  return (($best_rt,$best_len) = ($rt,-1+length $rt)) if ($seen & $sol) == $sol;
  return if $best_len <= length $rt;
  walk_opt( $x-2, $y+1, $seen, $rt ) if $x>1 && $y<7;
  walk_opt( $x+2, $y+1, $seen, $rt ) if $x<6 && $y<7;
  walk_opt( $x-2, $y-1, $seen, $rt ) if $x>1 && $y;
  walk_opt( $x+2, $y-1, $seen, $rt ) if $x<6 && $y;
  walk_opt( $x-1, $y+2, $seen, $rt ) if $x   && $y<6;
  walk_opt( $x+1, $y+2, $seen, $rt ) if $x<7 && $y<6;
  walk_opt( $x-1, $y-2, $seen, $rt ) if $x   && $y>1;
  walk_opt( $x+1, $y-2, $seen, $rt ) if $x<7 && $y>1;
}

sub show_rt {
  my %t = map { $_ => 1 } @treasures;
  return join q( ),
         map        { $_.( exists $t{$_} ? q(*) : q( ) ) }
         map        { chr( 97 + ($_&7) ).( 1 + ($_>>3) ) }
         map        { ord $_                             }
         split m{}, shift;
}

sub walk_trans {
  my( $t, $seen, $rt ) = @_;  ## Current square, visited squares, current route
  return if $seen & 1 << $t;  ## Return if we've already been to this square.
  $seen |= 1 << $t;           ## Mark that we have been in this square.
  $rt   .= chr $t;            ## Add this square to our route.
  return ($best_rt,$best_len) = ($rt,-1+length $rt) if ($seen & $sol) == $sol;
                              ## If we've found all the treasure
                              ## Update the best route (and it's length)
                              ## and return;
  return if $best_len <= length $rt;
                              ## If our route is longer than the best route
                              ## return;
  walk_trans( $_, $seen, $rt ) foreach @{$trans->[$t]};
                              ## Try all knight move squares from the current
                              ## square.
}
sub get_trans {
  my $q=[];
  foreach my $y (0..7) {
    foreach my $x (0..7) {
      my $l = $x + $y * 8;
      push @{ $q->[$l] }, $l + 6  if $y<7 && $x > 1;
      push @{ $q->[$l] }, $l + 10 if $y<7 && $x < 6;
      push @{ $q->[$l] }, $l - 6  if $y>0 && $x < 6;
      push @{ $q->[$l] }, $l - 10 if $y>0 && $x > 1;
      push @{ $q->[$l] }, $l + 15 if $y<6 && $x > 0;
      push @{ $q->[$l] }, $l + 17 if $y<6 && $x < 7;
      push @{ $q->[$l] }, $l - 15 if $y>1 && $x < 7;
      push @{ $q->[$l] }, $l - 17 if $y>1 && $x > 0;
    }
  }
  return $q;
}
