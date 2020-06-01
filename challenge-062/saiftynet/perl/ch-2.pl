#!/usr/env/perl
# Task 2 Challenge 062 Solution by saiftynet
#  › N QueensSubmitted by: Ryan ThompsonA standard 8×8 chessboard 
# has 64 squares. The Queen is a chesspiece that can attack in 8 
# directions, as shown by the green shaded squares below:
# 
# It is possible to place 8 queens on to a single chessboard such 
# that none of the queens can attack each other (i.e., their shaded 
# squares would not overlap). In fact, there are multiple ways to 
# do so, and this is a favourite undergraduate assignment in computer 
# science.
# But here at PWC, we&rsquo;re going to take it into the next dimension!
# Your job is to write a script to work with a three dimensional 
# chess cube, M×M×M in size, and find a solution that maximizes 
# the number of queens that can be placed in that cube without attacking 
# each other. Output one possible solution.


# This was a Bugger.
# Calculating all possibilities and then establishing the highest possible 
# number of queens was taking me too long and I gave up.  Instead here
# is a solution that produces a possible answer, without verifying that 
# it is indeed the highest possible number of queens in the 3D grid.


use strict;use warnings;
my $side=6;                               # number of squares per side 
my @grid;
$grid[$side-1][$side-1][$side-1]=undef;   # initialise 3d grid

print "\n";

tryAll();

sub tryAll{
 my $numberOfQueens=0;
 foreach my $x (0..$side-1){
    foreach my $y (0..$side-1){
      foreach my $z (0..$side-1){
        $numberOfQueens+= placeQueen($x,$y,$z);;
      }
    }
  }
  print "Number of queens in a $side x $side x $side grid is $numberOfQueens\n";
  printGrid();
  
}

# places a queen aa given 3d position if not occupied 
# puts a "." in all places that the queen may strike at
sub placeQueen{   
   my ($x,$y,$z)=@_;
   ($x,$y,$z) = @$x if (ref $x eq "ARRAY");
   return 0 if $grid[$x][$y][$z];  # if occupied or targetted return fail
   $grid[$x][$y][$z]="Q";
   
   # in each of the possible directions 
   foreach my $deltaX(-1..1){
     foreach my $deltaY(-1..1){
       foreach my $deltaZ(-1..1){
          next unless $deltaX or $deltaY or $deltaZ; # ignore "all zero" direction.
          foreach my $distance (1..$side-1){         # for distances in that direction
            my ($testX,$testY,$testZ)=($x+$distance*$deltaX,
                                       $y+$distance*$deltaY,
                                       $z+$distance*$deltaZ);
            last if outOfBounds($testX,$testY,$testZ);  # ignore if out of bounds
                                                     # place a dot at targetted  squares
            $grid[$testX][$testY][$testZ]="." unless $grid[$testX][$testY][$testZ];
          }
       }
     }
   }
   return 1;  # successfuly placed a queen
   
   sub outOfBounds{    # test for bounds 
     my ($x,$y,$z)=@_;
     return 1 if $x < 0      or $y < 0      or $z < 0 or  
              $x >= $side or $y >= $side or $z >= $side;
     return 0;
  }
}

# prints a 3d ish grid;
# for sides larger than 5 the grid is printed vwith vertical pages
# for less than 5 the pages are displayed horizontally
sub printGrid{
  if ($side<=5){ 
    print "",(("_"x($side*2)).(" "x4))x$side,"\n";
    foreach my $x (0..$side-1){
      print " "x$x;
      foreach my $y (0..$side-1){
        foreach my $z (0..$side-1){
          print "\\",($grid[$x][$y][$z]//".");
        }
        print "\\"," "x3;
      }
      print "\n";
    }
     print " "x$side,(("-"x($side*2)).(" "x4))x$side,"\n";
  }
  else{
    foreach my $x (0..$side-1){
      foreach my $y (0..$side-1){
        print " "x$y;
        foreach my $z (0..$side-1){
          print "\\",($grid[$x][$y][$z]//".");
        }
        print "\\\n";
      }
      print "\n";
    }
  }
}

