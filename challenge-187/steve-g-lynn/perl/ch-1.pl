#!/usr/bin/env perl
use strict;
use warnings;

use Date::Calc qw(Delta_Days);

print &days_together('12-01','20-01','15-01','18-01'),"\n";
#4
print &days_together('02-03','12-03','13-03','14-03'),"\n";
#0
print &days_together('02-03','12-03','11-03','15-03'),"\n";
#2
print &days_together('30-03','05-04','28-03','02-04'),"\n";
#4

sub days_together {
    my ($foo_sd, $foo_ed, $bar_sd, $bar_ed)=@_;
    
    #-- get the later start date
    my @later_start = &later( 
        &parse_datestring( $foo_sd ),
        &parse_datestring( $bar_sd )
    );
    
    #-- get the earlier end date
    my @earlier_end = &earlier(
        &parse_datestring( $foo_ed ),
        &parse_datestring( $bar_ed )
    );
    
    #-- get time between later start date and earlier end date
    #-- add 1 to Delta_Days output to include both dates
    #-- return 0 if the time is negative
    
    my $retval=Delta_Days(2022,@later_start,2022,@earlier_end);
    ($retval >= 0) ?
        (return $retval+1) :
        (return 0); 
}

sub parse_datestring {
    my ($datestring)=@_;
    my ($day,$month)=split(/-/,$datestring);
    return ($month,$day);
}

sub earlier {
    my ($month1, $day1, $month2, $day2) = @_;
    (Delta_Days(2022,$month1,$day1,2022,$month2,$day2) > 0) ?
        (return ($month1,$day1)) :
        (return ($month2,$day2));
}

sub later {
    my ($month1, $day1, $month2, $day2) = @_;
    (Delta_Days(2022,$month1,$day1,2022,$month2,$day2) > 0) ?
        (return ($month2,$day2)) :
        (return ($month1,$day1));
}

