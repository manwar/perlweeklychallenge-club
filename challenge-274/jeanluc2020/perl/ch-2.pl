#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-274/#TASK2
#
# Task 2: Bus Route
# =================
#
# Several bus routes start from a bus stop near my home, and go to the same
# stop in town. They each run to a set timetable, but they take different times
# to get into town.
#
# Write a script to find the times - if any - I should let one bus leave and
# catch a strictly later one in order to get into town strictly sooner.
#
# An input timetable consists of the service interval, the offset within the
# hour, and the duration of the trip.
#
# Example 1
#
# Input: [ [12, 11, 41], [15, 5, 35] ]
# Output: [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47]
#
# Route 1 leaves every 12 minutes, starting at 11 minutes past the hour (so 11,
# 23, ...) and takes 41 minutes. Route 2 leaves every 15 minutes, starting at 5
# minutes past (5, 20, ...) and takes 35 minutes.
#
# At 45 minutes past the hour I could take the route 1 bus at 47 past the hour,
# arriving at 28 minutes past the following hour, but if I wait for the route 2
# bus at 50 past I will get to town sooner, at 25 minutes past the next hour.
#
# Example 2
#
# Input: [ [12, 3, 41], [15, 9, 35], [30, 5, 25] ]
# Output: [ 0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59 ]
#
############################################################
##
## discussion
##
############################################################
#
# This one is a bit more complicated. First, we collect the data for
# each bus line from the command line. While at it, we also initialize
# two arrays for each line: The times of departure and the corresponding
# arrivals. We fill those next by calculating each departure in the hour
# together with the corresponding arrival time (in minutes relative to
# the beginning of the current hour, so it's perfectly fine to have a number
# > 60 for the arrival).
# Now for each minute (0 through 59), we sort the bus lines by the next
# departure time - if no more departure happens during this hour, take the
# first one in the next hour (by adding 60 minutes to the first one in this
# hour). We look at the arrival times of all bus lines sorted by departure
# time. This way, if any arrival time is before the soonest arrival time
# of the soonest departure time, we are better off waiting (yes, we have to
# handle the case that two buses start at the same time).

use strict;
use warnings;
use Data::Dumper;

bus_route( [ [12, 11, 41], [15, 5, 35] ] );
bus_route( [ [12, 3, 41], [15, 9, 35], [30, 5, 25] ] );

sub bus_route {
   my $buses = shift;
   my $line = 0;
   my $data;
   foreach my $bus (@$buses) {
      $line++;
      $data->{$line} = {
         interval => $bus->[0],
         first => $bus->[1],
         duration => $bus->[2],
         times => [ $bus->[1] ],
         arrivals => [ $bus->[1] + $bus->[2] ],
      };
      my $f = $data->{$line}->{first};

      while($f < 60) {
         $f += $data->{$line}->{interval};
         my $arrival = $f + $data->{$line}->{duration};
         if($f < 60) {
            push @{ $data->{$line}->{times} }, $f;
            push @{ $data->{$line}->{arrivals} }, $arrival;
         }
      }
   }

   my @result = ();
   MINUTE: foreach my $minute (0..59) {
      my $this_schedule = {};
      foreach my $line (sort {$a <=> $b } keys %$data) {
         my $index = 0;
         foreach my $time (@{ $data->{$line}->{times} }) {
            if($time >= $minute) {
               $this_schedule->{$line}->{time} = $time;
               $this_schedule->{$line}->{arrival} = $data->{$line}->{arrivals}->[$index];
               last;
            }
            $index++;
         }
         unless($this_schedule->{$line}) {
            $this_schedule->{$line}->{time} = $data->{$line}->{times}->[0] + 60;
            $this_schedule->{$line}->{arrival} = $data->{$line}->{arrivals}->[0] + 60;
         }
      }
      my @lines_by_time = sort { $this_schedule->{$a}->{time} <=> $this_schedule->{$b}->{time} } keys %$this_schedule;
      my ($start, $arrival) = ( $this_schedule->{ $lines_by_time[0] }->{time}, $this_schedule->{ $lines_by_time[0] }->{arrival} );
      foreach my $line (@lines_by_time) {
         my $s = $this_schedule->{$line}->{time};
         my $a = $this_schedule->{$line}->{arrival};
         if($a < $arrival) {
            $arrival = $a;
            if($s > $start) {
               push @result, $minute;
               next MINUTE;
            }
         }
      }
   }
   print "Output: [", join(", ", @result), "]\n";
}
