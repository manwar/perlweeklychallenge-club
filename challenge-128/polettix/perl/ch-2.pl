#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

use constant freeup_window => $ENV{FREEUP_WINDOW} // 10;

sub minimum_platforms ($arrivals, $departures) {
   my $pre_massage = sub (@input) {
      sort { $a <=> $b } map {
         my ($h, $m) = split m{:}mxs;
         $h * 60 + $m;
      } @input;
   };
   my @sorted_arrivals = $pre_massage->($arrivals->@*);
   my @sorted_departures = $pre_massage->($departures->@*);
   my $beyond_last = 30 * 60 + freeup_window;
   my ($present, $min, $max) = (0, 0, 0);
   while (@sorted_arrivals || @sorted_departures) {
      my $arrival = @sorted_arrivals ? $sorted_arrivals[0] : $beyond_last;
      my $departure = @sorted_departures ? $sorted_departures[0] : $beyond_last;
      if ($arrival <= $departure + freeup_window) {
         ++$present;
         $max = $present if $present > $max;
         shift @sorted_arrivals;
      }
      else {
         --$present;
         $min = $present if $present < $min;
         shift @sorted_departures;
      }
   }
   return $max - $min;
}

my $arrivals = shift(@ARGV)
   // '10:20 11:00 11:10 12:20 16:20 19:00 22:00 22:10 22:20 22:30';
my $departures = shift(@ARGV)
   // '08:00 08:30 10:15 10:30 10:50 13:20 12:40 12:50 20:20 22:25';
say minimum_platforms([split m{\s+}mxs, $arrivals], [split m{\s+}mxs, $departures]);
