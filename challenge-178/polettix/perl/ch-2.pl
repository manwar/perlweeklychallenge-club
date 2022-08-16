#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use Time::Local 'timegm';

my $ts       = shift // '2022-08-01 10:30';
my $duration = shift // 4;
say add_bh($ts, $duration);

sub parse_datetime ($dt) {
   my $error = "invalid input timestamp <$dt>\n";
   my ($y, $m, $d, $H, $M) = $dt =~ m{
      \A (\d+) - (\d\d) - (\d\d) \  (\d\d):(\d\d) \z
   }mxs or die $error;
   die $error unless eval {
      timegm(0, $M, $H, $d, $m - 1, $y);
      1;
   };
   return [ $y, $m, $d, $H, $M ];
}

sub add_bh ($timestamp, $duration) {
   state $sod_min =  9 * 60;
   state $eod_min = 18 * 60;
   my $duration_min = int($duration * 60); # in minutes, rounded down

   my $dt = parse_datetime($timestamp);

   # cope with the possibility that the provided timestamp is
   # *outside* the allowed range, move to the beginning of the
   # next business day
   $dt = next_business_day_start($dt) unless is_in_business($dt);
   my $start_min = $dt->[3] * 60 + $dt->[4];

   while ($duration_min > 0) {
      my $available_min = $eod_min - $start_min;
      if ($duration_min >= $available_min) {
         $dt = next_business_day_start($dt);
         $duration_min -= $available_min;
         $start_min = $sod_min;
      }
      else { # we're in the very day!
         my $stop_min = $start_min + $duration_min;
         $dt->[4] = my $M = $stop_min % 60;
         $dt->[3] = ($stop_min - $M) / 60;
         $duration_min = 0;
      }
   }

   return sprintf '%04d-%02d-%02d %02d:%02d', $dt->@*;
}

sub is_in_business ($dt) {
   my ($y, $m, $d, $H, $M) = $dt->@*;
   return if $H < 9 || $H > 17; # 18:00 is out ;)
   my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) =
     gmtime(timegm(0, $M, $H, $d, $m - 1, $y));
   return (0 < $wday && $wday < 6);
} ## end sub is_in_business ($dt)

sub next_business_day_start ($dt) {
   state $day_s = 24 * 60 * 60;
   my ($y, $m, $d) = $dt->@*;
   while ('necessary') {
      my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) =
         gmtime($day_s + timegm(0, 30, 12, $d, $m - 1, $y));
      $year += 1900;
      ++$mon;
      return [$year, $mon, $mday, 9, 0]
         if 0 < $wday && $wday < 6;
      ($y, $m, $d) = ($year, $mon, $mday);
   }
}
