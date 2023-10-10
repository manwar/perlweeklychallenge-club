#! /usr/bin/env raku

unit sub MAIN (Int $year, Int $month, Int $weekday-of-month, Int $day-of-week, :v(:$verbose));

my @days = "", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday";

my $d = Date.new($year, $month, 1);

say ":The first day in the month: $d" if $verbose;

my $dow = $d.day-of-week;

$d = $d.later(days => abs($day-of-week - $dow)) if $dow != $day-of-week;

say ":The first @days[$day-of-week] in the month: $d" if $verbose;

$d = $d.later(weeks => $weekday-of-month -1);

say ":The { $weekday-of-month }{ $weekday-of-month == 1 ?? "st" !! "nd" } @days[$day-of-week] in the month: $d" if $verbose;

say $d.month == $month
  ?? $d.day
  !! 0;
