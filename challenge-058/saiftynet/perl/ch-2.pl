#!/usr/env/perl
# Task 2 Challenge 058 Solution by saiftynet

# A very interesting problem, demonstrating even virtual people
# can be discriminated according to their height. (A rather touchy
# subject for me as I am fairly short).  It may be solved by sorting
# people by height first and inserting to our final list one at a time
# going from tallest to shortest.  The tallest could be at any poition,
# and has no people taller...the next tallest would be either to his front
# (positon 0) if he/she has no taller people ahead, or to behind
# (position 1).  In fact at the point of insertion each person is going
# to be shorter than those already placed. So at the point of insertion
# his/her position is at an index matching his taller-in-front data.
# Thus three steps are required 
# 1. create a list of people containing  height and taller-in-front data
# 2. sort the list according to height (tallest first)
# 3. insert into a new growing new list at index given by taller-in-front 

# How do we know the result works?...set up a validity test. Generally
# big errors would require an insertion out of the bounds of the array
# would cause an error to be reported if warnings are enabled

use strict;use warnings;

# Heights
my @H = (27, 21, 37,  4, 19, 52, 23, 64,  1,  7, 51, 17, 24, 50,  3,  2,
      34, 40, 47, 20,  8, 56, 14, 16, 42, 38, 62, 53, 31, 41, 55, 59,
      48, 12, 32, 61,  9, 60, 46, 26, 58, 25, 15, 36, 11, 44, 63, 28,
       5, 54, 10, 49, 57, 30, 29, 22, 35, 39, 45, 43, 18,  6, 13, 33);

# Number taller people in front
my @T = ( 6, 41,  1, 49, 38, 12,  1,  0, 58, 47,  4, 17, 26,  1, 61, 12,
      29,  3,  4, 11, 45,  1, 32,  5,  9, 19,  1,  4, 28, 12,  2,  2,
      13, 18, 19,  3,  4,  1, 10, 16,  4,  3, 29,  5, 49,  1,  1, 24,
       2,  1, 38,  7,  7, 14, 35, 25,  0,  5,  4, 19, 10, 13,  4, 12);

my @arranged=();            # the array to be built

# the main algorithm follows, reduced to one statement containing three steps

      # Step 3 insert into array, indexing at [people in front] position 
splice (@arranged,$$_{tallerInFront},0,$_)
      # Step 2 sort that list by height
   foreach (sort {$$b{height} <=> $$a{height} }  
      # Step 1  create List pairing the height and taller-in-front data                    
         map{ {height=>$H[$_],tallerInFront=>$T[$_] } } (0..$#H)  );   

## validity test...goes through each person in the list and tests that 
## the number of people taller that him/her in front matches that required

my $errors="";                           # to pass strict
foreach my $position (0..$#arranged){
  my $count=0;                           # reset counter
  foreach (0..$position-1){              # check all people until that position
     $count++ if $arranged[$_]->{height}>$arranged[$position]->{height}		
  }                                      # add to $count
  # check that $count matches expected, otherwise report position an error                                       
  if ($arranged[$position]->{tallerInFront}!=$count) {
    $errors.="**The result fails validity test: person of height $arranged[$position]->{height}".
             "  should have $arranged[$position]->{tallerInFront} in front but has $count\n";
    last;         # comment this line out to get all errors
  }
}

# display result or error message if there is an error
print $errors?$errors:"One possible answer may be \n(".
       (join ", ", map {$$_{height} } @arranged).")\n";

