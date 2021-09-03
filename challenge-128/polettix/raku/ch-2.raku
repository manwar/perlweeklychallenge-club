#!/usr/bin/env raku
use v6;

constant \freeup-window = +(%*ENV<FREEUP_WINDOW> // 10);

sub minimum-platforms (@arrivals, @departures) {
   sub pre-massage (@input) {
      @input.map(
         {
            my ($h, $m) = .split: /\:/;
            $h * 60 + $m;
         }
      ).sort;
   }
   my @sorted-arrivals = pre-massage(@arrivals);
   my @sorted-departures = pre-massage(@departures);

   constant \beyond-last = 30 * 60 + freeup-window; # 30th hour in the day... :)
   my ($present, $min, $max) = (0, 0, 0);
   while (@sorted-arrivals || @sorted-departures) {
      my $arrival = @sorted-arrivals ?? @sorted-arrivals[0] !! beyond-last;
      my $departure = @sorted-departures ?? @sorted-departures[0] !! beyond-last;
      if $arrival <= $departure + freeup-window {
         ++$present;
         $max = $present if $present > $max;
         @sorted-arrivals.shift;
      }
      else {
         --$present;
         $min = $present if $present < $min;
         @sorted-departures.shift;
      }
   }
   return $max - $min;
}

sub MAIN ($arrivals = '10:20 11:00 11:10 12:20 16:20 19:00 22:00 22:10 22:20 22:30',
          $departures = '08:00 08:30 10:15 10:30 10:50 13:20 12:40 12:50 20:20 22:25') {
   put minimum-platforms($arrivals.split(/\s+/), $departures.split(/\s+/));
}
