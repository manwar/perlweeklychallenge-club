#! /usr/bin/perl
# Robbie Hatley's Perl Solution to PWCC 206-1

=pod

Task 1: Shortest Time
Submitted by: Mohammad S Anwar
Write a program to find the shortest time between any two times in a given
list of times, at least 2, in the 24-hour clock format HH:MM.
Example 1:  Input: ("00:00", "23:55", "20:00")           Output: 5
Example 2:  Input: ("01:01", "00:50", "00:57")           Output: 4
Example 3:  Input: ("10:10", "09:30", "09:00", "09:55")  Output: 15

=cut

# IO NOTES:
# NOTE: Input is by either built-in array-of-arrays, or @ARGV. If using @ARGV,
#       the args should be a space-separated sequence of 'single-quoted' 24HR
#       time strings of the form '00:23' (for 23min after midnight) or '15:32'
#       (for 32min after 3PM). This sequence will be considered to be a single
#       array of times.
# NOTE: Output is to STDOUT and will be the shortest time duration.

# PRELIMINARIES:
use v5.36;
$"=", ";

# DEFAULT INPUTS:
my @arrays = 
(
   ["00:00", "23:55", "20:00"], 
   ["01:01", "00:50", "00:57"],
   ["10:10", "09:30", "09:00", "09:55"]
);

# NON-DEFAULT INPUTS:
if (@ARGV) {@arrays = ([@ARGV]);}

# MAIN BODY OF SCRIPT:
for (@arrays){
   my @array = @{$_};
   my @times = map {60*substr($_,0,2)+substr($_,3,2)} @array;
   my @diffs; # elapsed times
   for    ( my $i =    0   ; $i <= $#times - 1 ; ++$i ){
      for ( my $j = $i + 1 ; $j <= $#times - 0 ; ++$j ){
         my ($t1, $t2) = sort {$a<=>$b} ($times[$i], $times[$j]);
         my $te = $t2 - $t1;
         if ($te > 720) {$te = 1440 - $te} 
         push @diffs, $te}}
   my $mindiff = 720;
   for (@diffs) {if ($_<$mindiff) {$mindiff=$_}}
   say '';
   say "Times: @array";
   say "Shortest time difference = $mindiff minutes";}