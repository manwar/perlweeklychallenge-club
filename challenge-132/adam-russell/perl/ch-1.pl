use strict;
use warnings;
##
# You are given a date (yyyy/mm/dd).
# Assuming, the given date is your date of birth. 
# Write a script to find the mirror dates of the given date.
##
use Time::Piece;
use Time::Seconds;

sub mirror_dates{
    my($date_string, $start_date_string) = @_;
    my $date = Time::Piece->strptime($date_string, q[%Y/%m/%e]);
    my $today;
    if($start_date_string){
        $today = Time::Piece->strptime($start_date_string, q[%Y/%m/%e]);
    }
    else{
        $today = localtime;
    }
    my $age = $today - $date;
    my $past = $date - $age; 
    my $future = $today + $age;
    return $past->strftime(q[%Y/%m/%d]), $future->strftime(q[%Y/%m/%d]);
}

MAIN:{
    my($past, $future);
    ($past, $future) = mirror_dates("2021/09/18", "2021/09/22");
    print "$past, $future\n";
    ($past, $future) = mirror_dates("1975/10/10", "2021/09/22");
    print "$past, $future\n";
    ($past, $future) = mirror_dates("1967/02/14", "2021/09/22");
    print "$past, $future\n";
    
    ($past, $future) = mirror_dates("2021/09/18");
    print "$past, $future\n";
    ($past, $future) = mirror_dates("1975/10/10");
    print "$past, $future\n";
    ($past, $future) = mirror_dates("1967/02/14");
    print "$past, $future\n";
}