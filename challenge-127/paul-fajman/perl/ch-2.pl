#!/usr/bin/perl

# Weekly Challenge 127 Task #2
# You are given a list of intervals.
# Write a script to find out if the current interval conflicts with any of the previous intervals.

use strict;
use warnings;

my $intervals1 = [(1,4),(3,5),(6,8),(12,13),(3,20)];
my $intervals2 = [(3,4),(5,7),(4,6),(10,12),(13,15)];

find_conflicts($intervals1);
find_conflicts($intervals2);

# Subroutine find_conflicts
# This accepts an array reference of coordinates and determines if any of the points conflict
sub find_conflicts {
  my $ints = shift;
  my @ivals = @$ints; 

  my $conflict="no";
  my @conflicts;
  my ($i, $j, $count); 

  # Loop over coordinates array;
  # Because I'm not treating them as pairs, count by 2s.
  for ($i=0; $i<$#ivals; $i+=2) {
    # $count is used to get the ordinal number for printing.
    $count = $i/2 +1; 
    $count =~ s/1?\d\b/$&.((0,"st","nd","rd")[$&]||"th")/eg;

    # No comparisons to make for the first one.
    if ($i eq 0) {
      print "The $count interval ($ivals[$i],$ivals[$i+1]) do not have any previous intervals to compare with, so skip it.\n";
      next;
    }

    # Need to compare current coordinates against all previous coordinates.
    # I do this by going backwards from current coordinates.  
    for ($j=$i; $j > 0; $j-=2) {
      if ($ivals[$i] > $ivals[$j-2] && $ivals[$i] < $ivals[$j-1]) {
         # I use the @conflicts to track coordinates that matched or didn't match.
         # If conflict hasn't been flagged as yes, it'll track the non-matches
         # As soon as there is a conflict, we need to forget the non-matches and
         # only track the conflict coordinates.
         undef(@conflicts) if $conflict eq "no";
         $conflict="yes";
         unshift @conflicts, $ivals[$j-2], $ivals[$j-1]; 
      }
      elsif ($ivals[$i+1] > $ivals[$j-2] && $ivals[$i+1] < $ivals[$j-1]) {
         undef(@conflicts) if $conflict eq "no";
         $conflict="yes";
         unshift @conflicts, $ivals[$j-2], $ivals[$j-1];
      }
      else {
         # No matches, track the non-matching conflicts.
         # If we previous had a match, next.
         next if $conflict eq "yes";
         unshift @conflicts, $ivals[$j-2], $ivals[$j-1];
      } 
    }

    # There was a conflict. Print there was one and which coordinates conflicted.
    if ($conflict eq "yes") {
      print "The $count interval ($ivals[$i],$ivals[$i+1]) does conflict with the previous interval ";
      for ($j=0;$j<$#conflicts;$j+=2) {
        print "($conflicts[$j],$conflicts[$j+1])";
        if ($j eq scalar(@conflicts)-2) {
          print ".";
        }
        else {
          print ", ";
        }
      }
      print "\n";
    }
    # No conflicts, print the previous coordinates tested.
    else {
      print "The $count interval ($ivals[$i],$ivals[$i+1]) do not conflict with any of the previous intervals ";
      for ($j=0;$j<$#conflicts;$j+=2) {
        print "($conflicts[$j],$conflicts[$j+1])";
        if ($j eq scalar(@conflicts)-2) {
          print " ";
        }
        else {
          print ", ";
        }
      }
      print "so skip it.\n";
    }
    $conflict="no";
    undef(@conflicts);
  }
  print "\n";
}
# End of subroutine find_conflicts
