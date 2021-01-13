#!/usr/bin/perl

# Perl Weekly Challenge - 062
#
# Task 2 - N Queens
#
# Author: Niels 'PerlBoy' van Dijke
#
# Usage: perl ch-2.pl <dimension>
#
# Note: Up to dimension 8 a random setup is searched
#       Above 8 a standard output is produced

use strict;
use warnings;
use List::Util qw(first shuffle);
use IO::Handle;
use Time::HiRes qw(gettimeofday tv_interval);

# Prototype
sub tryPlaceQueen (\%$$$);

my $t0 = [gettimeofday];

# Unbuffered STDOUT
STDOUT->autoflush(1);

my $maxRandomDimension = 8;
my $dimension;

{ 
  no warnings;
  $dimension = sprintf('%d', shift // 4); # 4 is a nice demo for the unique output
}
die "Wrong dimension size" unless $dimension > 0;

my $d0 = $dimension - 1;

my $cc;

my $maxNumberOfQueens = 0;
my $numberOfQueens;

my @p;

# We can loop and create always same output,
# or randomize the output for dimensions up to $maxRandomDimension :-)

# Init placement position list
for my $z (0 .. $d0) {
  for my $y (0 .. $d0) {
    for my $x (0 .. $d0) {
      push (@p, [$z, $y, $x]);
    }
  }
}

# Find the maximum by top-down filling

$cc = {};

foreach my $p (@p) {
  if (tryPlaceQueen(%$cc, $p->[0], $p->[1], $p->[2])) {
    $maxNumberOfQueens++;
  }
}

printf "%5.3fs: Number of queens in the %d x %d cube = %d\n",
        tv_interval($t0), $dimension, $dimension, $maxNumberOfQueens;

if ($dimension > $maxRandomDimension) {
  printf "Note: Dimension given larger than %d, no random solution output\n",
    $maxRandomDimension;

  # Report queen placements 
  printBoard();

  printf "%5.3fs: Done!\n", tv_interval($t0);

  printf "%5.3fs: Number of queens in the %d x %d cube = %d\n",
          tv_interval($t0), $dimension, $dimension, $maxNumberOfQueens;
  exit;
}

# Placing the queens doesn't always provide the maximum.
# Repeat until we do. This can take a while on large dimensions...
# Random output comes at a cost

print "\n";
printf "%5.3fs: Finding first random solution (this can take a while on large dimensions)\n",
  tv_interval($t0);

do {
  print ".";

  @p = shuffle @p;

  $cc = {};

  $numberOfQueens = 0;

  foreach my $p (@p) {
    if (tryPlaceQueen(%$cc, $p->[0], $p->[1], $p->[2])) {
      $numberOfQueens++;
    }
  }
} while ($numberOfQueens < $maxNumberOfQueens);

print "\n";
printf "%5.3fs: Done!\n", tv_interval($t0);

print "\n";

# Report queen placements 
printBoard();

printf "%5.3fs: Number of queens in the %d x %d cube = %d\n",
        tv_interval($t0), $dimension, $dimension, $maxNumberOfQueens;

exit;


sub printBoard {
  for my $z (0 .. $d0) {
    print "z = $z";
    for my $y (0 .. $d0) {
      print "\t";
      for my $x (0 .. $d0) {
        print (defined $cc->{$z}{$d0-$y}{$x} ? $cc->{$z}{$d0-$y}{$x} : '.');
      }
      print "\n";
    }
    print "\n";
  }
}

 
sub tryPlaceQueen (\%$$$) {
  my ($cc, $z, $y, $x) = @_;

  my %d;

  # check all directions for a 'Q' but stop as soon as possible

  if (
    # x-axis
    !first {$_} map {$cc->{$z}{$y}{$_}} 
                        (0 .. $d0) and 
    # y-axis
    !first {$_} map {$cc->{$z}{$_}{$x}} 
                        (0 .. $d0) and
    # z-axis
    !first {$_} map {$cc->{$_}{$y}{$x}} 
                        (0 .. $d0) and 

    # Sloppy solution: don't bother if lookups go outside the chess cube: still undefined ;-)
    # (I should optimize the indexes...)

    # xy-diagonal, positive slope, in z-plane
    !first {$_} map {$cc->{$z}{$y-$_}{$x-$_}}
                        (-$d0 .. $d0) and
     # xy-diagonal, negative slope, in z-plane
     !first {$_} map {$cc->{$z}{$y-$_}{$x+$_}} 
                        (-$d0 .. $d0) and

     # xz-diagonal, positive slope, in y-plane
     !first {$_} map {$cc->{$z-$_}{$y}{$x-$_}}
                        (-$d0 .. $d0) and
     # xz-diagonal, negative slope, in x-plane
     !first {$_} map {$cc->{$z-$_}{$y}{$x+$_}}
                        (-$d0 .. $d0) and

     # yz-diagonal, positive slope, in x-plane
     !first {$_} map {$cc->{$z-$_}{$y-$_}{$x}}
                        (-$d0 .. $d0) and
     # yz-diagonal, negative slope, in x-plane
     !first {$_} map {$cc->{$z+$_}{$y-$_}{$x}}
                        (-$d0 .. $d0) and

     # Don't know how to call these; 3D diagonals
     !first {$_} map {$cc->{$z-$_}{$y-$_}{$x-$_}} 
                        (-$d0 .. $d0) and
     !first {$_} map {$cc->{$z-$_}{$y-$_}{$x+$_}} 
                        (-$d0 .. $d0) and
     !first {$_} map {$cc->{$z-$_}{$y+$_}{$x-$_}} 
                        (-$d0 .. $d0) and
     !first {$_} map {$cc->{$z-$_}{$y+$_}{$x+$_}} 
                        (-$d0 .. $d0) and
     !first {$_} map {$cc->{$z+$_}{$y-$_}{$x-$_}} 
                        (-$d0 .. $d0) and
     !first {$_} map {$cc->{$z+$_}{$y-$_}{$x+$_}} 
                        (-$d0 .. $d0) and
     !first {$_} map {$cc->{$z+$_}{$y+$_}{$x-$_}} 
                        (-$d0 .. $d0) and
     !first {$_} map {$cc->{$z+$_}{$y+$_}{$x+$_}} 
                        (-$d0 .. $d0)
  ) {
    $cc->{$z}{$y}{$x} = 'Q';
  }

  return $cc->{$z}{$y}{$x};
}
