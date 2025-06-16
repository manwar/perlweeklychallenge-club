#!/usr/bin/env perl
# Perl weekly challenge 326
# Task 1:  Day of the Year
#
# See https://wlmb.github.io/2025/06/16/PWC326/#task-1-day-of-the-year
use v5.36;
use List::Util qw(reductions);
die <<~"FIN" unless @ARGV;
    Usage: $0 D1 D2...
    to find the day number corresponding to the ISO dates D1, D2.
    FIN
my @days_in_month=(0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
my @offsets=(0, reductions {$a+$b} @days_in_month);
for(@ARGV){
    say("Wrong format: $_"), next unless /^(\d{4})-(\d{2})-(\d{2})$/;
    my ($year, $month, $day_of_month)=($1, $2, $3);
    say("Wrong month: $_"), next unless 1 <= $month <= 12;
    say("Wrong day: $_"), next
	unless 1 <= $day_of_month
	    && ($day_of_month <= $days_in_month[$month] || $month == 2 && $day_of_month <= 29);
    my $leap=$year%4==0;
    $leap=0 if $year%100 == 0;
    $leap=1 if $year%400 == 0;
    my $day_of_year = $offsets[$month] + $day_of_month;
    ++$day_of_year if $leap and $month >= 3;
    say "$_ -> $day_of_year";
}
