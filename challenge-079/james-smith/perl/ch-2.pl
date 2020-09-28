#!/usr/bin/perl

use strict;
use feature qw(say);
use warnings;

say trapped_rain_water( qw(2 1 4 1 2 5) );

say trapped_rain_water( qw(3 1 3 1 1 5) );

## Function draws chart - and returns amount of water trapped...
## Output below for two runs

#
# heights: 2 1 4 1 2 5         heights: 3 1 3 1 1 5
#
#   5 |                ##        5 |                ##
#   4 |       ## ~~ ~~ ##        4 |                ##
#   3 |       ## ~~ ~~ ##        3 | ## ~~ ## ~~ ~~ ##
#   2 | ## ~~ ## ~~ ## ##        2 | ## ~~ ## ~~ ~~ ##
#   1 | ## ## ## ## ## ##        1 | ## ## ## ## ## ##
#  -- + -- -- -- -- -- --       -- + -- -- -- -- -- --
#     |  2  1  4  1  2  5          |  3  1  3  1  1  5
#
# 6                            6
#

sub trapped_rain_water { ## Returns amount of water trapped
  my @heights = @_;      ## Heights of each "column"
  my @water_heights = [$heights[0],$heights[0]];
  my $t = 0;
  my $h = 0;
  ## Keep height of "histogram" for purposes of display only..
  foreach( @heights ) {
    $h = $_ if $h < $_;
  }
  foreach my $x (1 .. @heights-2 ) {
    my $lh = my $rh = 0;
    ## Find highest value left and right of the current column...
    foreach (0 .. $x-1) {
      $lh = $heights[$_] if $lh < $heights[$_];
    }
    foreach ($x+1 .. @heights-1) {
      $rh = $heights[$_] if $rh < $heights[$_];
    }
    ## If these are both above the height of the current column then
    ## water will collect in the column - it will be the smaller of
    ## these two totals minus the height of the current ground...
    my $th = ($lh < $rh ? $lh : $rh);
    ## We will keep water heights so we can draw the water levels on
    ## the picture
    push @water_heights, [ $heights[$x], $th ];
    $t += $th-$heights[$x] if $heights[$x] < $th;
  }

  push @water_heights, [$heights[-1],$heights[-1]];

  print "\n";
  ## Draw the levels -> "##" for rock, "~~" for water...
  foreach my $y ( reverse 1 .. $h ) {
    printf " %2d |%s\n", $y, join q(), map { $_->[0] < $y ? ( $_->[1] < $y ? q(   ) : q( ~~) ) : q( ##) } @water_heights;
  }
  ## Draw the horizontal axis
  printf " -- +%s\n", join q(), map { q( --) } @heights;
  printf "    |%s\n", join q(), map { sprintf ' %2d', $_ } @heights;
  print "\n";

  return $t;
}

