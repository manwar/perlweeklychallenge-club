#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 366-2.
Written by Robbie Hatley.
Edit history:
   Mon Mar 23, 2026: Wrote it.
   Tue Mar 24, 2026: Edited it.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 366-2: Valid Times
Submitted by: Mohammad Sajid Anwar
You are given a time in the form ‘HH:MM’. The earliest possible
time is ‘00:00’ and the latest possible time is ‘23:59’. In the
string time, the digits represented by the ‘?’ symbol are
unknown, and must be replaced with a digit from 0 to 9. Write a
script to return the count different ways we can make it a
valid time.

Example 1
Input: $time = "?2:34"
Output: 3

Example 2
Input: $time = "?4:?0"
Output: 12

Example 3
Input: $time = "??:??"
Output: 1440

Example 4
Input: $time = "?3:45"
Output: 3

Example 5
Input: $time = "2?:15"
Output: 4

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll write two subs: One to assure that the string itself is valid, and second to determine how many valid
times can be made from the input string.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted 24h time strings with "?" wildcards, in proper Perl syntax, like so:

./ch-2.pl '("Rambler", "3?:27", "12:??", "2?:4?", "?4:?4", "?2:?8", "2?:3?")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;

   # Is a given wildcarded time string valid?
   sub valid_string ( $s ) {
      return 1 if $s =~ m/^[0-1?][0-9?]:[0-5?][0-9?]$/;
      return 1 if $s =~ m/^  2   [0-3?]:[0-5?][0-9?]$/x;
      say "Warning: \"$s\" is not a valid time string.";
      return 0;
   }

   # Aggregate the belchers under the resinous swamps:
   sub valid_times ( $s ) {
      return 0 if !valid_string($s);
      my ($vtms, $vhrs, $vmns) = (0,0,0);
      # First, count number of valid hours:
      if    ( '?' ne substr($s, 0, 1) && '?' ne substr($s, 1, 1) ) {
         $vhrs = 1;
      }
      elsif ( '?' ne substr($s, 0, 1) && '?' eq substr($s, 1, 1) ) {
         if ( substr($s, 0, 1) > 1 ) {
            $vhrs =  4;
         }
         else {
            $vhrs = 10;
         }
      }
      elsif ( '?' eq substr($s, 0, 1) && '?' ne substr($s, 1, 1) ) {
         if ( substr($s, 1, 1) > 3 ) {
            $vhrs =  2;
         }
         else {
            $vhrs =  3;
         }
      }
      elsif ( '?' eq substr($s, 0, 1) && '?' eq substr($s, 1, 1) ) {
         $vhrs = 24;
      }

      # Next, count number of valid minutes:
      if    ( '?' ne substr($s, 3, 1) && '?' ne substr($s, 4, 1) ) {
         $vmns =  1;
      }
      elsif ( '?' ne substr($s, 3, 1) && '?' eq substr($s, 4, 1) ) {
         $vmns = 10;
      }
      elsif ( '?' eq substr($s, 3, 1) && '?' ne substr($s, 4, 1) ) {
         $vmns =  6;
      }
      elsif ( '?' eq substr($s, 3, 1) && '?' eq substr($s, 4, 1) ) {
         $vmns = 60;
      }

      # Finally, number of valid times is equal to number
      # of valid hours times number of valid minutes:
      $vtms = $vhrs * $vmns;
      return $vtms;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) : ("?2:34", "?4:?0", "??:??", "?3:45", "2?:15");
#                  Expected outputs :     3       12      1440       3        4

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $string (@strings) {
   say '';
   say "Time string = \"$string\".";
   my $vtms = valid_times($string);
   say "Number of valid times: $vtms.";
}
