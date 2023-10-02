#!/usr/bin/env perl
# Perl weekly challenge 237
# Task 1:  Seize The Day
#
# See https://wlmb.github.io/2023/10/01/PWC237/#task-1-seize-the-day
use v5.36;
use experimental qw(for_list);
use PDL;
die <<~"FIN" unless @ARGV && @ARGV%4==0;
    Usage: $0 Y1 M1 W1 D1 [Y2 M2 W2 D2...]
    to find the number corresponding to day Dn of week (1=Monday),
    weekday of month Wn, month Mn, year Yn
    FIN
my $days_of_month=pdl[[31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31],    # length of months
                      [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]];   # nonleap and leap
my $days_to_month=pdl[[0,3,3,6,1,4,6,2,5,0,3,5], # days to start of month nonleap and leap mod7
                      [0,3,4,0,2,5,0,3,6,1,4,6]];
my @ordinal=qw(first second third fourth fifth);
my @day_name=qw(Sunday Monday Tuesday Wednesday Thursday Friday Saturday);
my @month_name=qw(January February March April May June
		  July August September October November Dececmber);
for my($year, $month, $weekday, $day_of_week) (@ARGV){
    warn "Weekday should be between 1 and 5: $weekday", next unless 1<=$weekday<=5;
    warn "Day of week should be between 1 (Mon) and 7 (Sun): $day_of_week", next
	unless 1<=$day_of_week<=7;
    warn "Month should be between 1 and 12", next unless 1<=$month<=12;
    --$_ for $weekday, $month; # start at 0
    $day_of_week%=7; # Sun is now 0
    my $reduced_year=$year%400; # Cycle repeats after 400 years
    my $previous_leaps=(floor(($reduced_year+3)/4)
			-floor(($reduced_year+3)/100))%7; # Leap years before start of given year
    my $start=($reduced_year+$previous_leaps+6)%7; # starting day of week of year, counting from sunday==0
    my $given_is_leap=($reduced_year==0 || ($reduced_year%100!=0 && $reduced_year%4==0))||0;
    my $beggining=($days_to_month->at($month, $given_is_leap)+$start)%7; # first day of week of month
    my $day=1+($day_of_week-$beggining)%7+$weekday*7;            # desired date
    $day=0 if $day>$days_of_month->at($month,$given_is_leap);    # check it lies within month
    say "The $ordinal[$weekday] $day_name[$day_of_week] of $month_name[$month] in $year is $day";
}
