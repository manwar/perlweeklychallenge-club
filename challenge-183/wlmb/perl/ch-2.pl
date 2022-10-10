#!/usr/bin/env perl
# Perl weekly challenge 183
# Task 2:  Date Difference
#
# See https://wlmb.github.io/2022/09/20/PWC183/#task-2-date-difference
use v5.36;
use experimental qw(try for_list);
use DateTime;
use Date::Parse;
die <<FIN unless @ARGV and @ARGV%2==0;
Usage: $0 D1 D2 ...
Print the date difference between dates D1 and D2, each in the format YYYY-MM-DD.
Additional pairs of dates may be added;
FIN

for my ($date1, $date2)(@ARGV){
    try {
         my ($dt1, $dt2)=map {DateTime->from_epoch($_)} # ordered datetimes
	                 sort {$a<=>$b}
		         map {str2time($_)//die "Wrong date: $_"} ($date1, $date2);
         my $years=$dt2->subtract_datetime($dt1)->years; # year difference
	 $dt2->subtract(years=>$years); # reduce difference to within a year
	 my $days=$dt2->delta_days($dt1)->in_units("days"); # remaining days
	 my $years_name=$years==1?"year":"years"; # singular or plural
	 my $days_name=$days==1?"day":"days";
	 say "The difference between $date1 and $date2 is $years $years_name and $days $days_name";
    }
    catch($m){
        say "Failed with $date1 and $date2\n$m";
    }
}
