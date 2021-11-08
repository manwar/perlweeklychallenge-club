#!/usr/bin/perl

# Weekly Challenge 126 Task #2
# You are given a rectangle with points marked with either x or *. Please consider the x as a land mine.
# Write a script to print a rectangle with numbers and x as in the Minesweeper game.

use strict;
use warnings;
use List::Util qw( shuffle);

# Sample input to test code
my @input=(['x','*','*','*','x','*','x','x','x','x'],
          ['*','*','*','*','*','*','*','*','*','x'],
          ['*','*','*','*','x','*','x','*','x','*'],
          ['*','*','*','x','x','*','*','*','*','*'],
          ['x','*','*','*','x','*','*','*','*','x']
         );

my $x=$#input+1; # max height
my $y=@{$input[0]}; #max width
my $mines=400; # Used to test input later. I limited code to 20x20, so max is 399
my $max; # Used to test input mines

print "Create random grid (y/n)? ";
my $ans = <STDIN>;
chomp ($ans);

if (lc($ans) eq "y") { # User wants a random grid
  $x=21;
  $y=21;

  while ($y > 20 || $y < 3) { # Arbitrary grid limits
    print "Enter grid width (Values between 3 and 20): ";
    $y = <STDIN>;
    chomp($y);
  }
  while ($x > 20 || $x < 3) { # Arbitrary grid limts
    print "Enter grid height (Values between 3 and 20): ";
    $x = <STDIN>;
    chomp($x);
  }
  while ($mines > $x*$y-1 || $mines <= 0) { # Need at least 1 square that's not a mine
    $max = $x*$y-1;
    print "Enter number of mines (Values must be between 1 and $max): ";
    $mines = <STDIN>;
    chomp($mines);
  }

  my @rands = shuffle 0..$max; # Generate random mine numbers up to maximum size of grid
  my @mines = @rands[0 .. $mines-1]; # "Choose" where the mines go. By grabbing X elements
                                     # of array where X is number of mines user wants
  @input = create_grid(\@mines); # Create the random grid.
}
elsif ($ans ne "n") { # User can't answer a simple y or n question. 
  die "Please only enter y or n. Terminating...\n\n";
}

my @output;
my ($i,$j,$m,$n);
my $count;

# Loop over the multi-dimensional array to count mines
for ($i=0;$i<$x;$i++) {
  for ($j=0;$j<$y;$j++) {
    if ($input[$i][$j] eq 'x') {
      $count="x"; # Spot is a mine, no number should be displayed.
    }
    else {
      $count=check_for_mines(); # Check for the number of mines the spot touches
    }
    $output[$i][$j] = $count; # Create the output grid.
  }
}

# Used to dereference the arrays.
my $df;
my @df;

# Print input grid
print "Input: \n";
foreach(@input) {
  $df=$_;
  @df=@$df;
  print "@df\n";
}

# Print output grid
print "\nOutput: \n";

foreach(@output) {
  $df=$_;
  @df=@$df;
  print "@df\n";
}

# Subroutine check_for_mines
# Count the number of mines that a spot touches and return the value
sub check_for_mines {
  my $check1; my $check2;
  my $Xs=0;
  for ($m=-1;$m<2;$m++) {
    for ($n=-1;$n<2;$n++) {

      if ($i+$m == -1 || $i+$m == $x) {
        # Grid spot doesn't exit, do nothing
      }
      elsif ($j+$n == -1 || $j+$n == $y) {
        # Grid spot doesn't exist, do nothing
      }
      else {
        $Xs++ if $input[$i+$m][$j+$n] eq "x";
      }
    }
  }
  return $Xs;
}
# End of subroutine check_for_mines;

# Subroutine create_grid
# Accept array input that specifies where the mines go;
sub create_grid {
  my $z=0; # Used to help determine if at a mine location;
  my $refmines = $_[0]; # mine locations;
  my @return_grid;

  for ($i=0;$i<$x;$i++) {
    for ($j=0;$j<$y;$j++) {
      if ($z ~~ $refmines) { # If counter is in the mine array, it's a mine!
        $return_grid[$i][$j] = 'x';
      }
      else {
        $return_grid[$i][$j] = '*'; # Not a mine;
      }
      $z++;
    }
  }
  return @return_grid; # Return the grid
}
# End of subroutine create_grid;
