#!/usr/bin/env perl
=begin comment
------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-10-02
Challenge 237 Task 01 Seize the Day ( Perl )
-----------------------------------------
=cut
use v5.38;
use Date::Simple (':all');

my $year = sprintf("%02d",$ARGV[0]);
my $month = sprintf("%02d",$ARGV[1]);
my $weekday_of_month = sprintf("%02d",$ARGV[2]);
my $day_of_week = $ARGV[3];
my $cnt = 0;
my $fnd = 0;

say "Input: Year = $year, Month = $month, Weekday of month = $weekday_of_month, day of week = $day_of_week";

for (my $d = 1; $d < 31; $d++) {
    $d = sprintf("%02d",$d);
    my $s = "$year-$month-$d";
    my $date  = Date::Simple->new($s);
    my $dow = $date->day_of_week();
    if ($dow == $day_of_week){
        $cnt++;
        if ($cnt == $weekday_of_month) {
            say "Output: ",substr($s,8,2);
            $fnd++;
            last;
        }
    }
}

if ($fnd == 0) {
    say "Output: 0";
}

=begin comment
------------------------------------------
SAMPLE OUTPUT
perl .\SeizeDay.pl 2024 4 3 2

Input: Year = 2024, Month = 04, Weekday of month = 03, day of week = 2
Output: 16

perl .\SeizeDay.pl 2025 10 2 4

Input: Year = 2025, Month = 10, Weekday of month = 02, day of week = 4
Output: 09

perl .\SeizeDay.pl 2026 8 5 3

Input: Year = 2026, Month = 08, Weekday of month = 05, day of week = 3
Output: 0
-----------------------------------------
=cut




