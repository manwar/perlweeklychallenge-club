#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 274-2,
written by Robbie Hatley on Mon Jun 17, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 274-2: Bus Route
Submitted by: Peter Campbell Smith
Several bus routes start from a bus stop near my home, and go to
the same stop in town. They each run to a set timetable, but they
take different times to get into town. Write a script to find the
times - if any - I should let one bus leave and catch a strictly
later one in order to get into town strictly sooner. An input
timetable consists of the service interval, the offset within the
hour, and the duration of the trip.

Example 1:
Input: [ [12, 11, 41], [15, 5, 35] ]
Output: [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47]
Route 1 leaves every 12 minutes, starting at 11 minutes past the
hour (so 11, 23, ...) and takes 41 minutes. Route 2 leaves every
15 minutes, starting at 5 minutes past (5, 20, ...) and takes 35
minutes. At 45 minutes past the hour I could take the route 1
bus at 47 past the hour, arriving at 28 minutes past the
following hour, but if I wait for the route 2 bus at 50 past I
will get to town sooner, at 25 minutes past the next hour.

Example 2:
Input: [ [12, 3, 41], [15, 9, 35], [30, 5, 25] ]
Output: [ 0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45,
         46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59 ]

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I first make a list, in no particular order, of all "trips" within the next 4 hours (NOT 1 hour!!!),
with each "trip" being a two-element array [dep,arr] giving departure and arrival times. Each departure and
arrival time will be "minutes after start of current hour", which may in the NEXT hour, or the NEXT,
hence the need to collect trips for next 4 hours rather than just 1.

Next, I mark those trips which should be skipped because there exists a trip with a later departure but
earlier arrival with the word "skip".

Then, for each minute within the current hour, I check the "next" trip to see if it should be skipped; if so,
I add that minute to a @skips list.

Finally, I return @skips.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of arrays, with each inner-most array being three non-negative integers,
which are interval, offset, and duration:
./ch-2.pl '([[3,8,17],[6,4,52]],[[17,3,22],[5,4,33]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

use v5.38;
use List::Util 'uniq';
$" = ', ';

sub skip (@timetables) {
   my @trips; # All trips.
   my @skips; # Times at which next trip should be skipped.

   # Get trips:
   foreach my $tref (@timetables) {
      my ($int, $off, $dur) = @$tref;
      my $dep = $off;
      while ($dep < 240) { # Next 4 hours.
         my $arr = $dep + $dur;
         push @trips, [$dep, $arr, 'take'];
         $dep += $int;
      }
   }

   # Sort trips:
   @trips = sort {$$a[0]<=>$$b[0]||$$a[1]<=>$$b[1]} @trips;

   # Mark trips which should be skipped:
   foreach my $trip1 (@trips) {
      foreach my $trip2 (@trips) {
         next unless $$trip2[0] > $$trip1[0];
         # If there's a later departure with earlier arrival,
         # then mark $trip1 to be skipped:
         if ($$trip2[1] < $$trip1[1]) {
            $$trip1[2] = 'skip';
            last;
         }
      }
   }

   # Diagnostics:
   # say 'Trips = ';
   # say "@$_" for @trips;

   # Collect minutes for which "next trip should be skipped":
   for my $minute (0..59) {
      for my $trip (@trips) {
         next if $$trip[0] < $minute;
         if ($$trip[2] eq 'skip') {
            push @skips, $minute;
         }
         last;
      }
   }

   # Return result:
   @skips;
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   [ [12, 11, 41], [15, 5, 35] ],
   # Expected output:
   # [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47]

   # Example 2 input:
   [ [12, 3, 41], [15, 9, 35], [30, 5, 25] ],
   # Expected output:
   # [0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59 ]
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   my @timetables = @$aref;
   my @ttstrings = map {'[' . "@$_" . ']'} @timetables;
   say "Times = @ttstrings";
   my @skips = skip(@timetables);
   say "Skips = @skips";
}
