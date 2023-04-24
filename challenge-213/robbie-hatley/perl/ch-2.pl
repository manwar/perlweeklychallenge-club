#! /bin/perl -CSDA

=pod

------------------------------------------------------------------------------------------
COLOPHON:
This is a 90-character-wide UTF-8 Perl-source-code text file with hard Unix line breaks.
=========|=========|=========|=========|=========|=========|=========|=========|=========|

------------------------------------------------------------------------------------------
TITLE BLOCK:
ch-2.pl
Robbie Hatley's Perl solutions for The Weekly Challenge 213-2.
Written by Robbie Hatley on Wed Apr 19, 2023.

------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:

Task 2: Shortest Route
Submitted by: Mohammad S Anwar
You are given a list of bidirectional routes defining a network of nodes, as well as 
source and destination node numbers. Write a script to find the route from source to
destination that passes through fewest nodes, or print -1 of no such route exists.

Example 1:
Inputs: @routes = ([1,2,6], [5,6,7])
        $source = 1
        $destination = 7
Output: (1,2,6,7)
Source (1) is part of route [1,2,6] so the journey looks like 1 -> 2 -> 6
then jump to route [5,6,7] and takes the route 6 -> 7.
So the final route is (1,2,6,7)

Example 2:
Inputs: @routes = ([1,2,3], [4,5,6])
        $source = 2
        $destination = 5
Output: -1
(No route is possible.)

Example 3:
Inputs: @routes = ([1,2,3], [4,5,6], [3,8,9], [7,8])
        $source = 1
        $destination = 7
Output: (1,2,3,8,7)
Source (1) is part of route [1,2,3] so the journey looks like 1 -> 2 -> 3
then jump to route [3,8,9] and takes the route 3 -> 8
then jump to route [7,8] and takes the route 8 -> 7
So the final route is (1,2,3,8,7)

------------------------------------------------------------------------------------------
PROBLEM NOTES:


------------------------------------------------------------------------------------------
INPUT / OUTPUT NOTES:

Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument
which must be a 'single-quoted' array of arrays in correct Perl syntax, with each array
consisting of source, followed by destination, followed by a sequence of arrays of 
integers representing various routes, like so:
./ch-2.pl '([4, -34, [5, -37, 4], [-3, 2, 5], [2, 6, -34]], [1, 5, [1,3,7], [5,6,7]])'

Output is to STDOUT and will consist of the inputs followed by the shortest route of any,
or -1 of no route exists from source to destination.

=cut

# ======= PRELIMINARIES: =================================================================
# 
use v5.36;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use Time::HiRes 'time';
use List::AllUtils;
$"=', ';

# ======= SUBROUTINES: ===================================================================

sub shortest ($srce, $dest, $routes, $path) {
   my @sri; # Srce Route Indexes.
   my @dri; # Dest Route Indexes.
   for ( my $i = 0 ; $i <= $#$routes ; ++$i ) {
      push @sri, $i if any { $_ == $srce } @{${$routes}[$i]};
      push @dri, $i if any { $_ == $dest } @{${$routes}[$i]};
   }
   
   @$path = (-1);
}

# ======= DEFAULT INPUTS: ================================================================

my @arrays = 
(
   [1, 7, [1,2,6], [5,6,7]],
   [2, 5, [1,2,3], [4,5,6]],
   [1, 7, [1,2,3], [4,5,6], [3,8,9], [7,8]],
);

# ======= NON-DEFAULT INPUTS: ============================================================

if (@ARGV) {@arrays = eval($ARGV[0]);}

# ======= MAIN BODY OF PROGRAM: ==========================================================

{ # begin main
   my $t0 = time;
   say 'Incomplete. (Stub.)';
   for (@arrays){
      my $srce    = $$_[0];
      my $dest    = $$_[1];
      my $routes  = [@$_[2..$#$_]];
      my $path    = [];
      my $success = shortest ($srce, $dest, $routes, $path);
      say '';
      print "srce: $srce  dest: $dest  routes: ";
      for ( my $i = 0 ; $i <= $#$routes ; ++$i ) {
         print "[@{${$routes}[$i]}]";
         print ', ' if $i != $#$routes;
      }
      print "\n";
      say "Shortest route: @$path";
   }
   my $µs = 1000000 * (time - $t0);
   printf("\nExecution time was %.3fµs.\n", $µs);
   exit 0;
} # end main
