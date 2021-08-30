#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @arr1 = (
  [qw( 1 0 0 0 1 0 )],
  [qw( 1 1 0 0 0 1 )],
  [qw( 1 0 0 0 0 0 )],
);
my @arr2 = (
  [qw( 0 0 1 1 )],
  [qw( 0 0 0 1 )],
  [qw( 0 0 1 0 )],
);
my @TESTS = ( [ \@arr1, '6 2 3' ], [ \@arr2, '6 2 3' ],);

is( "@{ find_empty( $_->[0]) }", $_->[1] ) foreach @TESTS;

done_testing();

sub find_empty {
  my @rows = @{$_[0]};
  my $h = @rows-1;
  my $w = @{$rows[0]}-1;
  my @runs = map { [1 - $_->[-1]] } @rows;

  ## First pass through the array - we calculate how many
  ## 0s are in the cell and to the right... So for example 1 we get
  ##   0 3 2 1 0 1
  ##   0 0 3 2 1 0
  ##   0 5 4 3 2 1
  ## This is O(n^2)
  foreach my $i (reverse 0..$w-1) {
    foreach my $j (0..$h) {
      unshift @{$runs[$j]}, $rows[$j][$i] ? 0 : $runs[$j][0]+1;
    }
  }
  ## Now we have to loop over all squares and check rectangles starting
  ## at the square and going down and to the right...
  ## This is now an O(n^3) operation reduced from the O(n^4) operation
  ## by working with run lengths...
  ## Effectively the O(n^2) operation above removes the inner loop of
  ## scanning right for 0s...

  my $max_area = [0,0,0];
  foreach my $x ( 0..$w ) {
    foreach my $y ( 0..$h ) {
      next unless $runs[$y][$x];  ## Short cut answer will be 0
      my $max_w = 1e9;
      foreach my $j ( $y..$h ) {
        $max_w = $runs[$j][$x] if $runs[$j][$x] < $max_w;
        last unless $max_w;   ## Short cut all subsequent answers will zero
        my $area = $max_w * ($j-$y+1);
        $max_area = [$area,$max_w,$j-$y+1] if $area>$max_area->[0];
      }
    }
  }
  return $max_area;
}

