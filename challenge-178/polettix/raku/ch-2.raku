#!/usr/bin/env raku
use v6;

sub MAIN ($ts = '2022-08-01 10:30', $duration = 4) {
   put add-bh($ts, $duration);
}

sub parse_datetime ($dt) {
   my $error = "invalid input timestamp <$dt>\n";
   my $match = $dt ~~ /
      ^ (\d+) '-' (\d\d) '-' (\d\d) ' ' (\d\d) ':' (\d\d) $
   / or die $error;
   my ($y, $m, $d, $H, $M) = $match[0..4].map({0 + $_});
   try {
      CATCH {
         default { die $error }
      }
      return DateTime.new(year => $y, month => $m, day => $d,
         hour => $H, minute => $M);
   }
}

sub is-in-business ($dt) {
   return (
      (9 <= $dt.hour < 18) # 18:00 is out ;)
      &&  (1 <= $dt.day-of-week <= 5)
   );
} ## end sub is_in_business ($dt)

sub next-business-day-start ($dt is copy) {
   loop {
      $dt = $dt.clone(hour => 9, minute => 0).later(day => 1);
      return $dt if (1 <= $dt.day-of-week <= 5);
   }
}

sub add-bh ($timestamp, $duration) {
   state $sod_min =  9 * 60;
   state $eod_min = 18 * 60;
   my $duration_min = ($duration * 60).Int; # in minutes, rounded down

   my $dt = parse_datetime($timestamp);

   # cope with the possibility that the provided timestamp is
   # *outside* the allowed range, move to the beginning of the
   # next business day
   $dt = next-business-day-start($dt) unless is-in-business($dt);
   my $start_min = $dt.hour * 60 + $dt.minute;

   while $duration_min > 0 {
      my $available_min = $eod_min - $start_min;
      if ($duration_min >= $available_min) {
         $dt = next-business-day-start($dt);
         $duration_min -= $available_min;
         $start_min = $sod_min;
      }
      else { # we're in the very day!
         my $stop_min = $start_min + $duration_min;
         my $M = $stop_min % 60;
         my $H = ($stop_min - $M) / 60;
         $dt = $dt.clone(hour => $H, minute => $M);
         $duration_min = 0;
      }
   }

   return '%04d-%02d-%02d %02d:%02d'.sprintf(
      $dt.year, $dt.month, $dt.day, $dt.hour, $dt.minute);
}
