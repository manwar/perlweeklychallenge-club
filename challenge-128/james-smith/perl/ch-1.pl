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
  my @runs = map { [1 - $_->[-1]] } my @rows = @{$_[0]};
  my ($h,$w) = ( @rows-1, @{$rows[0]}-1 );

  ## First pass through the array - we calculate how many
  ## 0s are in the cell and to the right... So for example 1 we get
  ##   0 3 2 1 0 1
  ##   0 0 3 2 1 0
  ##   0 5 4 3 2 1
  ## This is O(n^2)
  foreach my $i (reverse 0..$w-1) {
    unshift @{$runs[$_]}, $rows[$_][$i] ? 0 : $runs[$_][0]+1 foreach 0..$h;
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
        last unless $runs[$j][$x];   ## Short cut all subsequent answers will zero
        $max_w    = $runs[$j][$x]          if $runs[$j][$x] < $max_w;
        my $area  = $max_w * ($j-$y+1);
        $max_area = [$area,$max_w,$j-$y+1] if $area>$max_area->[0];
      }
    }
  }
  return $max_area;
}

