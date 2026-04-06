#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 367-2,
written by Robbie Hatley on Tue Mar 31, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 367-2: Conflict Events
Submitted by: Mohammad Sajid Anwar
You are given two events start and end time. Write a script to
find out if there is a conflict between the two events.
A conflict happens when two events have some non-empty
intersection. [Comment by Robbie Hatley: This task is ambiguous
because no dates are given. Example 5 is especially ambiguous
because it can be interpreted in two equally-valid ways (see
my notes below). So to disambiguate, I'll assume that if event2
has a start time before that of event1, then event2's times are
intended to mean the next day.]

Example 1
Input: @event1 = ("10:00", "12:00")
       @event2 = ("11:00", "13:00")
Output: true
Both events overlap from "11:00" to "12:00".

Example 2
Input: @event1 = ("09:00", "10:30")
       @event2 = ("10:30", "12:00")
Output: false
Event1 ends exactly at 10:30 when Event2 starts.
Since the problem defines intersection as non-empty,
exact boundaries touching is not a conflict.

Example 3
Input: @event1 = ("14:00", "15:30")
       @event2 = ("14:30", "16:00")
Output: true
Both events overlap from 14:30 to 15:30.

Example 4
Input: @event1 = ("08:00", "09:00")
       @event2 = ("09:01", "10:00")
Output: false
There is a 1-minute gap from "09:00" to "09:01".

Example 5
Input: @event1 = ("23:30", "00:30")
       @event2 = ("00:00", "01:00")
Output: false? true? (Ambiguous.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Given Event E1 as a reference, the outcome will depend on the beginning and end of event E2.

If E2beg is before E1beg, conflict iff E2end is > E1beg.
If E2beg is during E1, conflit.
If E2beg is after  E1, no conflict.

However, keep in-mind that this task is ambiguous, because no date is associated with any of the times. Example 5 is especially ambiguous because there are two equally valid ways of interpreting it: One can assume that event2's times are both the next day (in which case, there is a conflict), or the same day (in which case there is no conflict because event1 began 22.5 hours after event2 ended). To disambiguate, I'll assume that if event2 has a start time before that of event1, then event2's times are intended to mean the next day.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of pairs of events, with each event being a pair of times (start, end), in proper Perl
syntax, like so:

./ch-2.pl '([["14:30", "17:50"], ["17:45", "19:20"]], [["14:30", "17:50"], ["14:45", "19:20"]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;

   # Aggregate the belchers under the resinous swamps:
   sub events_conflict ( $pair_ref ) {
      # Calculate Event1's times in minutes:
      my $E1 = $pair_ref->[0];
      my $E1_beg_str = $E1->[0];
      my $E1_end_str = $E1->[1];
      my $E1_beg = 60*substr($E1_beg_str, 0, 2) + substr($E1_beg_str, 3, 2);
      my $E1_end = 60*substr($E1_end_str, 0, 2) + substr($E1_end_str, 3, 2);

      # If Event1 has "rolled over", add 1440 minutes to its end time:
      if ($E1_beg > $E1_end) {$E1_end += 1440}

      my $E2 = $pair_ref->[1];
      my $E2_beg_str = $E2->[0];
      my $E2_end_str = $E2->[1];
      my $E2_beg = 60*substr($E2_beg_str, 0, 2) + substr($E2_beg_str, 3, 2);
      my $E2_end = 60*substr($E2_end_str, 0, 2) + substr($E2_end_str, 3, 2);

      # If Event2 has "rolled over", add 1440 minutes to its end time:
      if ($E2_beg > $E2_end) {$E2_end += 1440}

      # If Event2's start time is before Event1's start time, assume that
      # Event2's times are intended to mean the next day so add 1440 minutes:
      if ($E2_beg < $E1_beg) {
         $E2_beg += 1440;
         $E2_end += 1440}

      # Determine if a conflict has occurred:
      my $ret_val = '';
      if ($E2_beg < $E1_beg) {
         if   ($E2_end <= $E1_beg) {$ret_val = 'false'}
         else                      {$ret_val = 'true' }}
      elsif ($E2_beg >= $E1_beg && $E2_beg < $E1_end) {
         $ret_val = 'true'}
      else {
         $ret_val = 'false'}
      return $ret_val}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [
      ["10:00", "12:00"],
      ["11:00", "13:00"],
   ],                     # true

   [
      ["09:00", "10:30"],
      ["10:30", "12:00"],
   ],                     # false

   [
      ["14:00", "15:30"],
      ["14:30", "16:00"],
   ],                     # true

   [
      ["08:00", "09:00"],
      ["09:01", "10:00"],
   ],                     # false

   [
      ["23:30", "00:30"],
      ["00:00", "01:00"],
   ],                     # true
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
say "Note: if Event1 starts before Event2 in any case below,\n"
   ."the times of Event2 are to be construed as being on the next day.";
for my $aref (@arrays) {
   say '';
   my @E1 = @{$aref->[0]};
   my @E2 = @{$aref->[1]};
   say "Event1 is from $E1[0] to $E1[1]";
   say "Event2 is from $E2[0] to $E2[1]";
   my $conf = events_conflict $aref;
   say "Conflict? $conf";
}
