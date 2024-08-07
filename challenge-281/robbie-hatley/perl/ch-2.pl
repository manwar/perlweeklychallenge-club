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
accessing global variables from within functions (which seems nasty) and deep stacks (which I don't like).
So I'll use a variant of Breadth-First Search. I'll make a hash "%Squares" of all 64 squares, with their keys
being their algebraic notations and their values being [visited, hops] all initialized to [0,inf] except for
start which is [0,0]. I'll make a variable $current to keep track of "current hops from start" and initialize
it to $start. I'll then process the itinerary for so long as its not empty by doing the following:
   1. Shift each square in the itinerary from the left into variable "$next".
   2. Set "hops" for next to min(existing, current+1).
   3. Set current = next.
   4. Set current as "visited".
   5. Get "octopus" of squares which can be visited next.
   6. For each "arm", set its hops to min(existing, 1+current).
   7. Push each unvisited arm onto right of itinerary.
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

# Insist on using Perl version "v5.40" or higher in order to get "inf":
use v5.40;

# Allow experimental "inf", "nan":
use experimental 'builtin';

# Use the "min" function from "List::Util":
use List::Util 'min';

# Do we want to debug?
my $db = 0;

# Is a given algebraic notation valid?
sub valid_alg ($x) {$x =~ m/^[a-h][1-8]$/}

# Is a given 0-indexed coordinates valid?
sub valid_coords ($x) {$x->[0] >= 0 && $x->[0] <= 7 && $x->[1] >= 0 && $x->[1] <= 7}

# Convert algebraic notation to 0-indexed coordinates:
sub alg_to_coords ($x) {
   # Return "error" is $alg isn't valid algebraic notation:
   return 'error' if !valid_alg($x);

   # Convert algebraic notation to 0-indexed coordinates and return to sender:
   return [ord(substr($x,0,1))-97,ord(substr($x,1,1))-49];
}

# Convert algebraic notation to 0-indexed coordinates:
sub coords_to_alg ($x) {
   # Return "error" is $x aren't valid:
   return 'error' if !valid_coords($x);

   # Convert 0-indexed coordinates to algebraic notation and return to sender:
   return chr($x->[0]+97).chr($x->[1]+49);
}

# The moves a chess knight can make are an 8-armed octopus:
sub octopus ($x) {
   # Return "error" is $x isn't valid algebraic notation:
   return 'error' if $x !~ m/^[a-h][1-8]$/;

   # Convert algebraic notation to 0-indexed coordinates:
   my $coords = alg_to_coords($x);

   # Make an octopus:
   my @octopus;

   # Add up to 8 arms to octopus:
   my $arm;

   # Arm 1:
   $arm = [$coords->[0]+1,$coords->[1]+2];
   if (valid_coords($arm)) {push @octopus, coords_to_alg($arm)}

   # Arm 2:
   $arm = [$coords->[0]+2,$coords->[1]+1];
   if (valid_coords($arm)) {push @octopus, coords_to_alg($arm)}

   # Arm 3:
   $arm = [$coords->[0]+2,$coords->[1]-1];
   if (valid_coords($arm)) {push @octopus, coords_to_alg($arm)}

   # Arm 4:
   $arm = [$coords->[0]+1,$coords->[1]-2];
   if (valid_coords($arm)) {push @octopus, coords_to_alg($arm)}

   # Arm 5:
   $arm = [$coords->[0]-1,$coords->[1]-2];
   if (valid_coords($arm)) {push @octopus, coords_to_alg($arm)}

   # Arm 6:
   $arm = [$coords->[0]-2,$coords->[1]-1];
   if (valid_coords($arm)) {push @octopus, coords_to_alg($arm)}

   # Arm 7:
   $arm = [$coords->[0]-2,$coords->[1]+1];
   if (valid_coords($arm)) {push @octopus, coords_to_alg($arm)}

   # Arm 8:
   $arm = [$coords->[0]-1,$coords->[1]+2];
   if (valid_coords($arm)) {push @octopus, coords_to_alg($arm)}

   # Return this monster to caller:
   return @octopus;
}

sub min_hops ($start, $end) {
   # Abort if start or end points are not valid algebraic coordinates on a chess board:
   return 'error' if $start !~ m/^[a-h][1-8]$/;
   return 'error' if $end   !~ m/^[a-h][1-8]$/;

   # Make a hash of 64 squares with keys being algebraic coordinates and values being [visited,hops],
   # and initialize all values to [0,inf] meaning [not visited, indefinite distance away]:
   my %squares;
   for my $x ('a'..'h') {
      for my $y (1..8) {
         $squares{$x.$y}=[0,builtin::inf];
      }
   }

   # Since "start" is 0 hops away from "start', set its hops 0:
   $squares{$start}->[1]=0;

   # Make-and-initialize an itinerary of squares to visit, starting with the "start" square:
   my @itinerary = ($start);

   # Make a "$current" variable to keep track of our current location and how many hops from "start" we are,
   # and initialize it to $start so that its "hops from start" starts at 0:
   my $current = $start;

   # Process itinerary while it's not empty:
   while (@itinerary) {
      # Grab next location to visit by shifting it from left end of itinerary:
      my $next = shift @itinerary;

      # Sanity check: return "error" if $next is not valid algebraic notation:
      return 'error' if !valid_alg($next);

      # Set $next's hops to min(existing, 1+current):
      $squares{$next}->[1] = min($squares{$next}->[1], 1 + $squares{$current}->[1]);

      # Visit $next by setting $current = $next and marking $current as "visited":
      $current = $next;
      $squares{$current}->[0]=1;

      # Get a list of squares we can move to from here:
      my @octopus = octopus($current);

      # For each arm of the octopus, set its "hops" to min(existing, 1+current),
      # to indicate that we COULD get to it from start in no-more-than that number of hops,
      # and if it hasn't been visited yet, push it onto itinerary:
      for my $arm (@octopus) {
         # NOTE RH 2024-08-07: I've verified that this sub gives wrong (HIGH!) values without this next line:
         $squares{$arm}->[1] = min($squares{$arm}->[1], 1 + $squares{$current}->[1]);
         # Now that we've addressed the (VERY IMPORTANT) "squares we don't intend to visit again" above,
         # we can enqueue the squares we DO intend to visit:
         push @itinerary, $arm if 0 == $squares{$arm}->[0];
      }
   }

   # Print grid if debugging:
   if ($db) {
      say '';
      say "$_ $squares{$_}->[0] $squares{$_}->[1]" for sort keys %squares;
      say '';
   }

   # Return the minimum number of hops to get from start to end:
   return $squares{$end}->[1]
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   ['g2', 'a8'],
   # Expected output: 4

   # Example 2 input:
   ['g2', 'h2'],
   # Expected output: 3
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   my $start = $aref->[0];
   my $end   = $aref->[1];
   my $hops  = min_hops($start, $end);
   say "Start: $start  End: $end  Hops : $hops";
}
