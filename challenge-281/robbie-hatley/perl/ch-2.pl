#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 281-2,
written by Robbie Hatley on Mon Aug 05, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 281-2: Knight’s Move
Submitted by: Peter Campbell Smith
Write a script which calculates the minimum number of moves for
a knight to get from one square to another on a chess board,
given the start and end locations in algebraic notation.

Example 1:
Input: ['g2', 'a8']
Ouput: 4
Path:  g2 -> e3 -> d5 -> c7 -> a8

Example 2:
Input: ['g2', 'h2']
Ouput: 3
Path:  g2 -> e3 -> f1 -> h2

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I suppose I could use recursion for this and use recursion depth as "hops" counter, but that would involve
accessing global variables from within functions (which seems nasty) and a deep stack (which I don't like).
So I'll use a variant of Breadth-First Search. I'll make a hash "%Squares" of all 64 squares, with their keys
being their algebraic notations and their values being [visited, hops] all initialized to [0,inf] except for
start which is [0,0]. I'll make a variable "$current" to keep track of "current hops from start". I'll then
process the itinerary for so long as its not empty by doing the following:
   1. Shift left-most "@itinerary" square into "$current".
   2. Set current as "visited".
   3. Get octopus of squares which can be visited next.
   4. For each unvisited arm of octopus, set hops current+1 and push onto right end of "@itinerary".
After the queue empties, $squares{$end}->[1] should contain "minimum hops to get from start to end".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two double-quoted algebraic chess notations, in proper Perl syntax, like so:
./ch-2.pl '(["a1","a8"],["c2","e7"],["c3","f6"],["a1","g8"],["a1","h8"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

# Use Perl version "v5.36" or higher so we can use "signatures":
use v5.36;

# Is a given algebraic notation valid?
sub valid_alg ($x) {$x =~ m/^[a-h][1-8]$/}

# Is a given 0-indexed coordinate valid?
sub valid_coord ($x) {$x->[0] >= 0 && $x->[0] <= 7 && $x->[1] >= 0 && $x->[1] <= 7}

# Convert algebraic notation to 0-indexed coordinate:
sub alg_to_coord ($x) {return [ord(substr($x,0,1))-97,ord(substr($x,1,1))-49]}

# Convert 0-indexed coordinate to algebraic notation:
sub coord_to_alg ($x) {return chr($x->[0]+97).chr($x->[1]+49)}

# The moves a chess knight can make are an 8-armed octopus:
sub octopus ($x) {
   # Convert algebraic notation to 0-indexed coordinate:
   my $coord = alg_to_coord($x);

   # Make an octopus:
   my @octopus;

   # Add up to 8 tentacles to octopus:
   my @hooks = ([+1,+2],[+2,+1],[-1,+2],[-2,+1],[-1,-2],[-2,-1],[+1,-2],[+2,-1]);
   for my $hook (@hooks) {
      my $tentacle = [$coord->[0]+$hook->[0],$coord->[1]+$hook->[1]];
      if (valid_coord($tentacle)) {push @octopus, coord_to_alg($tentacle)}
   }

   # Return octopus to caller:
   return @octopus;
}

# What is the minimum number of hops for a chess knight to get from point A to point B?
sub min_hops ($start, $end) {
   # Make a hash of 64 squares with keys being algebraic coordinates and values being [visited,hops],
   # and initialize all values to {visited => 0, hops => undef}:
   my %squares;
   for my $x ('a'..'h') {
      for my $y (1..8) {
         $squares{$x.$y} = {visited => 0, hops => undef};
      }
   }

   # Because "$start" is our reference point for measuring hops, set its hops to 0:
   $squares{$start}->{hops} = 0;

   # Make an itinerary of squares to visit:
   my @itinerary;

   # The first stop on our itinerary is our starting point:
   push @itinerary, $start;

   # Make a "$current" variable to keep track of our current location:
   my $current;

   # Process itinerary while it's not empty:
   while (@itinerary) {
      # Visit next location on itinerary by shifting it from left end to $current:
      $current = shift @itinerary;

      # Mark "$current" as "visited":
      $squares{$current}->{visited} = 1;

      # Have we reached our destination? If so, stop traveling and return how many hops it took to get here:
      if ($current eq $end) {return $squares{$current}->{hops}}

      # Get a list of squares we can move to from here:
      my @octopus = octopus($current);

      # For each arm of the octopus, if it hasn't yet been visited, set its "hops" to current+1 and push it
      # onto right end of itinerary:
      for my $arm (@octopus) {
         if (!$squares{$arm}->{visited}) {
            $squares{$arm}->{hops} = $squares{$current}->{hops}+1;
            push @itinerary, $arm;
         }
      }
   }

   # We can't possibly get here. But if we do, inform user that something bizarre has happened and die:
   die "I have climbed highest mountains; I have trod through the fields;\n"
      ."I have run, I have crawled, I have scaled these city walls, only to\n"
      ."be with you; but I still haven't found what I'm looking for.\n";
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) : (['g2', 'a8'],['g2', 'h2']);
#                   Expected outputs:       4            3

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   my $start = $aref->[0]; if (!valid_alg($start)) {say 'Error: invalid start \"$start\"'; next}
   my $end   = $aref->[1]; if (!valid_alg($end  )) {say 'Error: invalid end \"$end\"'; next}
   my $hops  = min_hops($start, $end);
   say "Start: $start  End: $end  Hops : $hops";
}
