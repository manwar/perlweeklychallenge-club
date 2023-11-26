#!/usr/bin/env raku
=begin comment
------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-10-02
Challenge 237 Task 01 Seize the Day ( Raku )
-----------------------------------------
=end comment

my $cnt = 0;
my $fnd = 0;

sub MAIN ( $year, $mnth, $wom, $dow) {
    my $month = sprintf("%02d",$mnth);
    my $weekday_of_month = sprintf("%02d", $wom);
    my $day_of_week = sprintf("%02d",$dow);
    my $days_in_month = Date.new("$year-$month-01").days-in-month;
    say "Input: Year = $year, Month = $month, Weekday of month = $weekday_of_month, day of week = $day_of_week";

    loop (my $d = 1; $d <= $days_in_month; $d++) {
        $d = sprintf("%02d",$d);
        my $s = "$year-$month-$d";
        my $day_of_week = Date.new("$year-$month-$d").day-of-week;
        if $dow == $day_of_week {
            $cnt++;
            if $cnt == $weekday_of_month {
                say "Output: ",substr($s,8,2);
                $fnd++;
                last;
            }
        }
    }
    if ($fnd == 0) {
        say "Output: 0";
    }
}

=begin comment
------------------------------------------
SAMPLE OUTPUT
raku .\SeizeDay.rk 2024 4 3 2

Input: Year = 2024, Month = 04, Weekday of month = 03, day of week = 02
Output: 16

raku .\SeizeDay.rk 2025 10 2 4

Input: Year = 2025, Month = 10, Weekday of month = 02, day of week = 04
Output: 09

raku .\SeizeDay.rk 2026 8 5 3

Input: Year = 2026, Month = 08, Weekday of month = 05, day of week = 03
Output: 0
-----------------------------------------
=end comment



