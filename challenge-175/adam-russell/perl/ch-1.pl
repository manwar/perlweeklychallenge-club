use strict;
use warnings;
##
# Write a script to list the last sunday of every month in the given year.
##
use Time::Piece; 

sub last_sunday_month{
    my($month, $year) = @_;
    $month = "0$month" if $month < 10;
    my $sunday;
    my $t = Time::Piece->strptime("$month", "%m");   
    for my $day (20 .. $t->month_last_day()){
        $t = Time::Piece->strptime("$day $month $year", "%d %m %Y");
        $sunday = "$year-$month-$day" if $t->wday == 1;
    }  
    return $sunday;  
}

sub last_sunday{
    my($year) = @_;
    my @sundays; 
    for my $month (1 .. 12){
        push @sundays, last_sunday_month($month, $year);  
    }
    return @sundays;   
}

MAIN:{
    print join("\n", last_sunday(2022)) . "\n"; 
} 
