#!/usr/bin/env perl
# Perl weekly challenge 227
# Task 1:  Friday 13th
#
# See https://wlmb.github.io/2023/07/24/PWC227/#task-1-friday-13th
use v5.36;
use PDL;
my $days_to_month=pdl[[0,3,3,6,1,4,6,2,5,0,3,5], # days to start of month nonleap and leap
	              [0,3,4,0,2,5,0,3,6,1,4,6]];
die <<~"FIN" unless @ARGV;
    Usage: $0 Y1 [Y2...]
    to find how many Friday 13 are in the years Y1, Y2...
    FIN
for(@ARGV){
    my $year=$_%400; # Cycle repeats after 400 years
    my $previous_leaps=(floor(($year+3)/4)-floor(($year+3)/100))%7; # Leap years before start of given year
    my $start=($year+$previous_leaps)%7; # starting weekday of year, counting from saturday=0
    my $given_is_leap=($year==0 || ($year%100!=0 && $year%4==0))||0;
    my $begginings=($days_to_month->slice("",[$given_is_leap,0,0])+$start)%7;
    say "$_->", ($begginings==1)->sumover;
}
