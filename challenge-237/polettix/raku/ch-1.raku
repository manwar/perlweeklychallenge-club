#!/usr/bin/env raku
use v6;
sub MAIN (Int $year, Int $month, Int $weekday_in_month, Int $weekday) {
   my $date = Date.new(year => $year, month => $month, day => 1);

   # how much should we advance to find the first occurrence of the
   # target $weekday?
   my $delta = ($weekday + 7 - $date.day-of-week) % 7;

   # advance that much to land on the first, then additional weeks to
   # land on the target $weekday_in_month
   $date += $delta + ($weekday_in_month - 1) * 7;

   # print the result making sure it's still in the same year & month
   put($date.year == $year && $date.month == $month ?? $date.day !! 0);
}
